// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['_id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      accountStatus: json['accountStatus'] as String,
      profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      freelancerProfile: json['freelancerProfile'] == null
          ? null
          : FreelancerProfileModel.fromJson(
              json['freelancerProfile'] as Map<String, dynamic>),
      preferences: PreferencesModel.fromJson(
          json['preferences'] as Map<String, dynamic>),
      gamification: GamificationModel.fromJson(
          json['gamification'] as Map<String, dynamic>),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'accountStatus': instance.accountStatus,
      'profile': instance.profile,
      'freelancerProfile': instance.freelancerProfile,
      'preferences': instance.preferences,
      'gamification': instance.gamification,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      bio: json['bio'] as String?,
      headline: json['headline'] as String?,
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'address': instance.address,
      'bio': instance.bio,
      'headline': instance.headline,
    };

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
    };

_$FreelancerProfileModelImpl _$$FreelancerProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FreelancerProfileModelImpl(
      bio: json['bio'] as String?,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      portfolio: (json['portfolio'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
      availability: json['availability'] as String?,
      experienceLevel: json['experienceLevel'] as String?,
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      responseTime: (json['responseTime'] as num?)?.toInt(),
      deliveryTime: json['deliveryTime'] as String?,
    );

Map<String, dynamic> _$$FreelancerProfileModelImplToJson(
        _$FreelancerProfileModelImpl instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'skills': instance.skills,
      'portfolio': instance.portfolio,
      'hourlyRate': instance.hourlyRate,
      'availability': instance.availability,
      'experienceLevel': instance.experienceLevel,
      'languages': instance.languages,
      'responseTime': instance.responseTime,
      'deliveryTime': instance.deliveryTime,
    };

_$LanguageModelImpl _$$LanguageModelImplFromJson(Map<String, dynamic> json) =>
    _$LanguageModelImpl(
      language: json['language'] as String,
      proficiency: json['proficiency'] as String,
    );

Map<String, dynamic> _$$LanguageModelImplToJson(_$LanguageModelImpl instance) =>
    <String, dynamic>{
      'language': instance.language,
      'proficiency': instance.proficiency,
    };

_$PreferencesModelImpl _$$PreferencesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PreferencesModelImpl(
      notifications: NotificationsModel.fromJson(
          json['notifications'] as Map<String, dynamic>),
      theme: json['theme'] as String? ?? 'light',
      language: json['language'] as String? ?? 'es',
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$$PreferencesModelImplToJson(
        _$PreferencesModelImpl instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'theme': instance.theme,
      'language': instance.language,
      'currency': instance.currency,
    };

_$NotificationsModelImpl _$$NotificationsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsModelImpl(
      email: json['email'] as bool? ?? true,
      push: json['push'] as bool? ?? true,
      sms: json['sms'] as bool? ?? false,
    );

Map<String, dynamic> _$$NotificationsModelImplToJson(
        _$NotificationsModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'push': instance.push,
      'sms': instance.sms,
    };

_$GamificationModelImpl _$$GamificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GamificationModelImpl(
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      lastActivityDate: json['lastActivityDate'] == null
          ? null
          : DateTime.parse(json['lastActivityDate'] as String),
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GamificationModelImplToJson(
        _$GamificationModelImpl instance) =>
    <String, dynamic>{
      'totalPoints': instance.totalPoints,
      'level': instance.level,
      'currentStreak': instance.currentStreak,
      'lastActivityDate': instance.lastActivityDate?.toIso8601String(),
      'achievements': instance.achievements,
    };
