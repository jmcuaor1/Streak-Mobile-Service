import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modelo de Usuario - Sincronizado con el backend
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: '_id') required String id,
    required String email,
    required String role, // 'client', 'freelancer', 'admin'
    required String accountStatus, // 'pending_verification', 'active', 'inactive', 'suspended'
    required ProfileModel profile,
    FreelancerProfileModel? freelancerProfile,
    required PreferencesModel preferences,
    required GamificationModel gamification,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Extensión para UserModel con getters adicionales
extension UserModelX on UserModel {
  String get fullName => '${profile.firstName} ${profile.lastName}';
  
  bool get isFreelancer => role == 'freelancer';
  bool get isClient => role == 'client';
  bool get isAdmin => role == 'admin';
  
  bool get isActive => accountStatus == 'active';
  bool get isPendingVerification => accountStatus == 'pending_verification';
}

/// Modelo de Perfil de Usuario
@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String firstName,
    required String lastName,
    String? avatar,
    String? phone,
    AddressModel? address,
    String? bio,
    String? headline,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

/// Modelo de Dirección
@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

/// Modelo de Perfil de Freelancer
@freezed
class FreelancerProfileModel with _$FreelancerProfileModel {
  const factory FreelancerProfileModel({
    String? bio,
    @Default([]) List<String> skills,
    @Default([]) List<String> portfolio,
    double? hourlyRate,
    String? availability, // 'full-time', 'part-time', 'open'
    String? experienceLevel, // 'junior', 'mid', 'senior'
    @Default([]) List<LanguageModel> languages,
    int? responseTime,
    String? deliveryTime,
  }) = _FreelancerProfileModel;

  factory FreelancerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$FreelancerProfileModelFromJson(json);
}

/// Modelo de Idioma
@freezed
class LanguageModel with _$LanguageModel {
  const factory LanguageModel({
    required String language,
    required String proficiency, // 'basic', 'conversational', 'fluent', 'native'
  }) = _LanguageModel;

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
}

/// Modelo de Preferencias
@freezed
class PreferencesModel with _$PreferencesModel {
  const factory PreferencesModel({
    required NotificationsModel notifications,
    @Default('light') String theme,
    @Default('es') String language,
    @Default('USD') String currency,
  }) = _PreferencesModel;

  factory PreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$PreferencesModelFromJson(json);
}

/// Modelo de Notificaciones
@freezed
class NotificationsModel with _$NotificationsModel {
  const factory NotificationsModel({
    @Default(true) bool email,
    @Default(true) bool push,
    @Default(false) bool sms,
  }) = _NotificationsModel;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);
}

/// Modelo de Gamificación
@freezed
class GamificationModel with _$GamificationModel {
  const factory GamificationModel({
    @Default(0) int totalPoints,
    @Default(1) int level,
    @Default(0) int currentStreak,
    DateTime? lastActivityDate,
    @Default([]) List<String> achievements,
  }) = _GamificationModel;

  factory GamificationModel.fromJson(Map<String, dynamic> json) =>
      _$GamificationModelFromJson(json);
}


