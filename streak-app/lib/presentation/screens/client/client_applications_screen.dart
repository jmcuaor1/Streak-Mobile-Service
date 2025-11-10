import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/applications_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/application/application_card.dart';

/// Pantalla de aplicaciones recibidas por el cliente
class ClientApplicationsScreen extends ConsumerStatefulWidget {
  const ClientApplicationsScreen({super.key});

  @override
  ConsumerState<ClientApplicationsScreen> createState() => _ClientApplicationsScreenState();
}

class _ClientApplicationsScreenState extends ConsumerState<ClientApplicationsScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar aplicaciones recibidas
    Future.microtask(() {
      ref.read(applicationsProvider.notifier).getClientApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final applicationsState = ref.watch(applicationsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar personalizado
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.success,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Aplicaciones Recibidas',
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
                      AppColors.success,
                      AppColors.success.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Icon(
                        Icons.people_outline,
                        size: 40,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Revisa las aplicaciones a tus trabajos',
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
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),

          // Contenido
          if (applicationsState.isLoading)
            const SliverFillRemaining(
              child: LoadingIndicator(),
            )
          else if (applicationsState.error != null)
            SliverFillRemaining(
              child: AppErrorWidget(
                message: applicationsState.error!,
                onRetry: () {
                  ref.read(applicationsProvider.notifier).getClientApplications();
                },
              ),
            )
          else if (applicationsState.applications.isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.people_outline,
                title: 'No hay aplicaciones',
                message: 'Las aplicaciones a tus trabajos aparecerán aquí',
                actionLabel: 'Ver Mis Trabajos',
                onAction: () {
                  // Cambiar a la pestaña de trabajos del cliente
                  // Esto se manejaría desde el HomeScreen
                },
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final application = applicationsState.applications[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ApplicationCard(
                        application: application,
                        onAccept: () {
                          _handleApplication(application.id, 'accepted');
                        },
                        onReject: () {
                          _handleApplication(application.id, 'rejected');
                        },
                        onViewProfile: () {
                          _viewFreelancerProfile(application.freelancerId);
                        },
                      ),
                    );
                  },
                  childCount: applicationsState.applications.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar Aplicaciones'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Todas'),
              leading: Radio<String>(
                value: 'all',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Pendientes'),
              leading: Radio<String>(
                value: 'pending',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Aceptadas'),
              leading: Radio<String>(
                value: 'accepted',
                groupValue: 'all',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Rechazadas'),
              leading: Radio<String>(
                value: 'rejected',
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
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  void _handleApplication(String applicationId, String status) {
    // Implementar lógica para aceptar/rechazar aplicación
    ref.read(applicationsProvider.notifier).updateApplicationStatus(
      applicationId,
      status,
    );
  }

  void _viewFreelancerProfile(String freelancerId) {
    // Implementar navegación al perfil del freelancer
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => FreelancerProfileScreen(freelancerId: freelancerId),
    //   ),
    // );
  }
}
