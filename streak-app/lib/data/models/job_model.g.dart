// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobModelImpl _$$JobModelImplFromJson(Map<String, dynamic> json) =>
    _$JobModelImpl(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String?,
      clientId: json['clientId'] == null
          ? null
          : ClientModel.fromJson(json['clientId'] as Map<String, dynamic>),
      type: json['type'] as String,
      budget: (json['budget'] as num?)?.toDouble(),
      hourlyRate: json['hourlyRate'] == null
          ? null
          : HourlyRateModel.fromJson(
              json['hourlyRate'] as Map<String, dynamic>),
      skillsRequired: (json['skillsRequired'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      experienceLevel: json['experienceLevel'] as String? ?? 'intermediate',
      estimatedDuration: json['estimatedDuration'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: json['status'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
      assignedFreelancerId: json['assignedFreelancerId'] as String?,
      stats: StatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      client: json['client'] == null
          ? null
          : ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      assignedFreelancer: json['assignedFreelancer'] == null
          ? null
          : UserModel.fromJson(
              json['assignedFreelancer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JobModelImplToJson(_$JobModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'clientId': instance.clientId,
      'type': instance.type,
      'budget': instance.budget,
      'hourlyRate': instance.hourlyRate,
      'skillsRequired': instance.skillsRequired,
      'experienceLevel': instance.experienceLevel,
      'estimatedDuration': instance.estimatedDuration,
      'attachments': instance.attachments,
      'status': instance.status,
      'isUrgent': instance.isUrgent,
      'assignedFreelancerId': instance.assignedFreelancerId,
      'stats': instance.stats,
      'deadline': instance.deadline?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'completionDate': instance.completionDate?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'client': instance.client,
      'assignedFreelancer': instance.assignedFreelancer,
    };

_$HourlyRateModelImpl _$$HourlyRateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HourlyRateModelImpl(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$$HourlyRateModelImplToJson(
        _$HourlyRateModelImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

_$StatsModelImpl _$$StatsModelImplFromJson(Map<String, dynamic> json) =>
    _$StatsModelImpl(
      views: (json['views'] as num?)?.toInt() ?? 0,
      applicationsCount: (json['applicationsCount'] as num?)?.toInt() ?? 0,
      savedCount: (json['savedCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StatsModelImplToJson(_$StatsModelImpl instance) =>
    <String, dynamic>{
      'views': instance.views,
      'applicationsCount': instance.applicationsCount,
      'savedCount': instance.savedCount,
    };

_$ClientModelImpl _$$ClientModelImplFromJson(Map<String, dynamic> json) =>
    _$ClientModelImpl(
      id: json['_id'] as String,
      email: json['email'] as String,
      profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClientModelImplToJson(_$ClientModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'profile': instance.profile,
    };

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['_id'] as String,
      email: json['email'] as String,
      profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'profile': instance.profile,
    };
