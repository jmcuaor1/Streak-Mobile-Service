import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/bottom_nav.dart';
import 'jobs_home_screen.dart';
import 'gigs_home_screen.dart';
import '../profile/profile_screen.dart';
import '../notifications/notifications_screen.dart';
import '../search/advanced_search_screen.dart';
import '../job/create_job_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../client/client_jobs_screen.dart';
import '../client/client_applications_screen.dart';
import '../applications/applications_screen.dart';

/// Pantalla de Home (temporal)
/// TODO: Migrar Home Screen completo de UIX-GALLO
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Streak'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_outlined),
            tooltip: 'Dashboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.work_outline),
            tooltip: 'Crear Trabajo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateJobScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Cerrar Sesión'),
                  content: const Text('¿Estás seguro que deseas cerrar sesión?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Cerrar Sesión'),
                    ),
                  ],
                ),
              );

              if (confirmed == true && mounted) {
                await ref.read(authProvider.notifier).logout();
              }
            },
          ),
        ],
      ),
      body: _buildBody(user),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: NavFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateJobScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody(user) {
    // Navegación diferenciada por rol
    try {
      if (user?.isClient == true) {
        // Interfaz para clientes (empleadores)
        return _buildClientInterface();
      } else if (user?.isFreelancer == true) {
        // Interfaz para freelancers (buscadores de empleo)
        return _buildFreelancerInterface();
      } else {
        // Interfaz por defecto
        return _buildDefaultInterface();
      }
    } catch (e) {
      print('❌ Error en _buildBody: $e');
      print('👤 Usuario: $user');
      print('👤 Usuario rol: ${user?.role}');
      // Fallback a interfaz por defecto
      return _buildDefaultInterface();
    }
  }

  Widget _buildClientInterface() {
    switch (_currentIndex) {
      case 0:
        return const JobsHomeScreen(); // Ver trabajos disponibles
      case 1:
        return const ClientJobsScreen(); // Mis trabajos publicados
      case 2:
        return const ClientApplicationsScreen(); // Aplicaciones recibidas
      case 3:
        return const ProfileScreen();
      default:
        return const JobsHomeScreen();
    }
  }

  Widget _buildFreelancerInterface() {
    switch (_currentIndex) {
      case 0:
        return const JobsHomeScreen(); // Buscar trabajos
      case 1:
        return const AdvancedSearchScreen(); // Búsqueda avanzada
      case 2:
        return const ApplicationsScreen(); // Mis aplicaciones
      case 3:
        return const ProfileScreen();
      default:
        return const JobsHomeScreen();
    }
  }

  Widget _buildDefaultInterface() {
    switch (_currentIndex) {
      case 0:
        return const JobsHomeScreen();
      case 1:
        return const AdvancedSearchScreen();
      case 2:
        return const GigsHomeScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const JobsHomeScreen();
    }
  }

  Widget _buildHomeTab(user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saludo
          Text(
            'Hola, ${user?.profile.firstName ?? 'Usuario'} 👋',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bienvenido de vuelta',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          
          const SizedBox(height: 24),
          
          // Tarjeta de bienvenida
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¡Proyecto Frontend Completo!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Autenticación funcionando correctamente ✅',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Próximas características
          Text(
            'Próximas Características',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          
          const SizedBox(height: 16),
          
          _buildFeatureCard(
            icon: Icons.work_outline,
            title: 'Lista de Trabajos',
            description: 'Explora oportunidades disponibles',
            isAvailable: false,
          ),
          
          const SizedBox(height: 12),
          
          _buildFeatureCard(
            icon: Icons.assessment_outlined,
            title: 'Sistema de Gamificación',
            description: 'Streaks, achievements y leaderboard',
            isAvailable: false,
          ),
          
          const SizedBox(height: 12),
          
          _buildFeatureCard(
            icon: Icons.chat_bubble_outline,
            title: 'Chat en Tiempo Real',
            description: 'Comunícate con empleadores',
            isAvailable: false,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar y nombre
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: user?.profile.avatar != null
                      ? ClipOval(
                          child: Image.network(
                            user!.profile.avatar!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.primary,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  user != null ? '${user!.profile.firstName} ${user!.profile.lastName}' : 'Usuario',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                Chip(
                  label: Text(
                    user?.role.toUpperCase() ?? 'USUARIO',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  side: BorderSide.none,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Información del perfil
          _buildInfoCard('Información del Perfil', [
            _buildInfoRow(Icons.email, 'Email', user?.email ?? ''),
            if (user?.profile.phone != null)
              _buildInfoRow(Icons.phone, 'Teléfono', user!.profile.phone!),
            _buildInfoRow(Icons.shield, 'Estado', user?.accountStatus ?? ''),
          ]),
          
          const SizedBox(height: 16),
          
          // Gamificación
          _buildInfoCard('Gamificación', [
            _buildInfoRow(Icons.stars, 'Puntos', '${user?.gamification.totalPoints ?? 0}'),
            _buildInfoRow(Icons.trending_up, 'Nivel', '${user?.gamification.level ?? 1}'),
            _buildInfoRow(Icons.local_fire_department, 'Racha Actual', '${user?.gamification.currentStreak ?? 0} días'),
          ]),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isAvailable,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          if (!isAvailable)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Próximamente',
                style: TextStyle(
                  color: AppColors.warning,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

