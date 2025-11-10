import { Request, Response, NextFunction } from 'express';
import { gamificationService } from './gamification.service';
import { sendSuccess } from '../../core/utils/response.utils';

/**
 * Controlador de Gamificación
 */
export class GamificationController {
  /**
   * @route   GET /api/gamification/stats
   * @desc    Obtener estadísticas de gamificación del usuario autenticado
   * @access  Private
   */
  async getMyStats(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;

      const stats = await gamificationService.getUserGamificationStats(userId);

      sendSuccess(res, {
        message: 'Estadísticas obtenidas exitosamente',
        data: { stats },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/gamification/leaderboard
   * @desc    Obtener leaderboard de usuarios
   * @access  Public
   */
  async getLeaderboard(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const limit = req.query.limit ? Number(req.query.limit) : 10;

      const leaderboard = await gamificationService.getLeaderboard(limit);

      sendSuccess(res, {
        message: 'Leaderboard obtenido exitosamente',
        data: { leaderboard },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/gamification/achievements
   * @desc    Listar todos los achievements
   * @access  Public
   */
  async getAllAchievements(_req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const achievements = await gamificationService.getAllAchievements();

      sendSuccess(res, {
        message: 'Achievements obtenidos exitosamente',
        data: { achievements },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/gamification/achievements
   * @desc    Crear nuevo achievement (solo admin)
   * @access  Private (Admin)
   */
  async createAchievement(_req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const achievement = await gamificationService.createAchievement(_req.body);

      res.status(201);
      sendSuccess(res, {
        message: 'Achievement creado exitosamente',
        data: { achievement },
      });
    } catch (error) {
      next(error);
    }
  }
}

export const gamificationController = new GamificationController();
