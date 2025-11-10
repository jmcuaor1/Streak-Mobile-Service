// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_creation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobCreationModelImpl _$$JobCreationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JobCreationModelImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String?,
      type: $enumDecode(_$JobTypeEnumMap, json['type']),
      skillsRequired: (json['skillsRequired'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      experienceLevel:
          $enumDecode(_$ExperienceLevelEnumMap, json['experienceLevel']),
      estimatedDuration: json['estimatedDuration'] as String?,
      isUrgent: json['isUrgent'] as bool? ?? false,
      isRemote: json['isRemote'] as bool? ?? false,
      location: json['location'] as String?,
      budget: json['budget'] == null
          ? null
          : BudgetInfo.fromJson(json['budget'] as Map<String, dynamic>),
      hourlyRate: json['hourlyRate'] == null
          ? null
          : HourlyRateInfo.fromJson(json['hourlyRate'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      status: json['status'] as String? ?? 'open',
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      additionalRequirements: json['additionalRequirements'] as String?,
    );

Map<String, dynamic> _$$JobCreationModelImplToJson(
        _$JobCreationModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'type': _$JobTypeEnumMap[instance.type]!,
      'skillsRequired': instance.skillsRequired,
      'experienceLevel': _$ExperienceLevelEnumMap[instance.experienceLevel]!,
      'estimatedDuration': instance.estimatedDuration,
      'isUrgent': instance.isUrgent,
      'isRemote': instance.isRemote,
      'location': instance.location,
      'budget': instance.budget,
      'hourlyRate': instance.hourlyRate,
      'attachments': instance.attachments,
      'tags': instance.tags,
      'status': instance.status,
      'deadline': instance.deadline?.toIso8601String(),
      'additionalRequirements': instance.additionalRequirements,
    };

const _$JobTypeEnumMap = {
  JobType.fixedPrice: 'fixedPrice',
  JobType.hourly: 'hourly',
  JobType.fullTime: 'fullTime',
  JobType.partTime: 'partTime',
  JobType.contract: 'contract',
  JobType.internship: 'internship',
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.entry: 'entry',
  ExperienceLevel.intermediate: 'intermediate',
  ExperienceLevel.senior: 'senior',
  ExperienceLevel.expert: 'expert',
};

_$BudgetInfoImpl _$$BudgetInfoImplFromJson(Map<String, dynamic> json) =>
    _$BudgetInfoImpl(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      isNegotiable: json['isNegotiable'] as bool? ?? false,
    );

Map<String, dynamic> _$$BudgetInfoImplToJson(_$BudgetInfoImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'isNegotiable': instance.isNegotiable,
    };

_$HourlyRateInfoImpl _$$HourlyRateInfoImplFromJson(Map<String, dynamic> json) =>
    _$HourlyRateInfoImpl(
      minRate: (json['minRate'] as num).toDouble(),
      maxRate: (json['maxRate'] as num).toDouble(),
      currency: json['currency'] as String,
      isNegotiable: json['isNegotiable'] as bool? ?? false,
    );

Map<String, dynamic> _$$HourlyRateInfoImplToJson(
        _$HourlyRateInfoImpl instance) =>
    <String, dynamic>{
      'minRate': instance.minRate,
      'maxRate': instance.maxRate,
      'currency': instance.currency,
      'isNegotiable': instance.isNegotiable,
    };
