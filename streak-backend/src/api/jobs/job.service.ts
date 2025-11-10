import mongoose from 'mongoose';
import { Job, IJob, JobStatus } from './job.model';
import {
  CreateJobInput,
  UpdateJobInput,
  GetJobsQueryInput,
  AssignFreelancerInput,
} from './job.dto';
import { NotFoundError, ForbiddenError, AppError } from '../../core/middlewares/errorHandler';
import { User } from '../users/user.model';

/**
 * Servicio de Jobs
 */
export class JobService {
  /**
   * Crear nuevo job
   */
  async createJob(clientId: string, data: CreateJobInput): Promise<IJob> {
    const job = await Job.create({
      ...data,
      clientId,
      status: JobStatus.DRAFT,
    });

    // Incrementar contador de jobs posteados del cliente
    await User.findByIdAndUpdate(clientId, {
      $inc: { 'stats.jobsPosted': 1 },
    });

    return job.populate('clientId');
  }

  /**
   * Obtener job por ID
   */
  async getJobById(jobId: string, incrementView = false): Promise<IJob> {
    const job = await Job.findById(jobId)
      .populate('clientId', 'profile email role stats')
      .populate('assignedFreelancerId', 'profile email role stats');

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    // Incrementar vistas si se solicita
    if (incrementView) {
      job.stats.views += 1;
      await job.save();
    }

    return job;
  }

  /**
   * Listar jobs con filtros
   */
  async getJobs(query: GetJobsQueryInput) {
    const {
      page,
      limit,
      status,
      category,
      type,
      experienceLevel,
      // minBudget,
      // maxBudget,
      skills,
      search,
      clientId,
      isUrgent,
      sortBy,
      sortOrder,
    } = query;

    // Construir filtros
    const filter: Record<string, unknown> = {};

    if (status) {
      filter.status = status;
    }

    if (category) {
      filter.category = category;
    }

    if (type) {
      filter.type = type;
    }

    if (experienceLevel) {
      filter.experienceLevel = experienceLevel;
    }

    // if (minBudget !== undefined || maxBudget !== undefined) {
    //   filter.budget = {};
    //   if (minBudget !== undefined) (filter.budget as Record<string, unknown>).$gte = minBudget;
    //   if (maxBudget !== undefined) (filter.budget as Record<string, unknown>).$lte = maxBudget;
    // }

    if (skills) {
      const skillsArray = skills.split(',').map((s) => s.trim());
      filter.skillsRequired = { $in: skillsArray };
    }

    if (search) {
      filter.$or = [
        { title: { $regex: search, $options: 'i' } },
        { description: { $regex: search, $options: 'i' } },
        { category: { $regex: search, $options: 'i' } },
      ];
    }

    if (clientId) {
      filter.clientId = clientId;
    }

    if (isUrgent !== undefined) {
      filter.isUrgent = isUrgent;
    }

    // Calcular skip
    const skip = (Number(page) - 1) * Number(limit);

    // Ordenamiento
    const sort: Record<string, 1 | -1> = {
      [sortBy]: sortOrder === 'asc' ? 1 : -1,
    };

    // Ejecutar query
    const [jobs, total] = await Promise.all([
      Job.find(filter)
        .sort(sort)
        .skip(skip)
        .limit(Number(limit))
        .populate('clientId', 'profile email stats'),
      Job.countDocuments(filter),
    ]);

    return {
      jobs,
      total,
      page: Number(page),
      limit: Number(limit),
      totalPages: Math.ceil(total / Number(limit)),
    };
  }

  /**
   * Actualizar job
   */
  async updateJob(jobId: string, userId: string, data: UpdateJobInput): Promise<IJob> {
    const job = await Job.findById(jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    // Verificar que el usuario sea el cliente del job
    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para actualizar este trabajo');
    }

    // No permitir actualizar si el job ya está completado o cancelado
    if (job.status === JobStatus.COMPLETED || job.status === JobStatus.CANCELLED) {
      throw new AppError(
        400,
        'CANNOT_UPDATE_JOB',
        'No se puede actualizar un trabajo completado o cancelado'
      );
    }

    // Actualizar campos
    Object.assign(job, data);
    await job.save();

    return job.populate('clientId');
  }

  /**
   * Publicar job (cambiar de draft a open)
   */
  async publishJob(jobId: string, userId: string): Promise<IJob> {
    const job = await Job.findById(jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para publicar este trabajo');
    }

    if (job.status !== JobStatus.DRAFT) {
      throw new AppError(
        400,
        'CANNOT_PUBLISH_JOB',
        'Solo se pueden publicar trabajos en estado draft'
      );
    }

    job.status = JobStatus.OPEN;
    await job.save();

    return job.populate('clientId');
  }

