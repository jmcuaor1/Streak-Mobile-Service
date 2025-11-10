import { Router } from 'express';
import { companyController } from './company.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import {
  authenticate,
  authorize,
  authorizeOwnerOrAdmin,
} from '../../core/middlewares/auth.middleware';
import { UserRole } from '../users/user.model';
import {
  CreateCompanyDTO,
  UpdateCompanyDTO,
  GetCompaniesQueryDTO,
  FollowCompanyDTO,
} from './company.dto';

const router = Router();

/**
 * @route   GET /api/companies
 * @desc    Obtener empresas con filtros y paginación
 * @access  Public
 */
router.get(
  '/',
  authenticate,
  validateRequest(GetCompaniesQueryDTO, 'query'),
  companyController.getCompanies.bind(companyController)
);

/**
 * @route   POST /api/companies
 * @desc    Crear nueva empresa
 * @access  Private (Client or Admin)
 */
router.post(
  '/',
  authenticate,
  authorize(UserRole.CLIENT, UserRole.ADMIN),
  validateRequest(CreateCompanyDTO),
  companyController.createCompany.bind(companyController)
);

/**
 * @route   GET /api/companies/:id
 * @desc    Obtener empresa por ID
 * @access  Public
 */
router.get('/:id', authenticate, companyController.getCompanyById.bind(companyController));

/**
 * @route   PUT /api/companies/:id
 * @desc    Actualizar empresa
 * @access  Private (Owner or Admin)
 */
router.put(
  '/:id',
  authenticate,
  authorizeOwnerOrAdmin('ownerId'),
  validateRequest(UpdateCompanyDTO),
  companyController.updateCompany.bind(companyController)
);

/**
 * @route   DELETE /api/companies/:id
 * @desc    Eliminar empresa
 * @access  Private (Owner or Admin)
 */
router.delete(
  '/:id',
  authenticate,
  authorizeOwnerOrAdmin('ownerId'),
  companyController.deleteCompany.bind(companyController)
);

/**
 * @route   POST /api/companies/:id/follow
 * @desc    Seguir empresa
 * @access  Private
 */
router.post(
  '/:id/follow',
  authenticate,
  validateRequest(FollowCompanyDTO),
  companyController.followCompany.bind(companyController)
);

/**
 * @route   DELETE /api/companies/:id/follow
 * @desc    Dejar de seguir empresa
 * @access  Private
 */
router.delete(
  '/:id/follow',
  authenticate,
  companyController.unfollowCompany.bind(companyController)
);

/**
 * @route   GET /api/companies/:id/followers
 * @desc    Obtener seguidores de la empresa
 * @access  Public
 */
router.get(
  '/:id/followers',
  authenticate,
  companyController.getCompanyFollowers.bind(companyController)
);

/**
 * @route   GET /api/companies/:id/jobs
 * @desc    Obtener trabajos de la empresa
 * @access  Public
 */
router.get('/:id/jobs', authenticate, companyController.getCompanyJobs.bind(companyController));

/**
 * @route   GET /api/companies/:id/reviews
 * @desc    Obtener reseñas de la empresa
 * @access  Public
 */
router.get(
  '/:id/reviews',
  authenticate,
  companyController.getCompanyReviews.bind(companyController)
);

/**
 * @route   POST /api/companies/:id/review
 * @desc    Crear reseña de la empresa
 * @access  Private
 */
router.post(
  '/:id/review',
  authenticate,
  companyController.createCompanyReview.bind(companyController)
);

/**
 * @route   GET /api/companies/search
 * @desc    Buscar empresas
 * @access  Public
 */
router.get('/search', authenticate, companyController.searchCompanies.bind(companyController));

export default router;
