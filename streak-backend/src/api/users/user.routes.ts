import { Router } from 'express';
import { userController } from './user.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import {
  authenticate,
  authorize,
  authorizeOwnerOrAdmin,
} from '../../core/middlewares/auth.middleware';
import { UserRole } from './user.model';
import {
  UpdateProfileDTO,
  UpdateFreelancerProfileDTO,
  UpdatePreferencesDTO,
  GetUsersQueryDTO,
} from './user.dto';

const router = Router();

/**
 * @route   GET /api/users/freelancers/search
 * @desc    Buscar freelancers por habilidades
 * @access  Public
 */
router.get('/freelancers/search', userController.searchFreelancers.bind(userController));

/**
 * @route   GET /api/users
 * @desc    Listar usuarios con filtros y paginación
 * @access  Private (Admin)
 */
router.get(
  '/',
  authenticate,
  authorize(UserRole.ADMIN),
  validateRequest(GetUsersQueryDTO, 'query'),
  userController.getUsers.bind(userController)
);

/**
 * @route   GET /api/users/:id
 * @desc    Obtener usuario por ID
 * @access  Private
 */
router.get('/:id', authenticate, userController.getUserById.bind(userController));

/**
 * @route   PUT /api/users/:id/profile
 * @desc    Actualizar perfil de usuario
 * @access  Private (Owner or Admin)
 */
router.put(
  '/:id/profile',
  authenticate,
  authorizeOwnerOrAdmin('id'),
  validateRequest(UpdateProfileDTO),
  userController.updateProfile.bind(userController)
);

/**
 * @route   PUT /api/users/:id/freelancer-profile
 * @desc    Actualizar perfil de freelancer
 * @access  Private (Owner)
 */
router.put(
  '/:id/freelancer-profile',
  authenticate,
  authorizeOwnerOrAdmin('id'),
  validateRequest(UpdateFreelancerProfileDTO),
  userController.updateFreelancerProfile.bind(userController)
);

/**
 * @route   PUT /api/users/:id/preferences
 * @desc    Actualizar preferencias de usuario
 * @access  Private (Owner)
 */
router.put(
  '/:id/preferences',
  authenticate,
  authorizeOwnerOrAdmin('id'),
  validateRequest(UpdatePreferencesDTO),
  userController.updatePreferences.bind(userController)
);

/**
 * @route   DELETE /api/users/:id
 * @desc    Eliminar usuario (soft delete)
 * @access  Private (Owner or Admin)
 */
router.delete(
  '/:id',
  authenticate,
  authorizeOwnerOrAdmin('id'),
  userController.deleteUser.bind(userController)
);

export default router;
