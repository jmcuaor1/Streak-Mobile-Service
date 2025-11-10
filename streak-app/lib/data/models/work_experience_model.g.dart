// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_experience_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkExperienceImpl _$$WorkExperienceImplFromJson(Map<String, dynamic> json) =>
    _$WorkExperienceImpl(
      id: json['id'] as String,
      companyName: json['companyName'] as String,
      position: json['position'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool? ?? false,
      location: json['location'] as String?,
      companyWebsite: json['companyWebsite'] as String?,
      achievements: (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$WorkExperienceImplToJson(
        _$WorkExperienceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'position': instance.position,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'location': instance.location,
      'companyWebsite': instance.companyWebsite,
      'achievements': instance.achievements,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
