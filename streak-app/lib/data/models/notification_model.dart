import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String title,
    required String message,
    required NotificationType type,
    required DateTime createdAt,
    @Default(false) bool isRead,
    String? actionUrl,
    Map<String, dynamic>? metadata,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}

enum NotificationType {
  @JsonValue('application')
  application,
  @JsonValue('job')
  job,
  @JsonValue('message')
  message,
  @JsonValue('system')
  system,
  @JsonValue('achievement')
  achievement,
  @JsonValue('connection')
  connection,
}

extension NotificationTypeExtension on NotificationType {
  String get displayName {
    switch (this) {
      case NotificationType.application:
        return 'Aplicación';
      case NotificationType.job:
        return 'Trabajo';
      case NotificationType.message:
        return 'Mensaje';
      case NotificationType.system:
        return 'Sistema';
      case NotificationType.achievement:
        return 'Logro';
      case NotificationType.connection:
        return 'Conexión';
    }
  }

  String get iconName {
    switch (this) {
      case NotificationType.application:
        return 'send';
      case NotificationType.job:
        return 'work';
      case NotificationType.message:
        return 'message';
      case NotificationType.system:
        return 'info';
      case NotificationType.achievement:
        return 'star';
      case NotificationType.connection:
        return 'people';
    }
  }
}
