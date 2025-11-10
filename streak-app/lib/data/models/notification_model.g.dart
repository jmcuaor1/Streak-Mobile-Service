// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      actionUrl: json['actionUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'actionUrl': instance.actionUrl,
      'metadata': instance.metadata,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.application: 'application',
  NotificationType.job: 'job',
  NotificationType.message: 'message',
  NotificationType.system: 'system',
  NotificationType.achievement: 'achievement',
  NotificationType.connection: 'connection',
};
