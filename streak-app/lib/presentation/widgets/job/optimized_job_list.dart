import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/job_provider.dart';
import '../../widgets/job/job_card.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_widget.dart';
import '../../../data/models/job_model.dart';

/// Widget optimizado para mostrar listas largas de trabajos
/// Utiliza técnicas de optimización para mejorar el rendimiento
class OptimizedJobList extends ConsumerWidget {
  const OptimizedJobList({
    super.key,
    this.onJobTap,
    this.onRefresh,
  });

  final Function(Job)? onJobTap;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobState = ref.watch(jobProvider);

    return jobState.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return const EmptyState(
            icon: Icons.work_off,
            title: 'No se encontraron trabajos',
            message: 'Intenta ajustar tus filtros de búsqueda',
          );
        }

        return RefreshIndicator(
          onRefresh: onRefresh ?? () async {
            ref.read(jobProvider.notifier).refresh();
          },
          child: ListView.separated(
            // Optimizaciones de rendimiento
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final job = jobs[index];
              
              // Usar RepaintBoundary para evitar repintados innecesarios
              return RepaintBoundary(
                child: JobCard(
                  jobId: job.id,
                  title: job.title,
                  company: job.client?.companyName ?? 'Empresa',
                  salary: _formatSalary(job.budgetInfo),
                  location: job.location,
                  tags: job.skillsRequired?.take(3).toList() ?? [],
                  onTap: () => onJobTap?.call(job),
                ),
              );
            },
          ),
        );
      },
      loading: () => const LoadingIndicator(message: 'Cargando trabajos...'),
      error: (error, stackTrace) => ErrorWidget(
        message: 'Error al cargar trabajos',
        onRetry: () => ref.read(jobProvider.notifier).refresh(),
      ),
    );
  }

  String _formatSalary(BudgetInfo? budgetInfo) {
    if (budgetInfo == null) return 'Salario no especificado';
    
    if (budgetInfo.type == 'fixed') {
      return '\$${budgetInfo.minAmount?.toStringAsFixed(0) ?? '0'} - \$${budgetInfo.maxAmount?.toStringAsFixed(0) ?? '0'}';
    } else if (budgetInfo.type == 'hourly') {
      return '\$${budgetInfo.minAmount?.toStringAsFixed(0) ?? '0'}/hora';
    }
    
    return 'Salario competitivo';
  }
}

/// Widget optimizado para mostrar trabajos en un grid
/// Útil para mostrar trabajos en formato de tarjetas más pequeñas
class OptimizedJobGrid extends ConsumerWidget {
  const OptimizedJobGrid({
    super.key,
    this.onJobTap,
    this.onRefresh,
    this.crossAxisCount = 2,
  });

  final Function(Job)? onJobTap;
  final Future<void> Function()? onRefresh;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobState = ref.watch(jobProvider);

    return jobState.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return const EmptyState(
            icon: Icons.work_off,
            title: 'No se encontraron trabajos',
            message: 'Intenta ajustar tus filtros de búsqueda',
          );
        }

        return RefreshIndicator(
          onRefresh: onRefresh ?? () async {
            ref.read(jobProvider.notifier).refresh();
          },
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              
              return RepaintBoundary(
                child: _CompactJobCard(
                  job: job,
                  onTap: () => onJobTap?.call(job),
                ),
              );
            },
          ),
        );
      },
      loading: () => const LoadingIndicator(message: 'Cargando trabajos...'),
      error: (error, stackTrace) => ErrorWidget(
        message: 'Error al cargar trabajos',
        onRetry: () => ref.read(jobProvider.notifier).refresh(),
      ),
    );
  }
}

/// Tarjeta compacta optimizada para grids
class _CompactJobCard extends StatelessWidget {
  const _CompactJobCard({
    required this.job,
    this.onTap,
  });

  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del trabajo
              Text(
                job.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              
              // Empresa
              Text(
                job.client?.companyName ?? 'Empresa',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              
              // Ubicación
              if (job.location != null) ...[
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        job.location!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              
              // Salario
              Text(
                _formatSalary(job.budgetInfo),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const Spacer(),
              
              // Tags
              if (job.skillsRequired?.isNotEmpty == true)
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: job.skillsRequired!
                      .take(2)
                      .map((skill) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              skill,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatSalary(BudgetInfo? budgetInfo) {
    if (budgetInfo == null) return 'Salario no especificado';
    
    if (budgetInfo.type == 'fixed') {
      return '\$${budgetInfo.minAmount?.toStringAsFixed(0) ?? '0'} - \$${budgetInfo.maxAmount?.toStringAsFixed(0) ?? '0'}';
    } else if (budgetInfo.type == 'hourly') {
      return '\$${budgetInfo.minAmount?.toStringAsFixed(0) ?? '0'}/hora';
    }
    
    return 'Salario competitivo';
  }
}
