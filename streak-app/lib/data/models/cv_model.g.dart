// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CVModelImpl _$$CVModelImplFromJson(Map<String, dynamic> json) =>
    _$CVModelImpl(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      originalName: json['originalName'] as String,
      fileType: json['fileType'] as String,
      fileUrl: json['fileUrl'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      isPublic: json['isPublic'] as bool,
      isDefault: json['isDefault'] as bool,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      downloadCount: (json['downloadCount'] as num?)?.toInt() ?? 0,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CVModelImplToJson(_$CVModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'originalName': instance.originalName,
      'fileType': instance.fileType,
      'fileUrl': instance.fileUrl,
      'fileSize': instance.fileSize,
      'isPublic': instance.isPublic,
      'isDefault': instance.isDefault,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
      'description': instance.description,
      'tags': instance.tags,
      'downloadCount': instance.downloadCount,
      'viewCount': instance.viewCount,
    };
