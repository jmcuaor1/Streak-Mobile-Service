import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/saved_jobs_provider.dart';
import '../../providers/applied_jobs_provider.dart';
import '../../widgets/app_toast.dart';
import '../saved/saved_jobs_screen.dart';
import '../applications/applications_screen.dart';
import 'edit_profile_screen.dart';
import 'cv_management_screen.dart';
import 'add_skill_screen.dart';
import 'add_work_experience_screen.dart';
import 'add_education_screen.dart';
import 'add_language_screen.dart';
import '../settings/settings_screen.dart';

/// Pantalla de perfil de usuario
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final savedJobs = ref.watch(savedJobsProvider);
    final appliedJobs = ref.watch(appliedJobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: user == null
          ? const Center(
              child: Text('Usuario no encontrado'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header del perfil
                  _buildProfileHeader(context, user),
                  
                  const SizedBox(height: 24),
                  
                  // Estadísticas
                  _buildStatsSection(context, savedJobs, appliedJobs),
                  
                  const SizedBox(height: 24),
                  
                  // Acciones rápidas
                  _buildQuickActionsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Perfil profesional
                  _buildProfessionalProfileSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Información personal
                  _buildPersonalInfoSection(context, user),
                  
                  const SizedBox(height: 24),
                  
                  // Configuración
                  _buildSettingsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Acciones
                  _buildActionsSection(context, ref),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, userData) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: userData.profile?.avatar != null && userData.profile!.avatar!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      userData.profile!.avatar!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
          ),
          
          const SizedBox(width: 16),
          
          // Información básica
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userData.profile?.firstName ?? 'Usuario'} ${userData.profile?.lastName ?? ''}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userData.email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                if (userData.profile?.address != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${userData.profile!.address!.city}, ${userData.profile!.address!.country}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, Set<String> savedJobs, Set<String> appliedJobs) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estadísticas',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.bookmark,
                title: 'Guardados',
                value: savedJobs.length.toString(),
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.send,
                title: 'Aplicaciones',
                value: appliedJobs.length.toString(),
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.cardShadow,
        border: Border.all(
          color: AppColors.grey200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acciones Rápidas',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.bookmark,
                title: 'Guardados',
                subtitle: 'Ver trabajos guardados',
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SavedJobsScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.send,
                title: 'Aplicaciones',
                subtitle: 'Ver aplicaciones enviadas',
                color: AppColors.success,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ApplicationsScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColors.cardShadow,
          border: Border.all(
            color: AppColors.grey200,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context, userData) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información Personal',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppColors.cardShadow,
            border: Border.all(
              color: AppColors.grey200,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                context,
                icon: Icons.person,
                label: 'Nombre',
                value: '${userData.profile?.firstName ?? 'No especificado'} ${userData.profile?.lastName ?? ''}',
              ),
              _buildInfoRow(
                context,
                icon: Icons.email,
                label: 'Email',
                value: userData.email,
              ),
              if (userData.profile?.phone != null)
                _buildInfoRow(
                  context,
                  icon: Icons.phone,
                  label: 'Teléfono',
                  value: userData.profile!.phone!,
                ),
              if (userData.profile?.address != null)
                _buildInfoRow(
                  context,
                  icon: Icons.location_on,
                  label: 'Ubicación',
                  value: '${userData.profile!.address!.city}, ${userData.profile!.address!.country}',
                ),
              if (userData.profile?.bio != null && userData.profile!.bio!.isNotEmpty)
                _buildInfoRow(
                  context,
                  icon: Icons.info,
                  label: 'Biografía',
                  value: userData.profile!.bio!,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuración',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppColors.cardShadow,
            border: Border.all(
              color: AppColors.grey200,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildSettingsItem(
                context,
                icon: Icons.notifications,
                title: 'Notificaciones',
                subtitle: 'Gestionar notificaciones',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              _buildDivider(),
              _buildSettingsItem(
                context,
                icon: Icons.security,
                title: 'Seguridad',
                subtitle: 'Cambiar contraseña',
                onTap: () {
                  AppToast.showInfo(context, 'Próximamente');
                },
              ),
              _buildDivider(),
              _buildSettingsItem(
                context,
                icon: Icons.language,
                title: 'Idioma',
                subtitle: 'Español',
                onTap: () {
                  AppToast.showInfo(context, 'Próximamente');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: AppColors.grey200,
      indent: 56,
    );
  }

  Widget _buildActionsSection(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Editar Perfil'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              _showLogoutDialog(context, ref);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar Sesión'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalProfileSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Perfil Profesional',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildProfessionalCard(
          context,
          icon: Icons.description_outlined,
          title: 'Currículum',
          subtitle: 'Gestiona tu currículum profesional',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CVManagementScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildProfessionalCard(
          context,
          icon: Icons.star_outline,
          title: 'Habilidades',
          subtitle: 'Agrega tus habilidades técnicas y blandas',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddSkillScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildProfessionalCard(
          context,
          icon: Icons.work_outline,
          title: 'Experiencia Laboral',
          subtitle: 'Agrega tu experiencia profesional',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddWorkExperienceScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildProfessionalCard(
          context,
          icon: Icons.school_outlined,
          title: 'Educación',
          subtitle: 'Agrega tu formación académica',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddEducationScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _buildProfessionalCard(
          context,
          icon: Icons.language_outlined,
          title: 'Idiomas',
          subtitle: 'Agrega los idiomas que dominas',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddLanguageScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfessionalCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

