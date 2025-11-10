import { Application, IApplication, ApplicationStatus } from './application.model';
import {
  CreateApplicationInput,
  UpdateApplicationInput,
  GetApplicationsQueryInput,
} from './application.dto';
import { NotFoundError, ForbiddenError, AppError } from '../../core/middlewares/errorHandler';
import { Job, JobStatus } from '../jobs/job.model';

/**
 * Servicio de Applications
 */
export class ApplicationService {
  /**
   * Crear nueva application
   */
  async createApplication(
    freelancerId: string,
    data: CreateApplicationInput
  ): Promise<IApplication> {
    // Verificar que el job exista y esté abierto
    const job = await Job.findById(data.jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    if (job.status !== JobStatus.OPEN) {
      throw new AppError(400, 'JOB_NOT_OPEN', 'Solo puedes postularte a trabajos abiertos');
    }

    // Verificar que el freelancer no sea el cliente del job
    if (job.clientId.toString() === freelancerId) {
      throw new AppError(400, 'CANNOT_APPLY_OWN_JOB', 'No puedes postularte a tu propio trabajo');
    }

    // Verificar que no haya postulado ya
    const existingApplication = await Application.findOne({
      jobId: data.jobId,
      freelancerId,
    });

    if (existingApplication) {
      throw new AppError(409, 'ALREADY_APPLIED', 'Ya has postulado a este trabajo');
    }

    // Crear application
    const application = await Application.create({
      ...data,
      freelancerId,
      appliedAt: new Date(),
    });

    // Incrementar contador de aplicaciones del job
    await Job.findByIdAndUpdate(data.jobId, {
      $inc: { 'stats.applicationsCount': 1 },
    });

    return application.populate(['jobId', 'freelancerId']);
  }

  /**
   * Obtener application por ID
   */
  async getApplicationById(applicationId: string): Promise<IApplication> {
    const application = await Application.findById(applicationId)
      .populate('jobId')
      .populate('freelancerId', 'profile email role stats');

    if (!application) {
      throw new NotFoundError('Postulación no encontrada');
    }

    return application;
  }

  /**
   * Listar applications con filtros
   */
  async getApplications(query: GetApplicationsQueryInput) {
    const { page, limit, status, jobId, freelancerId, sortBy, sortOrder } = query;

    // Construir filtros
    const filter: Record<string, unknown> = {};

    if (status) {
      filter.status = status;
    }

    if (jobId) {
      filter.jobId = jobId;
    }

    if (freelancerId) {
      filter.freelancerId = freelancerId;
    }

    // Calcular skip
    const skip = (Number(page) - 1) * Number(limit);

    // Ordenamiento
    const sort: Record<string, 1 | -1> = {
      [sortBy]: sortOrder === 'asc' ? 1 : -1,
    };

    // Ejecutar query
    const [applications, total] = await Promise.all([
      Application.find(filter)
        .sort(sort)
        .skip(skip)
        .limit(Number(limit))
        .populate('jobId', 'title category budget type status')
        .populate('freelancerId', 'profile email stats'),
      Application.countDocuments(filter),
    ]);

    return {
      applications,
      total,
      page: Number(page),
      limit: Number(limit),
      totalPages: Math.ceil(total / Number(limit)),
    };
  }

  /**
   * Actualizar application (solo el freelancer puede actualizar su propia application)
   */
  async updateApplication(
    applicationId: string,
    userId: string,
    data: UpdateApplicationInput
  ): Promise<IApplication> {
    const application = await Application.findById(applicationId);

    if (!application) {
      throw new NotFoundError('Postulación no encontrada');
    }

    // Verificar que el usuario sea el freelancer de la application
    if (application.freelancerId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para actualizar esta postulación');
    }

    // Solo permitir actualizar si está pendiente
    if (application.status !== ApplicationStatus.PENDING) {
      throw new AppError(
        400,
        'CANNOT_UPDATE_APPLICATION',
        'Solo puedes actualizar postulaciones pendientes'
      );
    }

    // Actualizar campos
    Object.assign(application, data);
    await application.save();

    return application.populate(['jobId', 'freelancerId']);
  }

  /**
   * Aceptar application (solo el cliente del job puede aceptar)
   */
  async acceptApplication(applicationId: string, userId: string): Promise<IApplication> {
    const application = await Application.findById(applicationId).populate('jobId');

    if (!application) {
      throw new NotFoundError('Postulación no encontrada');
    }

    const job = application.jobId as unknown as {
      clientId: { toString: () => string };
      status: string;
    };

    // Verificar que el usuario sea el cliente del job
    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para aceptar esta postulación');
    }

    // Verificar que el job esté abierto
    if (job.status !== JobStatus.OPEN) {
      throw new AppError(
        400,
        'JOB_NOT_OPEN',
        'Solo puedes aceptar postulaciones de trabajos abiertos'
      );
    }

    // Verificar que la aplicación esté pendiente
    if (application.status !== ApplicationStatus.PENDING) {
      throw new AppError(
        400,
        'APPLICATION_NOT_PENDING',
        'Solo puedes aceptar postulaciones pendientes'
      );
    }

    // Aceptar application
    application.status = ApplicationStatus.ACCEPTED;
    application.respondedAt = new Date();
    await application.save();

    // Rechazar todas las demás applications del job
    await Application.updateMany(
      {
        jobId: application.jobId,
        _id: { $ne: applicationId },
        status: ApplicationStatus.PENDING,
      },
      {
        $set: {
          status: ApplicationStatus.REJECTED,
          respondedAt: new Date(),
        },
      }
    );

    return application.populate(['jobId', 'freelancerId']);
  }

