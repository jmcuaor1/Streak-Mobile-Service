import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    @Default(true) bool emailNotifications,
    @Default(true) bool pushNotifications,
    @Default(false) bool smsNotifications,
    @Default(false) bool marketingEmails,
    @Default(false) bool jobAlerts,
    @Default(false) bool connectionRequests,
    @Default('es') String language,
    @Default('light') String theme,
    @Default(false) bool biometricAuth,
    @Default(false) bool twoFactorAuth,
    @Default(false) bool locationTracking,
    @Default(false) bool analyticsTracking,
    @Default(false) bool crashReporting,
    DateTime? lastUpdated,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);
}

class LanguageOption {
  final String code;
  final String name;
  final String flag;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.flag,
  });

  static const List<LanguageOption> options = [
    LanguageOption(code: 'es', name: 'Español', flag: '🇪🇸'),
    LanguageOption(code: 'en', name: 'English', flag: '🇺🇸'),
    LanguageOption(code: 'fr', name: 'Français', flag: '🇫🇷'),
    LanguageOption(code: 'pt', name: 'Português', flag: '🇵🇹'),
  ];

  static LanguageOption getByCode(String code) {
    return options.firstWhere(
      (option) => option.code == code,
      orElse: () => options.first,
    );
  }
}

class ThemeOption {
  final String code;
  final String name;
  final String description;

  const ThemeOption({
    required this.code,
    required this.name,
    required this.description,
  });

  static const List<ThemeOption> options = [
    ThemeOption(
      code: 'light',
      name: 'Claro',
      description: 'Tema claro para uso diurno',
    ),
    ThemeOption(
      code: 'dark',
      name: 'Oscuro',
      description: 'Tema oscuro para uso nocturno',
    ),
    ThemeOption(
      code: 'system',
      name: 'Sistema',
      description: 'Seguir configuración del sistema',
    ),
  ];

  static ThemeOption getByCode(String code) {
    return options.firstWhere(
      (option) => option.code == code,
      orElse: () => options.first,
    );
  }
}
