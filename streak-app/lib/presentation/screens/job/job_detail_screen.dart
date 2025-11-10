import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/job_model.dart';
import '../../providers/job_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/saved_jobs_provider.dart';
import '../../providers/applied_jobs_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../services/notification_service.dart';
import '../../widgets/app_toast.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../../data/models/job_model.dart';

/// Pantalla de detalle de trabajo
class JobDetailScreen extends ConsumerWidget {
  const JobDetailScreen({
    super.key,
    required this.jobId,
  });

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('🎯 JobDetailScreen: Construyendo pantalla para jobId: $jobId');
    final theme = Theme.of(context);
    final jobAsync = ref.watch(jobByIdProvider(jobId));
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Trabajo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función de compartir próximamente')),
              );
            },
          ),
        ],
      ),
      body: jobAsync.when(
        data: (job) {
          if (job == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_off,
                      size: 80,
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Trabajo no encontrado',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'El trabajo que buscas no existe o ha sido eliminado.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

          final appliedJobs = ref.watch(appliedJobsProvider);
          final isApplied = appliedJobs.contains(jobId);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header - Logo de empresa
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.business,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Título
                Text(
                  job.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // Empresa y ubicación
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      job.clientName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      job.category,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Chips de información
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    Chip(
                      label: Text(job.type == 'fixed_price' ? 'Proyecto fijo' : 'Por hora'),
                      backgroundColor: AppColors.primaryLight.withOpacity(0.1),
                      side: BorderSide.none,
                    ),
                    Chip(
                      label: Text(job.experienceLevelText),
                      backgroundColor: AppColors.secondaryLight.withOpacity(0.1),
                      side: BorderSide.none,
                    ),
                    Chip(
                      label: Text(job.experienceLevel!),
                      backgroundColor: AppColors.tertiaryLight.withOpacity(0.1),
                      side: BorderSide.none,
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Salario
                _buildSection(
                  context,
                  icon: Icons.attach_money,
                  title: 'Salario',
                  child: Text(
                    () {
                      try {
                        return job.salaryRange;
                      } catch (e) {
                        // Fallback si hay error con el getter
                        if (job.type == 'fixed_price' && job.budget != null) {
                          return '\$${job.budget!.toStringAsFixed(0)} (Proyecto fijo)';
                        } else if (job.type == 'hourly' && job.hourlyRate != null) {
                          return '\$${job.hourlyRate!.min.toStringAsFixed(0)} - \$${job.hourlyRate!.max.toStringAsFixed(0)} / hora';
                        } else {
                          return 'No especificado';
                        }
                      }
                    }(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Descripción
                _buildSection(
                  context,
                  icon: Icons.description,
                  title: 'Descripción',
                  child: Text(
                    job.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Requisitos
                if (job.skillsRequired.isNotEmpty)
                  _buildSection(
                    context,
                    icon: Icons.checklist,
                    title: 'Requisitos',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: job.skillsRequired.map((skill) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 20,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                skill,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                
                const SizedBox(height: 24),
                
                // Responsabilidades (comentado - campo no existe en nuevo modelo)
                /*
                if (job.responsibilities.isNotEmpty)
                  _buildSection(
                    context,
                    icon: Icons.assignment,
                    title: 'Responsabilidades',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: job.responsibilities.map((resp) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                resp,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                */
                
                const SizedBox(height: 24),
                
                // Beneficios
                // Beneficios (comentado - campo no existe en nuevo modelo)
                /*
                if (job.benefits.isNotEmpty)
                  _buildSection(
                    context,
                    icon: Icons.card_giftcard,
                    title: 'Beneficios',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: job.benefits.map((benefit) => Chip(
                        label: Text(benefit),
                        avatar: Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.success,
                        ),
                        backgroundColor: AppColors.successLight,
                        side: BorderSide.none,
                      )).toList(),
                    ),
                  ),
                */
                
                const SizedBox(height: 24),
                
                // Skills requeridos (comentado - ya se muestran arriba como skillsRequired)
                /*
                if (job.skills.isNotEmpty)
                  _buildSection(
                    context,
                    icon: Icons.code,
                    title: 'Habilidades',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: job.skills.map((skill) => Chip(
                        label: Text(skill),
                        backgroundColor: AppColors.grey100,
                        side: BorderSide.none,
                      )).toList(),
                    ),
                  ),
                */
                
                const SizedBox(height: 100),
              ],
            ),
          );
        },
        loading: () => const LoadingIndicator(message: 'Cargando detalles...'),
        error: (error, stack) => AppErrorWidget(
          message: 'Error al cargar el trabajo',
          onRetry: () {
            ref.invalidate(jobByIdProvider(jobId));
          },
        ),
      ),
      bottomNavigationBar: jobAsync.maybeWhen(
        data: (job) {
          if (job == null) return null;
          
          final appliedJobs = ref.watch(appliedJobsProvider);
          final isApplied = appliedJobs.contains(jobId);

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Botón de guardar
                OutlinedButton(
                  onPressed: () async {
                    final savedJobsNotifier = ref.read(savedJobsProvider.notifier);
                    final success = await savedJobsNotifier.toggleSaved(jobId);
                    
                    if (success) {
                      final isSaved = ref.read(savedJobsProvider).contains(jobId);
                      AppToast.showSuccess(
                        context,
                        isSaved ? 'Trabajo guardado exitosamente' : 'Trabajo removido de guardados',
                      );
                    } else {
                      AppToast.showError(
                        context,
                        'Error al guardar el trabajo',
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Icon(
                    ref.watch(savedJobsProvider).contains(jobId)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Botón de aplicar
                Expanded(
                  child: ElevatedButton(
                    onPressed: isApplied
                        ? null
                        : () async {
                            final appliedJobsNotifier = ref.read(appliedJobsProvider.notifier);
                            final success = await appliedJobsNotifier.toggleApplied(jobId);
                            
                            if (success) {
                              // Aplicación enviada exitosamente
                              NotificationService.showApplicationNotification(
                                context,
                                job.title,
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
                              AppToast.showError(
                                context,
                                'Error al enviar la aplicación',
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isApplied ? AppColors.success : AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isApplied ? '✓ Aplicado' : 'Aplicar Ahora',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        orElse: () => null,
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

