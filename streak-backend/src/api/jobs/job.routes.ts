import { Router } from 'express';
import { jobController } from './job.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import { authenticate, authorize, optionalAuth } from '../../core/middlewares/auth.middleware';
import { UserRole } from '../users/user.model';
import { CreateJobDTO, UpdateJobDTO, AssignFreelancerDTO } from './job.dto';

const router = Router();

/**
 * @route   GET /api/jobs/recommended
 * @desc    Obtener jobs recomendados para el freelancer
 * @access  Private (Freelancer)
 */
router.get(
  '/recommended',
  authenticate,
  authorize(UserRole.FREELANCER),
  jobController.getRecommendedJobs.bind(jobController)
);

/**
 * @route   GET /api/jobs
 * @desc    Listar jobs con filtros
 * @access  Public
 */
router.get(
  '/',
  optionalAuth,
  // validateRequest(GetJobsQueryDTO, 'query'), // Temporalmente deshabilitado para evitar errores
  jobController.getJobs.bind(jobController)
);

/**
 * @route   POST /api/jobs
 * @desc    Crear nuevo job
 * @access  Private (Client)
 */
router.post(
  '/',
  authenticate,
  authorize(UserRole.CLIENT, UserRole.ADMIN),
  validateRequest(CreateJobDTO),
  jobController.createJob.bind(jobController)
);

/**
 * @route   GET /api/jobs/:id
 * @desc    Obtener job por ID
 * @access  Public
 */
router.get('/:id', optionalAuth, jobController.getJobById.bind(jobController));

/**
 * @route   PUT /api/jobs/:id
 * @desc    Actualizar job
 * @access  Private (Owner)
 */
router.put(
  '/:id',
  authenticate,
  validateRequest(UpdateJobDTO),
  jobController.updateJob.bind(jobController)
);

/**
 * @route   POST /api/jobs/:id/publish
 * @desc    Publicar job (cambiar de draft a open)
 * @access  Private (Owner)
 */
router.post('/:id/publish', authenticate, jobController.publishJob.bind(jobController));

/**
 * @route   POST /api/jobs/:id/assign
 * @desc    Asignar freelancer a un job
 * @access  Private (Owner)
 */
router.post(
  '/:id/assign',
  authenticate,
  validateRequest(AssignFreelancerDTO),
  jobController.assignFreelancer.bind(jobController)
);

/**
 * @route   POST /api/jobs/:id/complete
 * @desc    Completar job
 * @access  Private (Owner)
 */
router.post('/:id/complete', authenticate, jobController.completeJob.bind(jobController));

/**
 * @route   POST /api/jobs/:id/cancel
 * @desc    Cancelar job
 * @access  Private (Owner)
 */
router.post('/:id/cancel', authenticate, jobController.cancelJob.bind(jobController));

/**
 * @route   DELETE /api/jobs/:id
 * @desc    Eliminar job
 * @access  Private (Owner)
 */
router.delete('/:id', authenticate, jobController.deleteJob.bind(jobController));

/**
 * @route   POST /api/jobs/:id/save
 * @desc    Guardar job
 * @access  Private
 */
router.post('/:id/save', authenticate, jobController.saveJob.bind(jobController));

/**
 * @route   DELETE /api/jobs/:id/save
 * @desc    Quitar job de guardados
 * @access  Private
 */
router.delete('/:id/save', authenticate, jobController.unsaveJob.bind(jobController));

export default router;
