import { Request, Response, NextFunction } from 'express';
import { applicationService } from './application.service';
import { sendSuccess, sendPaginated } from '../../core/utils/response.utils';
import {
  CreateApplicationInput,
  UpdateApplicationInput,
  GetApplicationsQueryInput,
} from './application.dto';

/**
 * Controlador de Applications
 */
export class ApplicationController {
  /**
   * @route   POST /api/applications
   * @desc    Crear nueva application
   * @access  Private (Freelancer)
   */
  async createApplication(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;
      const data: CreateApplicationInput = req.body;

      const application = await applicationService.createApplication(userId, data);

      res.status(201);
      sendSuccess(res, {
        message: 'Postulación creada exitosamente',
        data: { application },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/applications
   * @desc    Listar applications con filtros
   * @access  Private
   */
  async getApplications(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const query: GetApplicationsQueryInput = req.query as unknown as GetApplicationsQueryInput;

      const result = await applicationService.getApplications(query);

      sendPaginated(res, {
        message: 'Postulaciones obtenidas exitosamente',
        data: result.applications,
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
   * @route   GET /api/applications/:id
   * @desc    Obtener application por ID
   * @access  Private
   */
  async getApplicationById(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;

      const application = await applicationService.getApplicationById(id);

      sendSuccess(res, {
        message: 'Postulación obtenida exitosamente',
        data: { application },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   PUT /api/applications/:id
   * @desc    Actualizar application
   * @access  Private (Owner)
   */
  async updateApplication(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;
      const data: UpdateApplicationInput = req.body;

      const application = await applicationService.updateApplication(id, userId, data);

      sendSuccess(res, {
        message: 'Postulación actualizada exitosamente',
        data: { application },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/applications/:id/accept
   * @desc    Aceptar application
   * @access  Private (Job Owner)
   */
  async acceptApplication(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      const application = await applicationService.acceptApplication(id, userId);

      sendSuccess(res, {
        message: 'Postulación aceptada exitosamente',
        data: { application },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/applications/:id/reject
   * @desc    Rechazar application
   * @access  Private (Job Owner)
   */
  async rejectApplication(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      const application = await applicationService.rejectApplication(id, userId);

      sendSuccess(res, {
        message: 'Postulación rechazada',
        data: { application },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/applications/:id/withdraw
   * @desc    Retirar application
   * @access  Private (Owner)
   */
  async withdrawApplication(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      const application = await applicationService.withdrawApplication(id, userId);

      sendSuccess(res, {
        message: 'Postulación retirada',
        data: { application },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   DELETE /api/applications/:id
   * @desc    Eliminar application
   * @access  Private (Owner)
   */
  async deleteApplication(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const userId = req.user!.userId;

      await applicationService.deleteApplication(id, userId);

      sendSuccess(res, {
        message: 'Postulación eliminada exitosamente',
      });
    } catch (error) {
      next(error);
    }
  }
}

export const applicationController = new ApplicationController();
