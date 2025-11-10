import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/notification_model.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/notifications/notification_card.dart';

/// Pantalla de notificaciones mejorada según diseño de Figma
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationProvider);
    final notificationNotifier = ref.read(notificationProvider.notifier);
    
    final unreadNotifications = notificationNotifier.unreadNotifications;
    final readNotifications = notificationNotifier.readNotifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (unreadNotifications.isNotEmpty)
            TextButton(
              onPressed: () {
                notificationNotifier.markAllAsRead();
                AppToast.showSuccess(context, 'Todas las notificaciones marcadas como leídas');
              },
              child: Text(
                'Marcar todas',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Todas'),
                  if (notifications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${notifications.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No leídas'),
                  if (unreadNotifications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${unreadNotifications.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Leídas'),
                  if (readNotifications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${readNotifications.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(notifications, notificationNotifier),
          _buildNotificationsList(unreadNotifications, notificationNotifier),
          _buildNotificationsList(readNotifications, notificationNotifier),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationModel> notifications, NotificationNotifier notifier) {
    if (notifications.isEmpty) {
      return const NotificationEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Simular refresh
        await Future.delayed(const Duration(seconds: 1));
        AppToast.showSuccess(context, 'Notificaciones actualizadas');
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
            onMarkAsRead: notification.isRead 
                ? null 
                : () => _markAsRead(notification.id, notifier),
            onDelete: () => _deleteNotification(notification.id, notifier),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(NotificationModel notification) {
    if (!notification.isRead) {
      ref.read(notificationProvider.notifier).markAsRead(notification.id);
    }
    
    // Navegar según el tipo de notificación
    switch (notification.type) {
      case NotificationType.application:
        // Navegar a aplicaciones
        AppToast.showInfo(context, 'Navegando a aplicaciones...');
        break;
      case NotificationType.job:
        // Navegar a trabajos
        AppToast.showInfo(context, 'Navegando a trabajos...');
        break;
      case NotificationType.message:
        // Navegar a mensajes
        AppToast.showInfo(context, 'Navegando a mensajes...');
        break;
      case NotificationType.achievement:
        // Navegar a gamificación
        AppToast.showInfo(context, 'Navegando a logros...');
        break;
      case NotificationType.connection:
        // Navegar a conexiones
        AppToast.showInfo(context, 'Navegando a conexiones...');
        break;
      case NotificationType.system:
        // No navegar
        break;
    }
  }

  void _markAsRead(String notificationId, NotificationNotifier notifier) {
    notifier.markAsRead(notificationId);
    AppToast.showSuccess(context, 'Notificación marcada como leída');
  }

  void _deleteNotification(String notificationId, NotificationNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Notificación'),
        content: const Text('¿Estás seguro de que quieres eliminar esta notificación?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              notifier.deleteNotification(notificationId);
              Navigator.pop(context);
              AppToast.showSuccess(context, 'Notificación eliminada');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
