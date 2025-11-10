import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    required UserStats userStats,
    required JobStats jobStats,
    required ProfileStats profileStats,
    required List<RecentActivity> recentActivities,
    required List<Achievement> achievements,
    required List<JobRecommendation> jobRecommendations,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => _$DashboardModelFromJson(json);
}

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    required int totalApplications,
    required int savedJobs,
    required int profileViews,
    required int connections,
    required int streakDays,
    required String currentStreak,
    required int totalPoints,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
}

@freezed
class JobStats with _$JobStats {
  const factory JobStats({
    required int applicationsThisMonth,
    required int interviewsScheduled,
    required int offersReceived,
    required double applicationSuccessRate,
    required List<String> topSkills,
    required List<String> preferredJobTypes,
  }) = _JobStats;

  factory JobStats.fromJson(Map<String, dynamic> json) => _$JobStatsFromJson(json);
}

@freezed
class ProfileStats with _$ProfileStats {
  const factory ProfileStats({
    required int profileCompletion,
    required int skillsCount,
    required int experienceCount,
    required int educationCount,
    required int languagesCount,
    required int cvCount,
    required bool hasProfilePhoto,
    required bool hasCoverPhoto,
  }) = _ProfileStats;

  factory ProfileStats.fromJson(Map<String, dynamic> json) => _$ProfileStatsFromJson(json);
}

@freezed
class RecentActivity with _$RecentActivity {
  const factory RecentActivity({
    required String id,
    required String title,
    required String description,
    required ActivityType type,
    required DateTime timestamp,
    required String icon,
    String? actionUrl,
  }) = _RecentActivity;

  factory RecentActivity.fromJson(Map<String, dynamic> json) => _$RecentActivityFromJson(json);
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String icon,
    required bool isUnlocked,
    required DateTime? unlockedAt,
    required int points,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
}

@freezed
class JobRecommendation with _$JobRecommendation {
  const factory JobRecommendation({
    required String id,
    required String title,
    required String company,
    required String location,
    required String type,
    required String salary,
    required double matchPercentage,
    required List<String> matchingSkills,
    required String description,
  }) = _JobRecommendation;

  factory JobRecommendation.fromJson(Map<String, dynamic> json) => _$JobRecommendationFromJson(json);
}

enum ActivityType {
  application,
  jobSaved,
  profileView,
  connection,
  achievement,
  skillAdded,
  experienceAdded,
  educationAdded,
}

extension ActivityTypeExtension on ActivityType {
  String get displayName {
    switch (this) {
      case ActivityType.application:
        return 'Aplicación';
      case ActivityType.jobSaved:
        return 'Trabajo Guardado';
      case ActivityType.profileView:
        return 'Vista de Perfil';
      case ActivityType.connection:
        return 'Conexión';
      case ActivityType.achievement:
        return 'Logro';
      case ActivityType.skillAdded:
        return 'Habilidad Agregada';
      case ActivityType.experienceAdded:
        return 'Experiencia Agregada';
      case ActivityType.educationAdded:
        return 'Educación Agregada';
    }
  }
}
