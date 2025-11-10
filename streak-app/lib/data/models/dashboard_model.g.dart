// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardModelImpl _$$DashboardModelImplFromJson(Map<String, dynamic> json) =>
    _$DashboardModelImpl(
      userStats: UserStats.fromJson(json['userStats'] as Map<String, dynamic>),
      jobStats: JobStats.fromJson(json['jobStats'] as Map<String, dynamic>),
      profileStats:
          ProfileStats.fromJson(json['profileStats'] as Map<String, dynamic>),
      recentActivities: (json['recentActivities'] as List<dynamic>)
          .map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobRecommendations: (json['jobRecommendations'] as List<dynamic>)
          .map((e) => JobRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DashboardModelImplToJson(
        _$DashboardModelImpl instance) =>
    <String, dynamic>{
      'userStats': instance.userStats,
      'jobStats': instance.jobStats,
      'profileStats': instance.profileStats,
      'recentActivities': instance.recentActivities,
      'achievements': instance.achievements,
      'jobRecommendations': instance.jobRecommendations,
    };

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      totalApplications: (json['totalApplications'] as num).toInt(),
      savedJobs: (json['savedJobs'] as num).toInt(),
      profileViews: (json['profileViews'] as num).toInt(),
      connections: (json['connections'] as num).toInt(),
      streakDays: (json['streakDays'] as num).toInt(),
      currentStreak: json['currentStreak'] as String,
      totalPoints: (json['totalPoints'] as num).toInt(),
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'totalApplications': instance.totalApplications,
      'savedJobs': instance.savedJobs,
      'profileViews': instance.profileViews,
      'connections': instance.connections,
      'streakDays': instance.streakDays,
      'currentStreak': instance.currentStreak,
      'totalPoints': instance.totalPoints,
    };

_$JobStatsImpl _$$JobStatsImplFromJson(Map<String, dynamic> json) =>
    _$JobStatsImpl(
      applicationsThisMonth: (json['applicationsThisMonth'] as num).toInt(),
      interviewsScheduled: (json['interviewsScheduled'] as num).toInt(),
      offersReceived: (json['offersReceived'] as num).toInt(),
      applicationSuccessRate:
          (json['applicationSuccessRate'] as num).toDouble(),
      topSkills:
          (json['topSkills'] as List<dynamic>).map((e) => e as String).toList(),
      preferredJobTypes: (json['preferredJobTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$JobStatsImplToJson(_$JobStatsImpl instance) =>
    <String, dynamic>{
      'applicationsThisMonth': instance.applicationsThisMonth,
      'interviewsScheduled': instance.interviewsScheduled,
      'offersReceived': instance.offersReceived,
      'applicationSuccessRate': instance.applicationSuccessRate,
      'topSkills': instance.topSkills,
      'preferredJobTypes': instance.preferredJobTypes,
    };

_$ProfileStatsImpl _$$ProfileStatsImplFromJson(Map<String, dynamic> json) =>
    _$ProfileStatsImpl(
      profileCompletion: (json['profileCompletion'] as num).toInt(),
      skillsCount: (json['skillsCount'] as num).toInt(),
      experienceCount: (json['experienceCount'] as num).toInt(),
      educationCount: (json['educationCount'] as num).toInt(),
      languagesCount: (json['languagesCount'] as num).toInt(),
      cvCount: (json['cvCount'] as num).toInt(),
      hasProfilePhoto: json['hasProfilePhoto'] as bool,
      hasCoverPhoto: json['hasCoverPhoto'] as bool,
    );

Map<String, dynamic> _$$ProfileStatsImplToJson(_$ProfileStatsImpl instance) =>
    <String, dynamic>{
      'profileCompletion': instance.profileCompletion,
      'skillsCount': instance.skillsCount,
      'experienceCount': instance.experienceCount,
      'educationCount': instance.educationCount,
      'languagesCount': instance.languagesCount,
      'cvCount': instance.cvCount,
      'hasProfilePhoto': instance.hasProfilePhoto,
      'hasCoverPhoto': instance.hasCoverPhoto,
    };

_$RecentActivityImpl _$$RecentActivityImplFromJson(Map<String, dynamic> json) =>
    _$RecentActivityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      icon: json['icon'] as String,
      actionUrl: json['actionUrl'] as String?,
    );

Map<String, dynamic> _$$RecentActivityImplToJson(
        _$RecentActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'icon': instance.icon,
      'actionUrl': instance.actionUrl,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.application: 'application',
  ActivityType.jobSaved: 'jobSaved',
  ActivityType.profileView: 'profileView',
  ActivityType.connection: 'connection',
  ActivityType.achievement: 'achievement',
  ActivityType.skillAdded: 'skillAdded',
  ActivityType.experienceAdded: 'experienceAdded',
  ActivityType.educationAdded: 'educationAdded',
};

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      isUnlocked: json['isUnlocked'] as bool,
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'isUnlocked': instance.isUnlocked,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'points': instance.points,
    };

_$JobRecommendationImpl _$$JobRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$JobRecommendationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
      salary: json['salary'] as String,
      matchPercentage: (json['matchPercentage'] as num).toDouble(),
      matchingSkills: (json['matchingSkills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$JobRecommendationImplToJson(
        _$JobRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'location': instance.location,
      'type': instance.type,
      'salary': instance.salary,
      'matchPercentage': instance.matchPercentage,
      'matchingSkills': instance.matchingSkills,
      'description': instance.description,
    };
