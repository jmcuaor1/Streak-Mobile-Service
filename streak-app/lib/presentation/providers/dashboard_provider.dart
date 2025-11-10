import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/dashboard_model.dart';
import 'job_provider.dart';
import '../../../data/models/job_model.dart';
import '../../../data/models/job_creation_model.dart';

class DashboardNotifier extends Notifier<DashboardModel> {
  @override
  DashboardModel build() {
    return _loadMockDashboard();
  }

  DashboardModel _loadMockDashboard() {
    return DashboardModel(
      userStats: const UserStats(
        totalApplications: 24,
        savedJobs: 12,
        profileViews: 156,
        connections: 8,
        streakDays: 7,
        currentStreak: '7 días',
        totalPoints: 1250,
      ),
      jobStats: const JobStats(
        applicationsThisMonth: 8,
        interviewsScheduled: 3,
        offersReceived: 1,
        applicationSuccessRate: 0.125,
        topSkills: ['Flutter', 'Dart', 'JavaScript', 'React', 'Node.js'],
        preferredJobTypes: ['Tiempo Completo', 'Remoto', 'Híbrido'],
      ),
      profileStats: const ProfileStats(
        profileCompletion: 85,
        skillsCount: 8,
        experienceCount: 3,
        educationCount: 2,
        languagesCount: 3,
        cvCount: 2,
        hasProfilePhoto: true,
        hasCoverPhoto: false,
      ),
      recentActivities: [
        RecentActivity(
          id: '1',
          title: 'Aplicación enviada',
          description: 'Desarrollador Flutter Senior en TechCorp',
          type: ActivityType.application,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          icon: '📝',
          actionUrl: '/applications',
        ),
        RecentActivity(
          id: '2',
          title: 'Trabajo guardado',
          description: 'Product Manager en StartupXYZ',
          type: ActivityType.jobSaved,
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          icon: '💾',
          actionUrl: '/saved-jobs',
        ),
        RecentActivity(
          id: '3',
          title: 'Logro desbloqueado',
          description: 'Primera aplicación enviada',
          type: ActivityType.achievement,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          icon: '🏆',
          actionUrl: '/achievements',
        ),
        RecentActivity(
          id: '4',
          title: 'Habilidad agregada',
          description: 'React Native',
          type: ActivityType.skillAdded,
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          icon: '⚡',
          actionUrl: '/profile',
        ),
        RecentActivity(
          id: '5',
          title: 'Perfil visto',
          description: 'Tu perfil fue visto por 3 reclutadores',
          type: ActivityType.profileView,
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          icon: '👀',
          actionUrl: '/profile',
        ),
      ],
      achievements: [
        const Achievement(
          id: '1',
          title: 'Primera Aplicación',
          description: 'Envía tu primera aplicación de trabajo',
          icon: '🎯',
          isUnlocked: true,
          unlockedAt: null,
          points: 50,
        ),
        const Achievement(
          id: '2',
          title: 'Perfil Completo',
          description: 'Completa tu perfil al 100%',
          icon: '✅',
          isUnlocked: false,
          unlockedAt: null,
          points: 100,
        ),
        const Achievement(
          id: '3',
          title: 'Streak de 7 días',
          description: 'Mantén una racha de 7 días consecutivos',
          icon: '🔥',
          isUnlocked: true,
          unlockedAt: null,
          points: 75,
        ),
        const Achievement(
          id: '4',
          title: '10 Aplicaciones',
          description: 'Envía 10 aplicaciones de trabajo',
          icon: '📈',
          isUnlocked: false,
          unlockedAt: null,
          points: 150,
        ),
        const Achievement(
          id: '5',
          title: 'Primera Entrevista',
          description: 'Programa tu primera entrevista',
          icon: '🎤',
          isUnlocked: false,
          unlockedAt: null,
          points: 200,
        ),
      ],
      jobRecommendations: [], // Inicializar vacío, se llenará con trabajos reales
    );
  }

  void refreshDashboard() {
    state = _loadMockDashboard();
  }

  void markAchievementAsUnlocked(String achievementId) {
    state = state.copyWith(
      achievements: state.achievements.map((achievement) {
        if (achievement.id == achievementId) {
          return achievement.copyWith(
            isUnlocked: true,
            unlockedAt: DateTime.now(),
          );
        }
        return achievement;
      }).toList(),
    );
  }

  void addRecentActivity(RecentActivity activity) {
    state = state.copyWith(
      recentActivities: [activity, ...state.recentActivities.take(9)],
    );
  }

  // Getters para estadísticas específicas
  int get unlockedAchievementsCount {
    return state.achievements.where((achievement) => achievement.isUnlocked).length;
  }

  int get totalAchievementsCount {
    return state.achievements.length;
  }

  List<RecentActivity> get recentApplications {
    return state.recentActivities
        .where((activity) => activity.type == ActivityType.application)
        .take(5)
        .toList();
  }

  List<JobRecommendation> get topJobRecommendations {
    return state.jobRecommendations
        .where((job) => job.matchPercentage >= 0.8)
        .toList();
  }
}

final dashboardProvider = NotifierProvider<DashboardNotifier, DashboardModel>(() {
  return DashboardNotifier();
});

final unlockedAchievementsCountProvider = Provider<int>((ref) {
  return ref.watch(dashboardProvider.notifier).unlockedAchievementsCount;
});

final recentApplicationsProvider = Provider<List<RecentActivity>>((ref) {
  return ref.watch(dashboardProvider.notifier).recentApplications;
});

final topJobRecommendationsProvider = Provider<List<JobRecommendation>>((ref) {
  return ref.watch(dashboardProvider.notifier).topJobRecommendations;
});

/// Provider que obtiene trabajos reales para recomendaciones
final realJobRecommendationsProvider = Provider<List<JobRecommendation>>((ref) {
  final jobState = ref.watch(jobProvider);
  
  if (jobState.isLoading || jobState.jobs.isEmpty) {
    return [];
  }
  
  // Convertir trabajos reales a JobRecommendation
  return jobState.jobs.take(3).map((job) {
    return JobRecommendation(
      id: job.id,
      title: job.title,
      company: _getCompanyName(job.client),
      location: 'Ubicación no especificada', // JobModel no tiene campo location
      type: job.type == 'fixed_price' ? 'Precio Fijo' : 'Por Hora',
      salary: _formatJobSalary(job),
      matchPercentage: 0.85, // Simular porcentaje de coincidencia
      matchingSkills: job.skillsRequired.take(3).toList(),
      description: job.description,
    );
  }).toList();
});

String _getCompanyName(ClientModel? client) {
  if (client?.profile == null) return 'Empresa';
  return '${client!.profile.firstName} ${client.profile.lastName}';
}

String _formatJobSalary(JobModel job) {
  if (job.type == 'fixed_price' && job.budget != null) {
    return '\$${job.budget!.toStringAsFixed(0)}';
  } else if (job.type == 'hourly' && job.hourlyRate != null) {
    return '\$${job.hourlyRate!.min.toStringAsFixed(0)} - \$${job.hourlyRate!.max.toStringAsFixed(0)}/hora';
  }
  
  return 'Salario competitivo';
}
