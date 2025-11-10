// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      emailNotifications: json['emailNotifications'] as bool? ?? true,
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      smsNotifications: json['smsNotifications'] as bool? ?? false,
      marketingEmails: json['marketingEmails'] as bool? ?? false,
      jobAlerts: json['jobAlerts'] as bool? ?? false,
      connectionRequests: json['connectionRequests'] as bool? ?? false,
      language: json['language'] as String? ?? 'es',
      theme: json['theme'] as String? ?? 'light',
      biometricAuth: json['biometricAuth'] as bool? ?? false,
      twoFactorAuth: json['twoFactorAuth'] as bool? ?? false,
      locationTracking: json['locationTracking'] as bool? ?? false,
      analyticsTracking: json['analyticsTracking'] as bool? ?? false,
      crashReporting: json['crashReporting'] as bool? ?? false,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'emailNotifications': instance.emailNotifications,
      'pushNotifications': instance.pushNotifications,
      'smsNotifications': instance.smsNotifications,
      'marketingEmails': instance.marketingEmails,
      'jobAlerts': instance.jobAlerts,
      'connectionRequests': instance.connectionRequests,
      'language': instance.language,
      'theme': instance.theme,
      'biometricAuth': instance.biometricAuth,
      'twoFactorAuth': instance.twoFactorAuth,
      'locationTracking': instance.locationTracking,
      'analyticsTracking': instance.analyticsTracking,
      'crashReporting': instance.crashReporting,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
