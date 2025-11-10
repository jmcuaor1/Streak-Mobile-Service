import { Request, Response, NextFunction } from 'express';
import { jobService } from './job.service';
import { sendSuccess, sendPaginated } from '../../core/utils/response.utils';
import {
  CreateJobInput,
  UpdateJobInput,
  GetJobsQueryInput,
  AssignFreelancerInput,
} from './job.dto';

/**
 * Controlador de Jobs
 */
export class JobController {
  /**
   * @route   POST /api/jobs
   * @desc    Crear nuevo job
   * @access  Private (Client)
   */
  async createJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;
      const data: CreateJobInput = req.body;

      const job = await jobService.createJob(userId, data);

      res.status(201);
      sendSuccess(res, {
        message: 'Trabajo creado exitosamente',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/jobs
   * @desc    Listar jobs con filtros
   * @access  Public
   */
  async getJobs(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const query: GetJobsQueryInput = req.query as unknown as GetJobsQueryInput;

      const result = await jobService.getJobs(query);

      sendPaginated(res, {
        message: 'Trabajos obtenidos exitosamente',
        data: result.jobs,
        pagination: {
          page: result.page,
          limit: result.limit,
          total: result.total,
          totalPages: result.totalPages,
        },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/jobs/recommended
   * @desc    Obtener jobs recomendados para el freelancer
   * @access  Private (Freelancer)
   */
  async getRecommendedJobs(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;
      const limit = req.query.limit ? Number(req.query.limit) : 10;

      const jobs = await jobService.getRecommendedJobs(userId, limit);

      sendSuccess(res, {
        message: 'Trabajos recomendados obtenidos',
        data: { jobs },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/jobs/:id
   * @desc    Obtener job por ID
   * @access  Public
   */
  async getJobById(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const incrementView = req.query.incrementView === 'true';

      const job = await jobService.getJobById(id, incrementView);

      sendSuccess(res, {
        message: 'Trabajo obtenido exitosamente',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   PUT /api/jobs/:id
   * @desc    Actualizar job
   * @access  Private (Owner)
   */
  async updateJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;
      const data: UpdateJobInput = req.body;

      const job = await jobService.updateJob(id, userId, data);

      sendSuccess(res, {
        message: 'Trabajo actualizado exitosamente',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/jobs/:id/publish
   * @desc    Publicar job
   * @access  Private (Owner)
   */
  async publishJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      const job = await jobService.publishJob(id, userId);

      sendSuccess(res, {
        message: 'Trabajo publicado exitosamente',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/jobs/:id/assign
   * @desc    Asignar freelancer a un job
   * @access  Private (Owner)
   */
  async assignFreelancer(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;
      const data: AssignFreelancerInput = req.body;

      const job = await jobService.assignFreelancer(id, userId, data);

      sendSuccess(res, {
        message: 'Freelancer asignado exitosamente',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/jobs/:id/complete
   * @desc    Completar job
   * @access  Private (Owner)
   */
  async completeJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      const job = await jobService.completeJob(id, userId);

      sendSuccess(res, {
        message: 'Trabajo completado exitosamente',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/jobs/:id/cancel
   * @desc    Cancelar job
   * @access  Private (Owner)
   */
  async cancelJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      const job = await jobService.cancelJob(id, userId);

      sendSuccess(res, {
        message: 'Trabajo cancelado',
        data: { job },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   DELETE /api/jobs/:id
   * @desc    Eliminar job
   * @access  Private (Owner)
   */
  async deleteJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      await jobService.deleteJob(id, userId);

      sendSuccess(res, {
        message: 'Trabajo eliminado exitosamente',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/jobs/:id/save
   * @desc    Guardar job
   * @access  Private
   */
  async saveJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      await jobService.saveJob(id, userId);

      sendSuccess(res, {
        message: 'Trabajo guardado exitosamente',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   DELETE /api/jobs/:id/save
   * @desc    Quitar job de guardados
   * @access  Private
   */
  async unsaveJob(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      await jobService.unsaveJob(id, userId);

      sendSuccess(res, {
        message: 'Trabajo removido de guardados',
      });
    } catch (error) {
      next(error);
    }
  }
}

export const jobController = new JobController();
