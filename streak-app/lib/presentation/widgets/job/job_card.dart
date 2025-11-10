import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/saved_jobs_provider.dart';
import '../../providers/applied_jobs_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../services/notification_service.dart';
import '../app_toast.dart';

/// Widget de tarjeta de trabajo
/// Muestra información resumida de un job
/// Optimizado para rendimiento con memoización
class JobCard extends ConsumerWidget {
  const JobCard({
    super.key,
    required this.jobId,
    required this.title,
    required this.company,
    required this.salary,
    this.location,
    this.tags = const [],
    this.onTap,
  });

  final String jobId;
  final String title;
  final String company;
  final String salary;
  final String? location;
  final List<String> tags;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Obtener estado de guardado y aplicación
    final isSaved = ref.watch(isJobSavedProvider(jobId));
    final isApplied = ref.watch(hasAppliedToJobProvider(jobId));
    
    // Handlers para acciones
    void handleSave() async {
      final savedJobsNotifier = ref.read(savedJobsProvider.notifier);
      final success = await savedJobsNotifier.toggleSaved(jobId);
      
      if (success) {
        AppToast.showSuccess(
          context,
          isSaved ? 'Trabajo removido de guardados' : 'Trabajo guardado exitosamente',
        );
      } else {
        AppToast.showError(
          context,
          'Error al ${isSaved ? 'remover' : 'guardar'} el trabajo',
        );
      }
    }
    
    void handleApply() async {
      final appliedJobsNotifier = ref.read(appliedJobsProvider.notifier);
      final success = await appliedJobsNotifier.toggleApplied(jobId);
      
      if (success) {
        if (!isApplied) {
          // Aplicación enviada exitosamente
          NotificationService.showApplicationNotification(
            context,
            title,
          );
          
          // Incrementar racha por aplicar a trabajo
          ref.read(gamificationProvider.notifier).incrementStreak(
            activityType: 'job_application',
          );
          
          // Mostrar notificación de racha después de un breve delay
          Future.delayed(const Duration(milliseconds: 500), () {
            NotificationService.showStreakNotification(
              context,
              ref.read(gamificationProvider.notifier).getStreakMessage(),
            );
          });
        } else {
          // Aplicación retirada
          AppToast.showSuccess(
            context,
            'Aplicación retirada',
          );
        }
      } else {
        AppToast.showError(
          context,
          'Error al ${isApplied ? 'retirar' : 'enviar'} la aplicación',
        );
      }
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.cardShadow,
          border: Border.all(
            color: AppColors.grey200,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Logo + Título + Bookmark
            Row(
              children: [
                // Logo de empresa
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.work_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Título
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                // Botón de guardar
                IconButton(
                  onPressed: handleSave,
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.primary : AppColors.grey400,
                  ),
                  tooltip: isSaved ? 'Eliminar de guardados' : 'Guardar',
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Empresa y ubicación
            Row(
              children: [
                Expanded(
                  child: Text(
                    company,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (location != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    location!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Salario
            Text(
              salary,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            
            if (tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              
              // Tags y botón de aplicar
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  // Tags
                  ...tags.take(2).map((tag) => Chip(
                    label: Text(
                      tag,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    backgroundColor: AppColors.grey100,
                    side: BorderSide.none,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  )),
                  
                  // Botón de aplicar
                  FilledButton.tonal(
                    onPressed: handleApply,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: isApplied 
                          ? AppColors.success 
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isApplied)
                          const Icon(Icons.check, size: 16),
                        if (isApplied)
                          const SizedBox(width: 4),
                        Text(
                          isApplied ? 'Aplicado' : 'Aplicar',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

