import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/settings_model.dart';

class SettingsNotifier extends Notifier<SettingsModel> {
  @override
  SettingsModel build() {
    return const SettingsModel();
  }

  void updateEmailNotifications(bool value) {
    state = state.copyWith(emailNotifications: value);
  }

  void updatePushNotifications(bool value) {
    state = state.copyWith(pushNotifications: value);
  }

  void updateSmsNotifications(bool value) {
    state = state.copyWith(smsNotifications: value);
  }

  void updateMarketingEmails(bool value) {
    state = state.copyWith(marketingEmails: value);
  }

  void updateJobAlerts(bool value) {
    state = state.copyWith(jobAlerts: value);
  }

  void updateConnectionRequests(bool value) {
    state = state.copyWith(connectionRequests: value);
  }

  void updateLanguage(String language) {
    state = state.copyWith(language: language);
  }

  void updateTheme(String theme) {
    state = state.copyWith(theme: theme);
  }

  void updateBiometricAuth(bool value) {
    state = state.copyWith(biometricAuth: value);
  }

  void updateTwoFactorAuth(bool value) {
    state = state.copyWith(twoFactorAuth: value);
  }

  void updateLocationTracking(bool value) {
    state = state.copyWith(locationTracking: value);
  }

  void updateAnalyticsTracking(bool value) {
    state = state.copyWith(analyticsTracking: value);
  }

  void updateCrashReporting(bool value) {
    state = state.copyWith(crashReporting: value);
  }

  void saveSettings() {
    state = state.copyWith(lastUpdated: DateTime.now());
  }

  void resetToDefaults() {
    state = const SettingsModel();
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsModel>(() {
  return SettingsNotifier();
});
