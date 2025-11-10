import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../providers/auth_provider.dart';

/// Modelo para logros
class Achievement {
  final String name;
  final String description;
  final String icon;
  final int points;
  final bool isUnlocked;

  const Achievement({
    required this.name,
    required this.description,
    required this.icon,
    required this.points,
    required this.isUnlocked,
  });
}

/// Estado de gamificación y rachas
class GamificationState {
  final int currentStreak;
  final int totalPoints;
  final int level;
  final List<Achievement> achievements;
  final DateTime? lastActivityDate;
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> leaderboard;

  GamificationState({
    required this.currentStreak,
    required this.totalPoints,
    required this.level,
    required this.achievements,
    this.lastActivityDate,
    required this.isLoading,
    this.error,
    this.leaderboard = const [],
  });

  GamificationState copyWith({
    int? currentStreak,
    int? totalPoints,
    int? level,
    List<Achievement>? achievements,
    DateTime? lastActivityDate,
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? leaderboard,
  }) {
    return GamificationState(
      currentStreak: currentStreak ?? this.currentStreak,
      totalPoints: totalPoints ?? this.totalPoints,
      level: level ?? this.level,
      achievements: achievements ?? this.achievements,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  factory GamificationState.initial() {
    return GamificationState(
      currentStreak: 0,
      totalPoints: 0,
      level: 1,
      achievements: [],
      isLoading: false,
      leaderboard: [],
    );
  }

  factory GamificationState.fromUser(UserModel user) {
    // Convertir achievements de string a Achievement objects
    final achievements = _convertStringAchievementsToObjects(user.gamification.achievements);
    
    return GamificationState(
      currentStreak: user.gamification.currentStreak,
      totalPoints: user.gamification.totalPoints,
      level: user.gamification.level,
      achievements: achievements,
      lastActivityDate: user.gamification.lastActivityDate,
      isLoading: false,
      leaderboard: [],
    );
  }

  /// Convertir achievements de string a objetos Achievement
  static List<Achievement> _convertStringAchievementsToObjects(List<String> stringAchievements) {
    final allAchievements = _getAllAchievements();
    return allAchievements.where((achievement) => 
      stringAchievements.contains(achievement.name.toLowerCase().replaceAll(' ', '_'))
    ).toList();
  }

  /// Obtener todos los logros disponibles
  static List<Achievement> _getAllAchievements() {
    return [
      const Achievement(
        name: 'Primera Racha',
        description: 'Completa tu primera racha de 3 días',
        icon: '🔥',
        points: 50,
        isUnlocked: false,
      ),
      const Achievement(
        name: 'Racha Semanal',
        description: 'Mantén una racha de 7 días consecutivos',
        icon: '📅',
        points: 100,
        isUnlocked: false,
      ),
      const Achievement(
        name: 'Racha Mensual',
        description: 'Mantén una racha de 30 días consecutivos',
        icon: '🏆',
        points: 500,
        isUnlocked: false,
      ),
      const Achievement(
        name: 'Primeros 100',
        description: 'Alcanza 100 puntos totales',
        icon: '💯',
        points: 25,
        isUnlocked: false,
      ),
      const Achievement(
        name: 'Primeros 500',
        description: 'Alcanza 500 puntos totales',
        icon: '⭐',
        points: 50,
        isUnlocked: false,
      ),
      const Achievement(
        name: 'Primeros 1000',
        description: 'Alcanza 1000 puntos totales',
        icon: '🎯',
        points: 100,
        isUnlocked: false,
      ),
    ];
  }
}

/// Notifier para gamificación y rachas
class GamificationNotifier extends Notifier<GamificationState> {
  @override
  GamificationState build() {
    // Escuchar cambios en el usuario autenticado
    ref.listen(authProvider, (previous, next) {
      if (next.isAuthenticated && next.user != null) {
        state = GamificationState.fromUser(next.user!);
      } else {
        state = GamificationState.initial();
      }
    });

    return GamificationState.initial();
  }

  /// Incrementar racha por actividad
  void incrementStreak({String? activityType}) {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final now = DateTime.now();
    final lastActivity = state.lastActivityDate;
    
    // Verificar si es una nueva actividad (diferente día)
    bool isNewActivity = false;
    if (lastActivity == null) {
      isNewActivity = true;
    } else {
      final daysDifference = now.difference(lastActivity).inDays;
      isNewActivity = daysDifference >= 1;
    }

    if (isNewActivity) {
      final newStreak = state.currentStreak + 1;
      final newPoints = state.totalPoints + _calculatePointsForActivity(activityType);
      final newLevel = _calculateLevel(newPoints);
      
      state = state.copyWith(
        currentStreak: newStreak,
        totalPoints: newPoints,
        level: newLevel,
        lastActivityDate: now,
      );

      // Verificar si se desbloqueó algún logro
      _checkAchievements(newStreak, newPoints);
    }
  }

  /// Calcular puntos por tipo de actividad
  int _calculatePointsForActivity(String? activityType) {
    switch (activityType) {
      case 'job_application':
        return 10;
      case 'job_posted':
        return 15;
      case 'job_completed':
        return 25;
      case 'profile_updated':
        return 5;
      case 'daily_login':
        return 5;
      default:
        return 5;
    }
  }

  /// Calcular nivel basado en puntos
  int _calculateLevel(int points) {
    if (points < 100) return 1;
    if (points < 300) return 2;
    if (points < 600) return 3;
    if (points < 1000) return 4;
    if (points < 1500) return 5;
    if (points < 2200) return 6;
    if (points < 3000) return 7;
    if (points < 4000) return 8;
    if (points < 5000) return 9;
    return 10;
  }

  /// Verificar logros desbloqueados
  void _checkAchievements(int streak, int points) {
    final allAchievements = GamificationState._getAllAchievements();
    final unlockedAchievements = <Achievement>[];
    
    // Verificar logros de racha
    if (streak >= 3) {
      unlockedAchievements.add(allAchievements.firstWhere((a) => a.name == 'Primera Racha'));
    }
    if (streak >= 7) {
      unlockedAchievements.add(allAchievements.firstWhere((a) => a.name == 'Racha Semanal'));
    }
    if (streak >= 30) {
      unlockedAchievements.add(allAchievements.firstWhere((a) => a.name == 'Racha Mensual'));
    }
    
    // Verificar logros de puntos
    if (points >= 100) {
      unlockedAchievements.add(allAchievements.firstWhere((a) => a.name == 'Primeros 100'));
    }
    if (points >= 500) {
      unlockedAchievements.add(allAchievements.firstWhere((a) => a.name == 'Primeros 500'));
    }
    if (points >= 1000) {
      unlockedAchievements.add(allAchievements.firstWhere((a) => a.name == 'Primeros 1000'));
    }

    // Actualizar achievements con isUnlocked = true
    final updatedAchievements = unlockedAchievements.map((achievement) => 
      Achievement(
        name: achievement.name,
        description: achievement.description,
        icon: achievement.icon,
        points: achievement.points,
        isUnlocked: true,
      )
    ).toList();

    if (updatedAchievements.isNotEmpty) {
      state = state.copyWith(
        achievements: updatedAchievements,
      );
    }
  }

  /// Obtener mensaje de racha
  String getStreakMessage() {
    if (state.currentStreak == 0) {
      return '¡Comienza tu racha hoy!';
    } else if (state.currentStreak == 1) {
      return '¡Excelente! Has comenzado tu racha.';
    } else if (state.currentStreak < 7) {
      return '¡Genial! Llevas ${state.currentStreak} días consecutivos.';
    } else if (state.currentStreak < 30) {
      return '¡Increíble! Llevas ${state.currentStreak} días consecutivos.';
    } else {
      return '¡Legendario! Llevas ${state.currentStreak} días consecutivos.';
    }
  }

  /// Obtener mensaje de nivel
  String getLevelMessage() {
    return 'Nivel ${state.level} - ${state.totalPoints} puntos';
  }

  /// Resetear racha (para testing)
  void resetStreak() {
    state = state.copyWith(
      currentStreak: 0,
      lastActivityDate: null,
    );
  }

  /// Obtener logros (placeholder para funcionalidad futura)
  Future<void> getAchievements() async {
    // Placeholder para funcionalidad futura
    // En el futuro aquí se haría una llamada al backend
  }

  /// Obtener leaderboard (placeholder para funcionalidad futura)
  Future<void> getLeaderboard() async {
    // Placeholder para funcionalidad futura
    // En el futuro aquí se haría una llamada al backend
  }
}

/// Provider para gamificación
final gamificationProvider = NotifierProvider<GamificationNotifier, GamificationState>(
  GamificationNotifier.new,
);

/// Provider para obtener el mensaje de racha actual
final streakMessageProvider = Provider<String>((ref) {
  final gamification = ref.watch(gamificationProvider);
  final notifier = ref.read(gamificationProvider.notifier);
  return notifier.getStreakMessage();
});

/// Provider para obtener el mensaje de nivel actual
final levelMessageProvider = Provider<String>((ref) {
  final gamification = ref.watch(gamificationProvider);
  final notifier = ref.read(gamificationProvider.notifier);
  return notifier.getLevelMessage();
});