import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/job_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/job/job_card.dart';
import '../job/job_detail_screen.dart';
import '../job/create_job_screen.dart';

/// Pantalla de trabajos publicados por el cliente
class ClientJobsScreen extends ConsumerStatefulWidget {
  const ClientJobsScreen({super.key});

  @override
  ConsumerState<ClientJobsScreen> createState() => _ClientJobsScreenState();
}

class _ClientJobsScreenState extends ConsumerState<ClientJobsScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar trabajos del cliente
    Future.microtask(() {
      ref.read(jobProvider.notifier).getClientJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final jobsState = ref.watch(jobProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar personalizado
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Mis Trabajos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Icon(
                        Icons.work_outline,
                        size: 40,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Gestiona tus trabajos publicados',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateJobScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Contenido
          if (jobsState.isLoading)
            const SliverFillRemaining(
              child: LoadingIndicator(),
            )
          else if (jobsState.error != null)
            SliverFillRemaining(
              child: AppErrorWidget(
                message: jobsState.error!,
                onRetry: () {
                  ref.read(jobProvider.notifier).getClientJobs();
                },
              ),
            )
          else if (jobsState.jobs.isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.work_outline,
                title: 'No tienes trabajos publicados',
                message: 'Crea tu primer trabajo para empezar a recibir aplicaciones',
                actionLabel: 'Crear Trabajo',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateJobScreen(),
                    ),
                  );
                },
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final job = jobsState.jobs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: JobCard(
                        jobId: job.id,
                        title: job.title,
                        company: '${user?.profile.firstName ?? 'Tu empresa'} • ${job.category}',
                        location: 'Remoto', // Por ahora usamos un valor por defecto
                        salary: () {
                          try {
                            return job.salaryRange;
                          } catch (e) {
                            if (job.type == 'fixed_price' && job.budget != null) {
                              return '\$${job.budget!.toStringAsFixed(0)} (Proyecto fijo)';
                            } else if (job.type == 'hourly' && job.hourlyRate != null) {
                              return '\$${job.hourlyRate!.min.toStringAsFixed(0)} - \$${job.hourlyRate!.max.toStringAsFixed(0)} / hora';
                            } else {
                              return 'No especificado';
                            }
                          }
                        }(),
                        tags: [
                          job.type,
                          () {
                            try {
                              return job.experienceLevelText;
                            } catch (e) {
                              switch (job.experienceLevel) {
                                case 'entry': return 'Principiante';
                                case 'intermediate': return 'Intermedio';
                                case 'expert': return 'Experto';
                                default: return 'Intermedio';
                              }
                            }
                          }(),
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
                  childCount: jobsState.jobs.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
