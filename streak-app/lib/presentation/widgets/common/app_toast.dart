import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Widget para mostrar notificaciones toast personalizadas
class AppToast {
  static void showSuccess(BuildContext context, String message) {
    _showToast(context, message, AppColors.success, Icons.check_circle);
  }

  static void showError(BuildContext context, String message) {
    _showToast(context, message, AppColors.error, Icons.error);
  }

  static void showInfo(BuildContext context, String message) {
    _showToast(context, message, AppColors.info, Icons.info);
  }

  static void showWarning(BuildContext context, String message) {
    _showToast(context, message, AppColors.warning, Icons.warning);
  }

  static void _showToast(BuildContext context, String message, Color color, IconData icon) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => overlayEntry.remove(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
