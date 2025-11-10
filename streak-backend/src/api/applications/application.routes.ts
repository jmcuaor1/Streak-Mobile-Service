import { Router } from 'express';
import { applicationController } from './application.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import { authenticate, authorize } from '../../core/middlewares/auth.middleware';
import { UserRole } from '../users/user.model';
import {
  CreateApplicationDTO,
  UpdateApplicationDTO,
  GetApplicationsQueryDTO,
} from './application.dto';

const router = Router();

/**
 * @route   GET /api/applications
 * @desc    Listar applications con filtros
 * @access  Private
 */
router.get(
  '/',
  authenticate,
  validateRequest(GetApplicationsQueryDTO, 'query'),
  applicationController.getApplications.bind(applicationController)
);

/**
 * @route   POST /api/applications
 * @desc    Crear nueva application
 * @access  Private (Freelancer)
 */
router.post(
  '/',
  authenticate,
  authorize(UserRole.FREELANCER),
  validateRequest(CreateApplicationDTO),
  applicationController.createApplication.bind(applicationController)
);

/**
 * @route   GET /api/applications/:id
 * @desc    Obtener application por ID
 * @access  Private
 */
router.get(
  '/:id',
  authenticate,
  applicationController.getApplicationById.bind(applicationController)
);

/**
 * @route   PUT /api/applications/:id
 * @desc    Actualizar application
 * @access  Private (Owner)
 */
router.put(
  '/:id',
  authenticate,
  validateRequest(UpdateApplicationDTO),
  applicationController.updateApplication.bind(applicationController)
);

/**
 * @route   POST /api/applications/:id/accept
 * @desc    Aceptar application
 * @access  Private (Job Owner)
 */
router.post(
  '/:id/accept',
  authenticate,
  applicationController.acceptApplication.bind(applicationController)
);

/**
 * @route   POST /api/applications/:id/reject
 * @desc    Rechazar application
 * @access  Private (Job Owner)
 */
router.post(
  '/:id/reject',
  authenticate,
  applicationController.rejectApplication.bind(applicationController)
);

/**
 * @route   POST /api/applications/:id/withdraw
 * @desc    Retirar application
 * @access  Private (Owner)
 */
router.post(
  '/:id/withdraw',
  authenticate,
  applicationController.withdrawApplication.bind(applicationController)
);

/**
 * @route   DELETE /api/applications/:id
 * @desc    Eliminar application
 * @access  Private (Owner)
 */
router.delete(
  '/:id',
  authenticate,
  applicationController.deleteApplication.bind(applicationController)
);

export default router;
