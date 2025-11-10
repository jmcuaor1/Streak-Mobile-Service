import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../widgets/common/loading_indicator.dart';

/// Pantalla de Gamificación (Streaks, Achievements, Leaderboard)
class GamificationScreen extends ConsumerStatefulWidget {
  const GamificationScreen({super.key});

  @override
  ConsumerState<GamificationScreen> createState() => _GamificationScreenState();
}

class _GamificationScreenState extends ConsumerState<GamificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Cargar datos al iniciar
    Future.microtask(() {
      ref.read(gamificationProvider.notifier).getAchievements();
      ref.read(gamificationProvider.notifier).getLeaderboard();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamificación'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '🔥 Streaks'),
            Tab(text: '🏆 Logros'),
            Tab(text: '📊 Ranking'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStreaksTab(),
          _buildAchievementsTab(),
          _buildLeaderboardTab(),
        ],
      ),
    );
  }

  // Tab 1: Streaks
  Widget _buildStreaksTab() {
    final user = ref.watch(currentUserProvider);
    final currentStreak = user?.gamification.currentStreak ?? 0;
    final totalPoints = user?.gamification.totalPoints ?? 0;
    final level = user?.gamification.level ?? 1;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Streak actual
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 80,
                  color: currentStreak > 0 ? Colors.orange : Colors.white70,
                ),
                const SizedBox(height: 16),
                Text(
                  '$currentStreak',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  currentStreak == 1 ? 'día de racha' : 'días de racha',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  currentStreak == 0
                      ? '¡Empieza tu racha hoy!'
                      : '¡Sigue así! 🎉',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Estadísticas
          Row(
            children: [
              Expanded(
                child: _buildStatContainer(
                  icon: Icons.stars,
                  value: '$totalPoints',
                  label: 'Puntos totales',
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatContainer(
                  icon: Icons.trending_up,
                  value: '$level',
                  label: 'Nivel',
                  color: AppColors.success,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Progreso del nivel
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nivel $level',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      'Nivel ${level + 1}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (totalPoints % 100) / 100,
                    minHeight: 12,
                    backgroundColor: AppColors.grey200,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${totalPoints % 100}/100 puntos para el siguiente nivel',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Consejos
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.infoLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: AppColors.info),
                    const SizedBox(width: 8),
                    Text(
                      'Cómo ganar puntos',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTip('Aplicar a trabajos (+10 puntos)'),
                _buildTip('Completar tu perfil (+20 puntos)'),
                _buildTip('Mantener tu racha activa (+5 puntos/día)'),
                _buildTip('Obtener logros (puntos variables)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tab 2: Achievements
  Widget _buildAchievementsTab() {
    final gamificationState = ref.watch(gamificationProvider);

    if (gamificationState.isLoading) {
      return const LoadingIndicator(message: 'Cargando logros...');
    }

    final achievements = gamificationState.achievements;

    if (achievements.isEmpty) {
      // Mostrar logros demo si no hay del backend
      return _buildDemoAchievements();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return _buildAchievementCard(
          title: achievement.name,
          description: achievement.description,
          icon: achievement.icon,
          points: achievement.points,
          isUnlocked: achievement.isUnlocked,
        );
      },
    );
  }

  Widget _buildDemoAchievements() {
    final demoAchievements = [
      {'title': 'Primera Postulación', 'description': 'Aplica a tu primer trabajo', 'icon': '🎯', 'points': 10, 'unlocked': true},
      {'title': 'Racha de 3 días', 'description': 'Mantén tu racha 3 días', 'icon': '🔥', 'points': 15, 'unlocked': false},
      {'title': 'Perfil Completo', 'description': 'Completa tu perfil 100%', 'icon': '✅', 'points': 20, 'unlocked': false},
      {'title': 'Social', 'description': 'Conecta con 5 usuarios', 'icon': '👥', 'points': 15, 'unlocked': false},
      {'title': 'Explorador', 'description': 'Ve 50 trabajos', 'icon': '🔍', 'points': 10, 'unlocked': false},
      {'title': 'Proactivo', 'description': 'Aplica a 10 trabajos', 'icon': '⚡', 'points': 25, 'unlocked': false},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: demoAchievements.length,
      itemBuilder: (context, index) {
        final achievement = demoAchievements[index];
        return _buildAchievementCard(
          title: achievement['title'] as String,
          description: achievement['description'] as String,
          icon: achievement['icon'] as String,
          points: achievement['points'] as int,
          isUnlocked: achievement['unlocked'] as bool,
        );
      },
    );
  }

  // Tab 3: Leaderboard
  Widget _buildLeaderboardTab() {
    final gamificationState = ref.watch(gamificationProvider);
    final user = ref.watch(currentUserProvider);

    if (gamificationState.isLoading) {
      return const LoadingIndicator(message: 'Cargando ranking...');
    }

    final leaderboard = gamificationState.leaderboard;

    if (leaderboard.isEmpty) {
      // Mostrar demo leaderboard
      return _buildDemoLeaderboard(user);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        final entry = leaderboard[index];
        final isCurrentUser = entry['userId'] == user?.id;

        return _buildLeaderboardEntry(
          rank: entry['rank'] as int,
          name: entry['name'] as String,
          points: entry['totalPoints'] as int,
          level: entry['level'] as int,
          streak: entry['currentStreak'] as int,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }

  Widget _buildDemoLeaderboard(user) {
    final demoEntries = [
      {'rank': 1, 'name': 'Juan Pérez', 'points': 1250, 'level': 12, 'streak': 45},
      {'rank': 2, 'name': 'María García', 'points': 980, 'level': 10, 'streak': 32},
      {'rank': 3, 'name': 'Carlos López', 'points': 850, 'level': 9, 'streak': 28},
      {'rank': 4, 'name': user != null ? '${user!.profile.firstName} ${user!.profile.lastName}' : 'Tú', 'points': user?.gamification.totalPoints ?? 0, 'level': user?.gamification.level ?? 1, 'streak': user?.gamification.currentStreak ?? 0, 'isYou': true},
      {'rank': 5, 'name': 'Ana Martínez', 'points': 720, 'level': 8, 'streak': 15},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: demoEntries.length,
      itemBuilder: (context, index) {
        final entry = demoEntries[index];
        return _buildLeaderboardEntry(
          rank: entry['rank'] as int,
          name: entry['name'] as String,
          points: entry['points'] as int,
          level: entry['level'] as int,
          streak: entry['streak'] as int,
          isCurrentUser: entry['isYou'] as bool? ?? false,
        );
      },
    );
  }

  // Helper widgets
  Widget _buildStatContainer({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: AppColors.info),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String description,
    required String icon,
    required int points,
    required bool isUnlocked,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked
            ? AppColors.successLight
            : AppColors.grey100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? AppColors.success : AppColors.grey300,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(
              fontSize: 48,
              color: isUnlocked ? null : Colors.black26,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isUnlocked ? AppColors.textPrimary : AppColors.grey400,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: isUnlocked ? AppColors.textSecondary : AppColors.grey400,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isUnlocked ? AppColors.success : AppColors.grey300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+$points pts',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isUnlocked ? Colors.white : AppColors.grey600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardEntry({
    required int rank,
    required String name,
    required int points,
    required int level,
    required int streak,
    bool isCurrentUser = false,
  }) {
    Color rankColor = AppColors.grey400;
    IconData? medalIcon;

    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
      medalIcon = Icons.emoji_events;
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0);
      medalIcon = Icons.emoji_events;
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32);
      medalIcon = Icons.emoji_events;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.primary.withOpacity(0.1)
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser ? AppColors.primary : AppColors.grey200,
          width: isCurrentUser ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: medalIcon != null
                  ? Icon(medalIcon, color: rankColor, size: 24)
                  : Text(
                      '$rank',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: rankColor,
                      ),
                    ),
            ),
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isCurrentUser ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.stars, size: 14, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      '$points pts',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.trending_up, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(
                      'Nivel $level',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.local_fire_department, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '$streak días',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