  /**
   * Rechazar application
   */
  async rejectApplication(applicationId: string, userId: string): Promise<IApplication> {
    const application = await Application.findById(applicationId).populate('jobId');

    if (!application) {
      throw new NotFoundError('Postulación no encontrada');
    }

    const job = application.jobId as unknown as { clientId: { toString: () => string } };

    // Verificar que el usuario sea el cliente del job
    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para rechazar esta postulación');
    }

    // Verificar que la aplicación esté pendiente
    if (application.status !== ApplicationStatus.PENDING) {
      throw new AppError(
        400,
        'APPLICATION_NOT_PENDING',
        'Solo puedes rechazar postulaciones pendientes'
      );
    }

    application.status = ApplicationStatus.REJECTED;
    application.respondedAt = new Date();
    await application.save();

    return application.populate(['jobId', 'freelancerId']);
  }

  /**
   * Retirar application (el freelancer retira su postulación)
   */
  async withdrawApplication(applicationId: string, userId: string): Promise<IApplication> {
    const application = await Application.findById(applicationId);

    if (!application) {
      throw new NotFoundError('Postulación no encontrada');
    }

    // Verificar que el usuario sea el freelancer de la application
    if (application.freelancerId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para retirar esta postulación');
    }

    // Solo permitir retirar si está pendiente
    if (application.status !== ApplicationStatus.PENDING) {
      throw new AppError(
        400,
        'CANNOT_WITHDRAW_APPLICATION',
        'Solo puedes retirar postulaciones pendientes'
      );
    }

    application.status = ApplicationStatus.WITHDRAWN;
    await application.save();

    // Decrementar contador de aplicaciones del job
    await Job.findByIdAndUpdate(application.jobId, {
      $inc: { 'stats.applicationsCount': -1 },
    });

    return application.populate(['jobId', 'freelancerId']);
  }

  /**
   * Eliminar application
   */
  async deleteApplication(applicationId: string, userId: string): Promise<void> {
    const application = await Application.findById(applicationId);

    if (!application) {
      throw new NotFoundError('Postulación no encontrada');
    }

    // Solo el freelancer puede eliminar su propia application
    if (application.freelancerId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para eliminar esta postulación');
    }

    await Application.findByIdAndDelete(applicationId);

    // Decrementar contador de aplicaciones del job
    await Job.findByIdAndUpdate(application.jobId, {
      $inc: { 'stats.applicationsCount': -1 },
    });
  }
}

export const applicationService = new ApplicationService();
