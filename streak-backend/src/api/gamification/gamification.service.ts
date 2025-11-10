import { User } from '../users/user.model';
import { Achievement } from '../achievements/achievement.model';
import { ActivityEvent, ActivityType } from '../streaks/streak.model';
import { NotFoundError } from '../../core/middlewares/errorHandler';

/**
 * Servicio de Gamificación
 */
export class GamificationService {
  /**
   * Registrar actividad y actualizar streaks
   */
  async recordActivity(
    userId: string,
    type: ActivityType,
    metadata?: Record<string, unknown>
  ): Promise<void> {
    const user = await User.findById(userId);

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Calcular puntos según el tipo de actividad
    const points = this.getPointsForActivity(type);

    // Crear evento de actividad
    await ActivityEvent.create({
      userId,
      type,
      points,
      metadata,
      date: new Date(),
    });

    // Actualizar puntos totales del usuario
    user.gamification.totalPoints += points;

    // Actualizar streak
    await this.updateStreak(user);

    // Verificar achievements
    await this.checkAchievements(user);

    await user.save();
  }

  /**
   * Obtener puntos para un tipo de actividad
   */
  private getPointsForActivity(type: ActivityType): number {
    const pointsMap: Record<ActivityType, number> = {
      [ActivityType.LOGIN]: 5,
      [ActivityType.JOB_POSTED]: 10,
      [ActivityType.APPLICATION_SENT]: 15,
      [ActivityType.APPLICATION_ACCEPTED]: 25,
      [ActivityType.JOB_COMPLETED]: 50,
      [ActivityType.PROFILE_UPDATED]: 5,
    };

    return pointsMap[type] || 0;
  }

  /**
   * Actualizar streak del usuario
   */
  private async updateStreak(user: {
    gamification: { lastActivityDate?: Date; currentStreak: number; longestStreak: number };
    save: () => Promise<unknown>;
  }): Promise<void> {
    const now = new Date();
    const lastActivity = user.gamification.lastActivityDate;

    if (!lastActivity) {
      // Primera actividad
      user.gamification.currentStreak = 1;
      user.gamification.longestStreak = 1;
      user.gamification.lastActivityDate = now;
      return;
    }

    const daysSinceLastActivity = this.getDaysDifference(lastActivity, now);

    if (daysSinceLastActivity === 0) {
      // Misma día, no hacer nada
      return;
    } else if (daysSinceLastActivity === 1) {
      // Día consecutivo
      user.gamification.currentStreak += 1;

      // Actualizar longest streak si es necesario
      if (user.gamification.currentStreak > user.gamification.longestStreak) {
        user.gamification.longestStreak = user.gamification.currentStreak;
      }
    } else {
      // Se rompió el streak
      user.gamification.currentStreak = 1;
    }

    user.gamification.lastActivityDate = now;
  }

  /**
   * Calcular diferencia en días entre dos fechas
   */
  private getDaysDifference(date1: Date, date2: Date): number {
    const diffTime = Math.abs(date2.getTime() - date1.getTime());
    const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
  }

  /**
   * Verificar y otorgar achievements al usuario
   */
  private async checkAchievements(user: {
    _id: unknown;
    gamification: { currentStreak: number; totalPoints: number; achievements: unknown[] };
    stats: { jobsCompleted: number };
    save: () => Promise<unknown>;
  }): Promise<void> {
    const achievements = await Achievement.find({ isActive: true });

    for (const achievement of achievements) {
      // Verificar si el usuario ya tiene este achievement
      if (user.gamification.achievements.includes(achievement._id)) {
        continue;
      }

      // Verificar criterios
      let achieved = false;

      switch (achievement.criteria.type) {
        case 'streak_days':
          achieved = user.gamification.currentStreak >= achievement.criteria.target;
          break;

        case 'jobs_completed':
          achieved = user.stats.jobsCompleted >= achievement.criteria.target;
          break;

        case 'total_points':
          achieved = user.gamification.totalPoints >= achievement.criteria.target;
          break;

        // Agregar más criterios según sea necesario
        default:
          break;
      }

      // Si cumple los criterios, otorgar achievement
      if (achieved) {
        user.gamification.achievements.push(achievement._id);
        user.gamification.totalPoints += achievement.points;
      }
    }
  }

  /**
   * Obtener estadísticas de gamificación del usuario
   */
  async getUserGamificationStats(userId: string) {
    const user = await User.findById(userId).populate('gamification.achievements');

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Obtener actividades recientes
    const recentActivities = await ActivityEvent.find({ userId }).sort({ date: -1 }).limit(10);

    // Calcular nivel basado en puntos
    const level = this.calculateLevel(user.gamification.totalPoints);

    return {
      level,
      totalPoints: user.gamification.totalPoints,
      currentStreak: user.gamification.currentStreak,
      longestStreak: user.gamification.longestStreak,
      achievements: user.gamification.achievements,
      recentActivities,
    };
  }

  /**
   * Calcular nivel basado en puntos totales
   */
  private calculateLevel(totalPoints: number): number {
    // Cada 100 puntos = 1 nivel
    return Math.floor(totalPoints / 100) + 1;
  }

  /**
   * Obtener leaderboard (top usuarios por puntos)
   */
  async getLeaderboard(limit = 10) {
    const topUsers = await User.find()
      .sort({ 'gamification.totalPoints': -1 })
      .limit(limit)
      .select('profile email gamification.totalPoints gamification.currentStreak');

    return topUsers.map((user, index) => ({
      rank: index + 1,
      user: {
        id: user._id,
        name: `${user.profile.firstName} ${user.profile.lastName}`,
        email: user.email,
        avatar: user.profile.avatar,
      },
      totalPoints: user.gamification.totalPoints,
      currentStreak: user.gamification.currentStreak,
    }));
  }

  /**
   * Listar todos los achievements
   */
  async getAllAchievements() {
    return await Achievement.find({ isActive: true }).sort({ category: 1, order: 1 });
  }

  /**
   * Crear achievement (solo admin)
   */
  async createAchievement(data: {
    name: string;
    description: string;
    icon: string;
    category: string;
    criteria: { type: string; target: number };
    points: number;
    badgeUrl?: string;
    order?: number;
  }) {
    return await Achievement.create(data);
  }
}

export const gamificationService = new GamificationService();
