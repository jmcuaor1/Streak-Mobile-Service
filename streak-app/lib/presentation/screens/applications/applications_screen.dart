import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/applied_jobs_provider.dart';
import '../../providers/job_provider.dart';
import '../../widgets/job/job_card.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_widget.dart';
import '../job/job_detail_screen.dart';

/// Pantalla de aplicaciones enviadas
class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appliedJobs = ref.watch(appliedJobsProvider);
    final jobsState = ref.watch(jobProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Aplicaciones'),
        actions: [
          if (appliedJobs.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterDialog(context);
              },
            ),
        ],
      ),
      body: appliedJobs.isEmpty
          ? _buildEmptyState(context)
          : _buildApplicationsList(context, ref, appliedJobs, jobsState),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const EmptyState(
      icon: Icons.send,
      title: 'No hay aplicaciones enviadas',
      message: 'Las aplicaciones que envíes aparecerán aquí.\n¡Empieza a aplicar a trabajos!',
    );
  }

  Widget _buildApplicationsList(
    BuildContext context,
    WidgetRef ref,
    Set<String> appliedJobs,
    jobsState,
  ) {
    if (jobsState.isLoading && jobsState.jobs.isEmpty) {
      return const LoadingIndicator(message: 'Cargando aplicaciones...');
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

    // Filtrar solo los trabajos aplicados
    final appliedJobsList = jobsState.jobs
        .where((job) => appliedJobs.contains(job.id))
        .toList();

    if (appliedJobsList.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(jobProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appliedJobsList.length,
        itemBuilder: (context, index) {
          final job = appliedJobsList[index];
          
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
                'Aplicado', // Tag especial para aplicaciones
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar aplicaciones'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Pendientes'),
              trailing: Radio<String>(
                value: 'pending',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Aceptadas'),
              trailing: Radio<String>(
                value: 'accepted',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Rechazadas'),
              trailing: Radio<String>(
                value: 'rejected',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('Todas'),
              trailing: Radio<String>(
                value: 'all',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filtro aplicado'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }
}
