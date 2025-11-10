import { Router } from 'express';
import { authController } from './auth.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import { authenticate } from '../../core/middlewares/auth.middleware';
import { authLimiter } from '../../core/middlewares/rateLimiter';
import {
  RegisterDTO,
  LoginDTO,
  RefreshTokenDTO,
  ForgotPasswordDTO,
  ResetPasswordDTO,
  VerifyEmailDTO,
  ChangePasswordDTO,
} from './auth.dto';

const router = Router();

/**
 * @route   POST /api/auth/register
 * @desc    Registrar nuevo usuario
 * @access  Public
 */
router.post(
  '/register',
  authLimiter, // Rate limiting más estricto para registro
  validateRequest(RegisterDTO),
  authController.register.bind(authController)
);

/**
 * @route   POST /api/auth/login
 * @desc    Login de usuario
 * @access  Public
 */
router.post(
  '/login',
  authLimiter, // Rate limiting más estricto para login
  validateRequest(LoginDTO),
  authController.login.bind(authController)
);

/**
 * @route   POST /api/auth/logout
 * @desc    Logout de usuario
 * @access  Private
 */
router.post('/logout', authenticate, authController.logout.bind(authController));

/**
 * @route   POST /api/auth/refresh
 * @desc    Refrescar access token
 * @access  Public
 */
router.post(
  '/refresh',
  validateRequest(RefreshTokenDTO),
  authController.refreshToken.bind(authController)
);

/**
 * @route   POST /api/auth/verify-email
 * @desc    Verificar email
 * @access  Public
 */
router.post(
  '/verify-email',
  validateRequest(VerifyEmailDTO),
  authController.verifyEmail.bind(authController)
);

/**
 * @route   POST /api/auth/forgot-password
 * @desc    Solicitar reset de contraseña
 * @access  Public
 */
router.post(
  '/forgot-password',
  authLimiter, // Rate limiting para prevenir abuso
  validateRequest(ForgotPasswordDTO),
  authController.forgotPassword.bind(authController)
);

/**
 * @route   POST /api/auth/reset-password
 * @desc    Resetear contraseña
 * @access  Public
 */
router.post(
  '/reset-password',
  authLimiter,
  validateRequest(ResetPasswordDTO),
  authController.resetPassword.bind(authController)
);

/**
 * @route   POST /api/auth/change-password
 * @desc    Cambiar contraseña (usuario autenticado)
 * @access  Private
 */
router.post(
  '/change-password',
  authenticate,
  validateRequest(ChangePasswordDTO),
  authController.changePassword.bind(authController)
);

/**
 * @route   GET /api/auth/me
 * @desc    Obtener usuario autenticado
 * @access  Private
 */
router.get('/me', authenticate, authController.getMe.bind(authController));

export default router;
