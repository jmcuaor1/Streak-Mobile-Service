import { Router } from 'express';
import { gamificationController } from './gamification.controller';
import { authenticate, authorize, optionalAuth } from '../../core/middlewares/auth.middleware';
import { UserRole } from '../users/user.model';

const router = Router();

/**
 * @route   GET /api/gamification/stats
 * @desc    Obtener estadísticas de gamificación del usuario autenticado
 * @access  Private
 */
router.get('/stats', authenticate, gamificationController.getMyStats.bind(gamificationController));

/**
 * @route   GET /api/gamification/leaderboard
 * @desc    Obtener leaderboard de usuarios
 * @access  Public
 */
router.get(
  '/leaderboard',
  optionalAuth,
  gamificationController.getLeaderboard.bind(gamificationController)
);

/**
 * @route   GET /api/gamification/achievements
 * @desc    Listar todos los achievements
 * @access  Public
 */
router.get(
  '/achievements',
  optionalAuth,
  gamificationController.getAllAchievements.bind(gamificationController)
);

/**
 * @route   POST /api/gamification/achievements
 * @desc    Crear nuevo achievement (solo admin)
 * @access  Private (Admin)
 */
router.post(
  '/achievements',
  authenticate,
  authorize(UserRole.ADMIN),
  gamificationController.createAchievement.bind(gamificationController)
);

export default router;
