import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/dashboard_model.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/dashboard/dashboard_widgets.dart';
import '../applications/applications_screen.dart';
import '../saved/saved_jobs_screen.dart';
import '../profile/profile_screen.dart';
import '../gamification/gamification_screen.dart';
import '../job/job_detail_screen.dart';

/// Pantalla de Dashboard con estadísticas del usuario
/// Muestra un resumen completo de la actividad del usuario
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = ref.watch(dashboardProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(dashboardProvider.notifier).refreshDashboard();
              AppToast.showSuccess(context, 'Dashboard actualizado');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Resumen'),
            Tab(text: 'Actividad'),
            Tab(text: 'Logros'),
            Tab(text: 'Recomendaciones'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(dashboard),
          _buildActivityTab(dashboard),
          _buildAchievementsTab(dashboard),
          _buildRecommendationsTab(dashboard),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(DashboardModel dashboard) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(dashboardProvider.notifier).refreshDashboard();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estadísticas principales
            _buildMainStats(dashboard),
            const SizedBox(height: 24),
            
            // Progreso del perfil
            _buildProfileProgress(dashboard.profileStats),
            const SizedBox(height: 24),
            
            // Estadísticas de trabajos
            _buildJobStats(dashboard.jobStats),
            const SizedBox(height: 24),
            
            // Streak y puntos
            _buildStreakAndPoints(dashboard.userStats),
          ],
        ),
      ),
    );
  }

  Widget _buildMainStats(DashboardModel dashboard) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estadísticas Principales',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            StatCard(
              title: 'Aplicaciones',
              value: '${dashboard.userStats.totalApplications}',
              subtitle: '${dashboard.jobStats.applicationsThisMonth} este mes',
              icon: Icons.send,
              iconColor: AppColors.primary,
              onTap: () => _navigateToApplications(),
            ),
            StatCard(
              title: 'Trabajos Guardados',
              value: '${dashboard.userStats.savedJobs}',
              subtitle: 'En tu lista de favoritos',
              icon: Icons.bookmark,
              iconColor: AppColors.success,
              onTap: () => _navigateToSavedJobs(),
            ),
            StatCard(
              title: 'Vistas del Perfil',
              value: '${dashboard.userStats.profileViews}',
              subtitle: 'Por reclutadores',
              icon: Icons.visibility,
              iconColor: AppColors.info,
              onTap: () => _navigateToProfile(),
            ),
            StatCard(
              title: 'Conexiones',
              value: '${dashboard.userStats.connections}',
              subtitle: 'En tu red profesional',
              icon: Icons.people,
              iconColor: AppColors.secondary,
              onTap: () => _navigateToConnections(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileProgress(ProfileStats profileStats) {
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Progreso del Perfil',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${profileStats.profileCompletion}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: profileStats.profileCompletion / 100,
              backgroundColor: AppColors.grey200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildProgressItem('Habilidades', profileStats.skillsCount, Icons.star),
                const SizedBox(width: 16),
                _buildProgressItem('Experiencia', profileStats.experienceCount, Icons.work),
                const SizedBox(width: 16),
                _buildProgressItem('Educación', profileStats.educationCount, Icons.school),
                const SizedBox(width: 16),
                _buildProgressItem('Idiomas', profileStats.languagesCount, Icons.language),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String label, int count, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobStats(JobStats jobStats) {
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Estadísticas de Trabajos',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Entrevistas',
                    '${jobStats.interviewsScheduled}',
                    Icons.calendar_today,
                    AppColors.info,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Ofertas',
                    '${jobStats.offersReceived}',
                    Icons.card_giftcard,
                    AppColors.success,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Tasa de Éxito',
                    '${(jobStats.applicationSuccessRate * 100).toInt()}%',
                    Icons.trending_up,
                    AppColors.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakAndPoints(UserStats userStats) {
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.warning,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Racha y Puntos',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _navigateToGamification(),
                  child: Text(
                    'Ver más',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStreakItem(
                    'Racha Actual',
                    userStats.currentStreak,
                    Icons.local_fire_department,
                    AppColors.warning,
                  ),
                ),
                Expanded(
                  child: _buildStreakItem(
                    'Puntos Totales',
                    '${userStats.totalPoints}',
                    Icons.stars,
                    AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTab(DashboardModel dashboard) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(dashboardProvider.notifier).refreshDashboard();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dashboard.recentActivities.length,
        itemBuilder: (context, index) {
          final activity = dashboard.recentActivities[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ActivityCard(
              activity: activity,
              onTap: () => _handleActivityTap(activity),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAchievementsTab(DashboardModel dashboard) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(dashboardProvider.notifier).refreshDashboard();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dashboard.achievements.length,
        itemBuilder: (context, index) {
          final achievement = dashboard.achievements[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AchievementCard(
              achievement: achievement,
              onTap: () => _navigateToGamification(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendationsTab(DashboardModel dashboard) {
    final realJobs = ref.watch(realJobRecommendationsProvider);
    
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(dashboardProvider.notifier).refreshDashboard();
        ref.invalidate(realJobRecommendationsProvider);
        await Future.delayed(const Duration(seconds: 1));
      },
      child: realJobs.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_off,
                      size: 80,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No hay trabajos recomendados',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explora más trabajos para ver recomendaciones personalizadas',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: realJobs.length,
              itemBuilder: (context, index) {
                final job = realJobs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobRecommendationCard(
                    job: job,
                    onTap: () => _navigateToJobDetail(job.id),
                  ),
                );
              },
            ),
    );
  }

  void _handleActivityTap(RecentActivity activity) {
    switch (activity.type) {
      case ActivityType.application:
        _navigateToApplications();
        break;
      case ActivityType.jobSaved:
        _navigateToSavedJobs();
        break;
      case ActivityType.profileView:
        _navigateToProfile();
        break;
      case ActivityType.achievement:
        _navigateToGamification();
        break;
      default:
        AppToast.showInfo(context, 'Navegando a ${activity.title}');
    }
  }

  void _navigateToApplications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ApplicationsScreen(),
      ),
    );
  }

  void _navigateToSavedJobs() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SavedJobsScreen(),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      ),
    );
  }

  void _navigateToGamification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GamificationScreen(),
      ),
    );
  }

  void _navigateToConnections() {
    AppToast.showInfo(context, 'Navegando a conexiones...');
  }

  void _navigateToJobDetail(String jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JobDetailScreen(jobId: jobId),
      ),
    );
  }
}
