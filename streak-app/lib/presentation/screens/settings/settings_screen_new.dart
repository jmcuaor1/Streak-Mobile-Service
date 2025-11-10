import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/settings_model.dart';
import '../../providers/settings_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/settings/settings_widgets.dart';
import '../auth/change_password_screen.dart';
import '../about/about_screen.dart';

/// Pantalla de configuración mejorada según diseño de Figma
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => _saveSettings(settingsNotifier),
            child: Text(
              'Guardar',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección de Notificaciones
            SettingsSection(
              title: 'Notificaciones',
              children: [
                SettingsSwitchTile(
                  title: 'Notificaciones por Email',
                  subtitle: 'Recibe notificaciones importantes por correo',
                  icon: Icons.email_outlined,
                  value: settings.emailNotifications,
                  onChanged: settingsNotifier.updateEmailNotifications,
                ),
                SettingsSwitchTile(
                  title: 'Notificaciones Push',
                  subtitle: 'Recibe notificaciones en tiempo real',
                  icon: Icons.notifications_outlined,
                  value: settings.pushNotifications,
                  onChanged: settingsNotifier.updatePushNotifications,
                ),
                SettingsSwitchTile(
                  title: 'Notificaciones SMS',
                  subtitle: 'Recibe notificaciones por mensaje de texto',
                  icon: Icons.sms_outlined,
                  value: settings.smsNotifications,
                  onChanged: settingsNotifier.updateSmsNotifications,
                ),
                SettingsSwitchTile(
                  title: 'Emails de Marketing',
                  subtitle: 'Recibe ofertas y promociones especiales',
                  icon: Icons.campaign_outlined,
                  value: settings.marketingEmails,
                  onChanged: settingsNotifier.updateMarketingEmails,
                ),
                SettingsSwitchTile(
                  title: 'Alertas de Trabajo',
                  subtitle: 'Notificaciones sobre nuevos trabajos',
                  icon: Icons.work_outline,
                  value: settings.jobAlerts,
                  onChanged: settingsNotifier.updateJobAlerts,
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sección de Privacidad y Seguridad
            SettingsSection(
              title: 'Privacidad y Seguridad',
              children: [
                SettingsTile(
                  title: 'Cambiar Contraseña',
                  subtitle: 'Actualiza tu contraseña de seguridad',
                  icon: Icons.lock_outline,
                  onTap: () => _navigateToChangePassword(),
                ),
                SettingsSwitchTile(
                  title: 'Autenticación Biométrica',
                  subtitle: 'Usa huella dactilar o Face ID',
                  icon: Icons.fingerprint,
                  value: settings.biometricAuth,
                  onChanged: settingsNotifier.updateBiometricAuth,
                ),
                SettingsSwitchTile(
                  title: 'Autenticación de Dos Factores',
                  subtitle: 'Añade una capa extra de seguridad',
                  icon: Icons.security,
                  value: settings.twoFactorAuth,
                  onChanged: settingsNotifier.updateTwoFactorAuth,
                ),
                SettingsSwitchTile(
                  title: 'Seguimiento de Ubicación',
                  subtitle: 'Permite acceso a tu ubicación',
                  icon: Icons.location_on_outlined,
                  value: settings.locationTracking,
                  onChanged: settingsNotifier.updateLocationTracking,
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sección de Apariencia
            SettingsSection(
              title: 'Apariencia',
              children: [
                SettingsTile(
                  title: 'Tema',
                  subtitle: ThemeOption.getByCode(settings.theme).name,
                  icon: Icons.palette_outlined,
                  onTap: () => _showThemeDialog(context, settingsNotifier),
                ),
                SettingsTile(
                  title: 'Idioma',
                  subtitle: LanguageOption.getByCode(settings.language).name,
                  icon: Icons.language_outlined,
                  onTap: () => _showLanguageDialog(context, settingsNotifier),
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sección de Datos y Privacidad
            SettingsSection(
              title: 'Datos y Privacidad',
              children: [
                SettingsSwitchTile(
                  title: 'Análisis de Uso',
                  subtitle: 'Ayúdanos a mejorar la aplicación',
                  icon: Icons.analytics_outlined,
                  value: settings.analyticsTracking,
                  onChanged: settingsNotifier.updateAnalyticsTracking,
                ),
                SettingsSwitchTile(
                  title: 'Reportes de Errores',
                  subtitle: 'Envía reportes automáticos de errores',
                  icon: Icons.bug_report_outlined,
                  value: settings.crashReporting,
                  onChanged: settingsNotifier.updateCrashReporting,
                ),
                SettingsTile(
                  title: 'Política de Privacidad',
                  subtitle: 'Lee nuestra política de privacidad',
                  icon: Icons.privacy_tip_outlined,
                  onTap: () => _showPrivacyPolicy(),
                ),
                SettingsTile(
                  title: 'Términos de Servicio',
                  subtitle: 'Lee nuestros términos de servicio',
                  icon: Icons.description_outlined,
                  onTap: () => _showTermsOfService(),
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sección de Cuenta
            SettingsSection(
              title: 'Cuenta',
              children: [
                SettingsActionTile(
                  title: 'Eliminar Cuenta',
                  subtitle: 'Elimina permanentemente tu cuenta',
                  icon: Icons.delete_outline,
                  textColor: AppColors.error,
                  onTap: () => _showDeleteAccountDialog(),
                ),
                SettingsActionTile(
                  title: 'Cerrar Sesión',
                  subtitle: 'Cierra sesión en todos los dispositivos',
                  icon: Icons.logout,
                  textColor: AppColors.warning,
                  onTap: () => _showLogoutDialog(),
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sección de Información
            SettingsSection(
              title: 'Información',
              children: [
                SettingsTile(
                  title: 'Acerca de',
                  subtitle: 'Información sobre la aplicación',
                  icon: Icons.info_outline,
                  onTap: () => _navigateToAbout(),
                ),
                SettingsTile(
                  title: 'Versión',
                  subtitle: '1.0.0',
                  icon: Icons.update_outlined,
                  trailing: null,
                  onTap: () => _checkForUpdates(),
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Botón de Restablecer Configuración
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showResetDialog(settingsNotifier),
                  icon: const Icon(Icons.restore_outlined),
                  label: const Text('Restablecer Configuración'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: AppColors.grey300),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _saveSettings(SettingsNotifier settingsNotifier) {
    settingsNotifier.saveSettings();
    AppToast.showSuccess(context, 'Configuración guardada exitosamente');
  }

  void _navigateToChangePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChangePasswordScreen(),
      ),
    );
  }

  void _navigateToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AboutScreen(),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, SettingsNotifier settingsNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeOption.options.map((theme) {
            return RadioListTile<String>(
              title: Text(theme.name),
              subtitle: Text(theme.description),
              value: theme.code,
              groupValue: ref.read(settingsProvider).theme,
              onChanged: (value) {
                if (value != null) {
                  settingsNotifier.updateTheme(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, SettingsNotifier settingsNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LanguageOption.options.map((language) {
            return RadioListTile<String>(
              title: Text('${language.flag} ${language.name}'),
              value: language.code,
              groupValue: ref.read(settingsProvider).language,
              onChanged: (value) {
                if (value != null) {
                  settingsNotifier.updateLanguage(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    AppToast.showInfo(context, 'Política de privacidad próximamente');
  }

  void _showTermsOfService() {
    AppToast.showInfo(context, 'Términos de servicio próximamente');
  }

  void _checkForUpdates() {
    AppToast.showInfo(context, 'Verificando actualizaciones...');
  }

  void _showResetDialog(SettingsNotifier settingsNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restablecer Configuración'),
        content: const Text('¿Estás seguro de que quieres restablecer todas las configuraciones a sus valores predeterminados?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              settingsNotifier.resetToDefaults();
              Navigator.pop(context);
              AppToast.showSuccess(context, 'Configuración restablecida');
            },
            child: const Text('Restablecer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Cuenta'),
        content: const Text('¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AppToast.showError(context, 'Función de eliminación de cuenta próximamente');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
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
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authProvider.notifier).logout();
              AppToast.showSuccess(context, 'Sesión cerrada exitosamente');
            },
            child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
