import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onDelete;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
    this.onMarkAsRead,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead 
            ? AppColors.cardBackground 
            : AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead 
              ? AppColors.grey200 
              : AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar/Icono de notificación
                _buildNotificationAvatar(),
                
                const SizedBox(width: 12),
                
                // Contenido de la notificación
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título y estado
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: notification.isRead 
                                    ? FontWeight.w500 
                                    : FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 6),
                      
                      // Mensaje
                      Text(
                        notification.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Fecha y acciones
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: AppColors.textSecondary.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTimeAgo(notification.createdAt),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary.withOpacity(0.7),
                            ),
                          ),
                          const Spacer(),
                          _buildActionButtons(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getNotificationColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getNotificationIcon(),
        color: _getNotificationColor(),
        size: 24,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!notification.isRead && onMarkAsRead != null)
          IconButton(
            icon: Icon(
              Icons.mark_email_read,
              size: 18,
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
            onPressed: onMarkAsRead,
            tooltip: 'Marcar como leído',
          ),
        if (onDelete != null)
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 18,
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
            onPressed: onDelete,
            tooltip: 'Eliminar',
          ),
      ],
    );
  }

  Color _getNotificationColor() {
    switch (notification.type) {
      case NotificationType.application:
        return AppColors.success;
      case NotificationType.job:
        return AppColors.primary;
      case NotificationType.message:
        return AppColors.info;
      case NotificationType.system:
        return AppColors.warning;
      case NotificationType.achievement:
        return AppColors.warning;
      case NotificationType.connection:
        return AppColors.primary;
    }
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.application:
        return Icons.send_rounded;
      case NotificationType.job:
        return Icons.work_rounded;
      case NotificationType.message:
        return Icons.message_rounded;
      case NotificationType.system:
        return Icons.info_rounded;
      case NotificationType.achievement:
        return Icons.star_rounded;
      case NotificationType.connection:
        return Icons.people_rounded;
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Ahora';
    }
  }
}

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 60,
                color: AppColors.primary.withOpacity(0.6),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'No hay notificaciones',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'Te notificaremos cuando tengas\nnuevas actualizaciones',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            ElevatedButton.icon(
              onPressed: () {
                // Navegar a trabajos o perfil
              },
              icon: const Icon(Icons.explore),
              label: const Text('Explorar Trabajos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
