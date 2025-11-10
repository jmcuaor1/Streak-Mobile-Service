import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/saved_jobs_provider.dart';
import '../../providers/job_provider.dart';
import '../../widgets/job/job_card.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_widget.dart';
import '../job/job_detail_screen.dart';

/// Pantalla de trabajos guardados
class SavedJobsScreen extends ConsumerWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final savedJobs = ref.watch(savedJobsProvider);
    final jobsState = ref.watch(jobProvider);

    // Cargar trabajos si no están cargados
    if (jobsState.jobs.isEmpty && !jobsState.isLoading && jobsState.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(jobProvider.notifier).getJobs();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabajos Guardados'),
        actions: [
          if (savedJobs.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                _showClearAllDialog(context, ref);
              },
            ),
        ],
      ),
      body: savedJobs.isEmpty
          ? _buildEmptyState(context)
          : _buildSavedJobsList(context, ref, savedJobs, jobsState),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const EmptyState(
      icon: Icons.bookmark_border,
      title: 'No hay trabajos guardados',
      message: 'Los trabajos que guardes aparecerán aquí.\n¡Empieza a explorar oportunidades!',
    );
  }

  Widget _buildSavedJobsList(
    BuildContext context,
    WidgetRef ref,
    Set<String> savedJobs,
    jobsState,
  ) {
    if (jobsState.isLoading && jobsState.jobs.isEmpty) {
      return const LoadingIndicator(message: 'Cargando trabajos guardados...');
    }

    if (jobsState.error != null && jobsState.jobs.isEmpty) {
      return AppErrorWidget(
        message: jobsState.error!,
        onRetry: () {
          ref.read(jobProvider.notifier).clearError();
          ref.read(jobProvider.notifier).refresh();
        },
      );
    }

    // Filtrar solo los trabajos guardados
    final savedJobsList = jobsState.jobs
        .where((job) => savedJobs.contains(job.id))
        .toList();

    if (savedJobsList.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(jobProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedJobsList.length,
        itemBuilder: (context, index) {
          final job = savedJobsList[index];
          
          // Manejo seguro del salaryRange
          String salaryText;
          try {
            salaryText = job.salaryRange;
          } catch (e) {
            // Fallback si hay error con el getter
            if (job.type == 'fixed_price' && job.budget != null) {
              salaryText = '\$${job.budget!.toStringAsFixed(0)} (Proyecto fijo)';
            } else if (job.type == 'hourly' && job.hourlyRate != null) {
              salaryText = '\$${job.hourlyRate!.min.toStringAsFixed(0)} - \$${job.hourlyRate!.max.toStringAsFixed(0)} / hora';
            } else {
              salaryText = 'No especificado';
            }
          }
          
          // Manejo seguro del experienceLevelText
          String experienceText;
          try {
            experienceText = job.experienceLevelText;
          } catch (e) {
            // Fallback si hay error con el getter
            switch (job.experienceLevel) {
              case 'entry':
                experienceText = 'Principiante';
                break;
              case 'intermediate':
                experienceText = 'Intermedio';
                break;
              case 'expert':
                experienceText = 'Experto';
                break;
              default:
                experienceText = 'Intermedio';
            }
          }
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: JobCard(
              jobId: job.id,
              title: job.title,
              company: '${job.client?.profile.firstName ?? 'Cliente'} • ${job.category}',
              salary: salaryText,
              location: job.category,
              tags: [
                job.type,
                experienceText,
                if (job.isUrgent) 'Urgente',
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobDetailScreen(jobId: job.id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar todos los guardados'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar todos los trabajos guardados? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(savedJobsProvider.notifier).state = <String>{};
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todos los trabajos guardados han sido eliminados'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text(
              'Limpiar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
