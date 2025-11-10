import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/notification_model.dart';

class NotificationNotifier extends Notifier<List<NotificationModel>> {
  @override
  List<NotificationModel> build() {
    return _loadMockNotifications();
  }

  List<NotificationModel> _loadMockNotifications() {
    final notifications = [
      NotificationModel(
        id: '1',
        title: 'Aplicación enviada',
        message: 'Tu aplicación para "Desarrollador Flutter Senior" ha sido enviada exitosamente.',
        type: NotificationType.application,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'Nueva oportunidad',
        message: 'Se ha publicado un nuevo trabajo que coincide con tu perfil: "Diseñador UX/UI".',
        type: NotificationType.job,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Mensaje recibido',
        message: 'Tienes un nuevo mensaje de TechCorp sobre tu aplicación.',
        type: NotificationType.message,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Perfil actualizado',
        message: 'Tu perfil ha sido actualizado exitosamente.',
        type: NotificationType.system,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'Aplicación aceptada',
        message: '¡Felicitaciones! Tu aplicación para "Desarrollador Backend" ha sido aceptada.',
        type: NotificationType.application,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
      ),
      NotificationModel(
        id: '6',
        title: 'Nuevo logro desbloqueado',
        message: 'Has completado tu primera aplicación. ¡Sigue así!',
        type: NotificationType.achievement,
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        isRead: true,
      ),
      NotificationModel(
        id: '7',
        title: 'Nueva conexión',
        message: 'Juan Pérez quiere conectarse contigo.',
        type: NotificationType.connection,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        isRead: true,
      ),
    ];
    
    return notifications;
  }

  void markAsRead(String notificationId) {
    state = state.map((notification) {
      if (notification.id == notificationId) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }

  void markAllAsRead() {
    state = state.map((notification) {
      return notification.copyWith(isRead: true);
    }).toList();
  }

  void deleteNotification(String notificationId) {
    state = state.where((notification) => notification.id != notificationId).toList();
  }

  void addNotification(NotificationModel notification) {
    state = [notification, ...state];
  }

  int get unreadCount {
    return state.where((notification) => !notification.isRead).length;
  }

  List<NotificationModel> get unreadNotifications {
    return state.where((notification) => !notification.isRead).toList();
  }

  List<NotificationModel> get readNotifications {
    return state.where((notification) => notification.isRead).toList();
  }
}

final notificationProvider = NotifierProvider<NotificationNotifier, List<NotificationModel>>(() {
  return NotificationNotifier();
});

final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationProvider.notifier).unreadCount;
});
