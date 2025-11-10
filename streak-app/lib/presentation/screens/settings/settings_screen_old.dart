import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/app_toast.dart';
import '../auth/change_password_screen.dart';
import '../about/about_screen.dart';

/// Pantalla de configuración
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  String _selectedLanguage = 'es';
  String _selectedTheme = 'light';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: Text(
              'Guardar',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Notificaciones
            _buildSectionHeader(context, 'Notificaciones'),
            const SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    context,
                    title: 'Notificaciones por Email',
                    subtitle: 'Recibe notificaciones importantes por correo',
                    value: _emailNotifications,
                    onChanged: (value) {
                      setState(() {
                        _emailNotifications = value;
                      });
                    },
                    icon: Icons.email,
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    context,
                    title: 'Notificaciones Push',
                    subtitle: 'Recibe notificaciones en tiempo real',
                    value: _pushNotifications,
                    onChanged: (value) {
                      setState(() {
                        _pushNotifications = value;
                      });
                    },
                    icon: Icons.notifications,
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    context,
                    title: 'Notificaciones SMS',
                    subtitle: 'Recibe notificaciones por mensaje de texto',
                    value: _smsNotifications,
                    onChanged: (value) {
                      setState(() {
                        _smsNotifications = value;
                      });
                    },
                    icon: Icons.sms,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Sección de Apariencia
            _buildSectionHeader(context, 'Apariencia'),
            const SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    title: 'Tema',
                    subtitle: _selectedTheme == 'light' ? 'Claro' : 'Oscuro',
                    icon: Icons.palette,
                    onTap: () {
                      _showThemeDialog(context);
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: 'Idioma',
                    subtitle: _selectedLanguage == 'es' ? 'Español' : 'English',
                    icon: Icons.language,
                    onTap: () {
                      _showLanguageDialog(context);
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Sección de Privacidad
            _buildSectionHeader(context, 'Privacidad'),
            const SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    title: 'Cambiar Contraseña',
                    subtitle: 'Actualiza tu contraseña de seguridad',
                    icon: Icons.lock,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: 'Política de Privacidad',
                    subtitle: 'Lee nuestra política de privacidad',
                    icon: Icons.privacy_tip,
                    onTap: () {
                      AppToast.showInfo(context, 'Política de privacidad próximamente');
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: 'Términos de Servicio',
                    subtitle: 'Lee nuestros términos de servicio',
                    icon: Icons.description,
                    onTap: () {
                      AppToast.showInfo(context, 'Términos de servicio próximamente');
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Sección de Cuenta
            _buildSectionHeader(context, 'Cuenta'),
            const SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    title: 'Exportar Datos',
                    subtitle: 'Descarga una copia de tus datos',
                    icon: Icons.download,
                    onTap: () {
                      AppToast.showInfo(context, 'Exportación de datos próximamente');
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: 'Eliminar Cuenta',
                    subtitle: 'Elimina permanentemente tu cuenta',
                    icon: Icons.delete_forever,
                    textColor: AppColors.error,
                    onTap: () {
                      _showDeleteAccountDialog(context);
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Información de la App
            _buildSectionHeader(context, 'Información'),
            const SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    title: 'Versión',
                    subtitle: '1.0.0 (Alpha)',
                    icon: Icons.info,
                    onTap: () {
                      AppToast.showInfo(context, 'Streak v1.0.0 - Alpha');
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: 'Acerca de',
                    subtitle: 'Información sobre la aplicación',
                    icon: Icons.info_outline,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primary),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Claro'),
              value: 'light',
              groupValue: _selectedTheme,
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Oscuro'),
              value: 'dark',
              groupValue: _selectedTheme,
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Español'),
              value: 'es',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Cuenta'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AppToast.showInfo(context, 'Función de eliminación próximamente');
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    AppToast.showSuccess(context, 'Configuración guardada exitosamente');
  }
}