  /**
   * Asignar freelancer a un job
   */
  async assignFreelancer(
    jobId: string,
    userId: string,
    data: AssignFreelancerInput
  ): Promise<IJob> {
    const job = await Job.findById(jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para asignar este trabajo');
    }

    if (job.status !== JobStatus.OPEN) {
      throw new AppError(
        400,
        'CANNOT_ASSIGN_JOB',
        'Solo se pueden asignar trabajos en estado abierto'
      );
    }

    // Verificar que el freelancer exista
    const freelancer = await User.findById(data.freelancerId);
    if (!freelancer || freelancer.role !== 'freelancer') {
      throw new AppError(400, 'INVALID_FREELANCER', 'El freelancer especificado no es válido');
    }

    job.assignedFreelancerId = freelancer._id as mongoose.Types.ObjectId;
    job.status = JobStatus.IN_PROGRESS;
    job.startDate = new Date();
    await job.save();

    return job.populate(['clientId', 'assignedFreelancerId']);
  }

  /**
   * Completar job
   */
  async completeJob(jobId: string, userId: string): Promise<IJob> {
    const job = await Job.findById(jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para completar este trabajo');
    }

    if (job.status !== JobStatus.IN_PROGRESS) {
      throw new AppError(
        400,
        'CANNOT_COMPLETE_JOB',
        'Solo se pueden completar trabajos en progreso'
      );
    }

    job.status = JobStatus.COMPLETED;
    job.completionDate = new Date();
    await job.save();

    // Incrementar contador de jobs completados para cliente y freelancer
    await Promise.all([
      User.findByIdAndUpdate(job.clientId, { $inc: { 'stats.jobsCompleted': 1 } }),
      User.findByIdAndUpdate(job.assignedFreelancerId, { $inc: { 'stats.jobsCompleted': 1 } }),
    ]);

    return job.populate(['clientId', 'assignedFreelancerId']);
  }

  /**
   * Cancelar job
   */
  async cancelJob(jobId: string, userId: string): Promise<IJob> {
    const job = await Job.findById(jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para cancelar este trabajo');
    }

    if (job.status === JobStatus.COMPLETED) {
      throw new AppError(400, 'CANNOT_CANCEL_JOB', 'No se puede cancelar un trabajo completado');
    }

    job.status = JobStatus.CANCELLED;
    await job.save();

    return job.populate('clientId');
  }

  /**
   * Eliminar job
   */
  async deleteJob(jobId: string, userId: string): Promise<void> {
    const job = await Job.findById(jobId);

    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    if (job.clientId.toString() !== userId) {
      throw new ForbiddenError('No tienes permiso para eliminar este trabajo');
    }

    // Solo permitir eliminar drafts
    if (job.status !== JobStatus.DRAFT) {
      throw new AppError(
        400,
        'CANNOT_DELETE_JOB',
        'Solo se pueden eliminar trabajos en estado draft'
      );
    }

    await Job.findByIdAndDelete(jobId);
  }

  /**
   * Buscar jobs recomendados para un freelancer
   */
  async getRecommendedJobs(freelancerId: string, limit = 10): Promise<IJob[]> {
    const freelancer = await User.findById(freelancerId);

    if (!freelancer || !freelancer.freelancerProfile) {
      return [];
    }

    const skills = freelancer.freelancerProfile.skills || [];

    const jobs = await Job.find({
      status: JobStatus.OPEN,
      skillsRequired: { $in: skills },
    })
      .sort({ createdAt: -1 })
      .limit(limit)
      .populate('clientId', 'profile email stats');

    return jobs;
  }

  /**
   * Guardar job
   */
  async saveJob(jobId: string, userId: string): Promise<void> {
    const job = await Job.findById(jobId);
    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    // Verificar que el usuario no sea el cliente del job
    if (job.clientId.toString() === userId) {
      throw new AppError(400, 'CANNOT_SAVE_OWN_JOB', 'No puedes guardar tu propio trabajo');
    }

    // Incrementar contador de guardados
    await Job.findByIdAndUpdate(jobId, {
      $inc: { 'stats.savedCount': 1 },
    });
  }

  /**
   * Quitar job de guardados
   */
  async unsaveJob(jobId: string, _userId: string): Promise<void> {
    const job = await Job.findById(jobId);
    if (!job) {
      throw new NotFoundError('Trabajo no encontrado');
    }

    // Decrementar contador de guardados (no puede ser negativo)
    await Job.findByIdAndUpdate(
      jobId,
      {
        $inc: { 'stats.savedCount': -1 },
      },
      {
        $expr: { $gte: ['$stats.savedCount', 0] },
      }
    );
  }
}

export const jobService = new JobService();
