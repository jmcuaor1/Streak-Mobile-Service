// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role =>
      throw _privateConstructorUsedError; // 'client', 'freelancer', 'admin'
  String get accountStatus =>
      throw _privateConstructorUsedError; // 'pending_verification', 'active', 'inactive', 'suspended'
  ProfileModel get profile => throw _privateConstructorUsedError;
  FreelancerProfileModel? get freelancerProfile =>
      throw _privateConstructorUsedError;
  PreferencesModel get preferences => throw _privateConstructorUsedError;
  GamificationModel get gamification => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String email,
      String role,
      String accountStatus,
      ProfileModel profile,
      FreelancerProfileModel? freelancerProfile,
      PreferencesModel preferences,
      GamificationModel gamification,
      DateTime? lastLoginAt,
      DateTime createdAt,
      DateTime updatedAt});

  $ProfileModelCopyWith<$Res> get profile;
  $FreelancerProfileModelCopyWith<$Res>? get freelancerProfile;
  $PreferencesModelCopyWith<$Res> get preferences;
  $GamificationModelCopyWith<$Res> get gamification;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? accountStatus = null,
    Object? profile = null,
    Object? freelancerProfile = freezed,
    Object? preferences = null,
    Object? gamification = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      accountStatus: null == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      freelancerProfile: freezed == freelancerProfile
          ? _value.freelancerProfile
          : freelancerProfile // ignore: cast_nullable_to_non_nullable
              as FreelancerProfileModel?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as PreferencesModel,
      gamification: null == gamification
          ? _value.gamification
          : gamification // ignore: cast_nullable_to_non_nullable
              as GamificationModel,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get profile {
    return $ProfileModelCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FreelancerProfileModelCopyWith<$Res>? get freelancerProfile {
    if (_value.freelancerProfile == null) {
      return null;
    }

    return $FreelancerProfileModelCopyWith<$Res>(_value.freelancerProfile!,
        (value) {
      return _then(_value.copyWith(freelancerProfile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PreferencesModelCopyWith<$Res> get preferences {
    return $PreferencesModelCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GamificationModelCopyWith<$Res> get gamification {
    return $GamificationModelCopyWith<$Res>(_value.gamification, (value) {
      return _then(_value.copyWith(gamification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String email,
      String role,
      String accountStatus,
      ProfileModel profile,
      FreelancerProfileModel? freelancerProfile,
      PreferencesModel preferences,
      GamificationModel gamification,
      DateTime? lastLoginAt,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $ProfileModelCopyWith<$Res> get profile;
  @override
  $FreelancerProfileModelCopyWith<$Res>? get freelancerProfile;
  @override
  $PreferencesModelCopyWith<$Res> get preferences;
  @override
  $GamificationModelCopyWith<$Res> get gamification;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? accountStatus = null,
    Object? profile = null,
    Object? freelancerProfile = freezed,
    Object? preferences = null,
    Object? gamification = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      accountStatus: null == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      freelancerProfile: freezed == freelancerProfile
          ? _value.freelancerProfile
          : freelancerProfile // ignore: cast_nullable_to_non_nullable
              as FreelancerProfileModel?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as PreferencesModel,
      gamification: null == gamification
          ? _value.gamification
          : gamification // ignore: cast_nullable_to_non_nullable
              as GamificationModel,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.email,
      required this.role,
      required this.accountStatus,
      required this.profile,
      this.freelancerProfile,
      required this.preferences,
      required this.gamification,
      this.lastLoginAt,
      required this.createdAt,
      required this.updatedAt});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String email;
  @override
  final String role;
// 'client', 'freelancer', 'admin'
  @override
  final String accountStatus;
// 'pending_verification', 'active', 'inactive', 'suspended'
  @override
  final ProfileModel profile;
  @override
  final FreelancerProfileModel? freelancerProfile;
  @override
  final PreferencesModel preferences;
  @override
  final GamificationModel gamification;
  @override
  final DateTime? lastLoginAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, role: $role, accountStatus: $accountStatus, profile: $profile, freelancerProfile: $freelancerProfile, preferences: $preferences, gamification: $gamification, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.accountStatus, accountStatus) ||
                other.accountStatus == accountStatus) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.freelancerProfile, freelancerProfile) ||
                other.freelancerProfile == freelancerProfile) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.gamification, gamification) ||
                other.gamification == gamification) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      role,
      accountStatus,
      profile,
      freelancerProfile,
      preferences,
      gamification,
      lastLoginAt,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {@JsonKey(name: '_id') required final String id,
      required final String email,
      required final String role,
      required final String accountStatus,
      required final ProfileModel profile,
      final FreelancerProfileModel? freelancerProfile,
      required final PreferencesModel preferences,
      required final GamificationModel gamification,
      final DateTime? lastLoginAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get email;
  @override
  String get role;
  @override // 'client', 'freelancer', 'admin'
  String get accountStatus;
  @override // 'pending_verification', 'active', 'inactive', 'suspended'
  ProfileModel get profile;
  @override
  FreelancerProfileModel? get freelancerProfile;
  @override
  PreferencesModel get preferences;
  @override
  GamificationModel get gamification;
  @override
  DateTime? get lastLoginAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String? avatar,
      String? phone,
      AddressModel? address,
      String? bio,
      String? headline});

  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? avatar = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? bio = freezed,
    Object? headline = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
          _$ProfileModelImpl value, $Res Function(_$ProfileModelImpl) then) =
      __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String? avatar,
      String? phone,
      AddressModel? address,
      String? bio,
      String? headline});

  @override
  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
      _$ProfileModelImpl _value, $Res Function(_$ProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? avatar = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? bio = freezed,
    Object? headline = freezed,
  }) {
    return _then(_$ProfileModelImpl(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl(
      {required this.firstName,
      required this.lastName,
      this.avatar,
      this.phone,
      this.address,
      this.bio,
      this.headline});

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? avatar;
  @override
  final String? phone;
  @override
  final AddressModel? address;
  @override
  final String? bio;
  @override
  final String? headline;

  @override
  String toString() {
    return 'ProfileModel(firstName: $firstName, lastName: $lastName, avatar: $avatar, phone: $phone, address: $address, bio: $bio, headline: $headline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.headline, headline) ||
                other.headline == headline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, firstName, lastName, avatar, phone, address, bio, headline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel(
      {required final String firstName,
      required final String lastName,
      final String? avatar,
      final String? phone,
      final AddressModel? address,
      final String? bio,
      final String? headline}) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get avatar;
  @override
  String? get phone;
  @override
  AddressModel? get address;
  @override
  String? get bio;
  @override
  String? get headline;
  @override
  @JsonKey(ignore: true)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return _AddressModel.fromJson(json);
}

/// @nodoc
mixin _$AddressModel {
  String? get street => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
          AddressModel value, $Res Function(AddressModel) then) =
      _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call(
      {String? street,
      String? city,
      String? state,
      String? zipCode,
      String? country});
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
    Object? country = freezed,
  }) {
    return _then(_value.copyWith(
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressModelImplCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$AddressModelImplCopyWith(
          _$AddressModelImpl value, $Res Function(_$AddressModelImpl) then) =
      __$$AddressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? street,
      String? city,
      String? state,
      String? zipCode,
      String? country});
}

/// @nodoc
class __$$AddressModelImplCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$AddressModelImpl>
    implements _$$AddressModelImplCopyWith<$Res> {
  __$$AddressModelImplCopyWithImpl(
      _$AddressModelImpl _value, $Res Function(_$AddressModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
    Object? country = freezed,
  }) {
    return _then(_$AddressModelImpl(
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressModelImpl implements _AddressModel {
  const _$AddressModelImpl(
      {this.street, this.city, this.state, this.zipCode, this.country});

  factory _$AddressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressModelImplFromJson(json);

  @override
  final String? street;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? zipCode;
  @override
  final String? country;

  @override
  String toString() {
    return 'AddressModel(street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressModelImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, city, state, zipCode, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      __$$AddressModelImplCopyWithImpl<_$AddressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressModelImplToJson(
      this,
    );
  }
}

abstract class _AddressModel implements AddressModel {
  const factory _AddressModel(
      {final String? street,
      final String? city,
      final String? state,
      final String? zipCode,
      final String? country}) = _$AddressModelImpl;

  factory _AddressModel.fromJson(Map<String, dynamic> json) =
      _$AddressModelImpl.fromJson;

  @override
  String? get street;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get zipCode;
  @override
  String? get country;
  @override
  @JsonKey(ignore: true)
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FreelancerProfileModel _$FreelancerProfileModelFromJson(
    Map<String, dynamic> json) {
  return _FreelancerProfileModel.fromJson(json);
}

/// @nodoc
mixin _$FreelancerProfileModel {
  String? get bio => throw _privateConstructorUsedError;
  List<String> get skills => throw _privateConstructorUsedError;
  List<String> get portfolio => throw _privateConstructorUsedError;
  double? get hourlyRate => throw _privateConstructorUsedError;
  String? get availability =>
      throw _privateConstructorUsedError; // 'full-time', 'part-time', 'open'
  String? get experienceLevel =>
      throw _privateConstructorUsedError; // 'junior', 'mid', 'senior'
  List<LanguageModel> get languages => throw _privateConstructorUsedError;
  int? get responseTime => throw _privateConstructorUsedError;
  String? get deliveryTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreelancerProfileModelCopyWith<FreelancerProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreelancerProfileModelCopyWith<$Res> {
  factory $FreelancerProfileModelCopyWith(FreelancerProfileModel value,
          $Res Function(FreelancerProfileModel) then) =
      _$FreelancerProfileModelCopyWithImpl<$Res, FreelancerProfileModel>;
  @useResult
  $Res call(
      {String? bio,
      List<String> skills,
      List<String> portfolio,
      double? hourlyRate,
      String? availability,
      String? experienceLevel,
      List<LanguageModel> languages,
      int? responseTime,
      String? deliveryTime});
}

/// @nodoc
class _$FreelancerProfileModelCopyWithImpl<$Res,
        $Val extends FreelancerProfileModel>
    implements $FreelancerProfileModelCopyWith<$Res> {
  _$FreelancerProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bio = freezed,
    Object? skills = null,
    Object? portfolio = null,
    Object? hourlyRate = freezed,
    Object? availability = freezed,
    Object? experienceLevel = freezed,
    Object? languages = null,
    Object? responseTime = freezed,
    Object? deliveryTime = freezed,
  }) {
    return _then(_value.copyWith(
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      portfolio: null == portfolio
          ? _value.portfolio
          : portfolio // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String?,
      experienceLevel: freezed == experienceLevel
          ? _value.experienceLevel
          : experienceLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      languages: null == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<LanguageModel>,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryTime: freezed == deliveryTime
          ? _value.deliveryTime
          : deliveryTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreelancerProfileModelImplCopyWith<$Res>
    implements $FreelancerProfileModelCopyWith<$Res> {
  factory _$$FreelancerProfileModelImplCopyWith(
          _$FreelancerProfileModelImpl value,
          $Res Function(_$FreelancerProfileModelImpl) then) =
      __$$FreelancerProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? bio,
      List<String> skills,
      List<String> portfolio,
      double? hourlyRate,
      String? availability,
      String? experienceLevel,
      List<LanguageModel> languages,
      int? responseTime,
      String? deliveryTime});
}

/// @nodoc
class __$$FreelancerProfileModelImplCopyWithImpl<$Res>
    extends _$FreelancerProfileModelCopyWithImpl<$Res,
        _$FreelancerProfileModelImpl>
    implements _$$FreelancerProfileModelImplCopyWith<$Res> {
  __$$FreelancerProfileModelImplCopyWithImpl(
      _$FreelancerProfileModelImpl _value,
      $Res Function(_$FreelancerProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bio = freezed,
    Object? skills = null,
    Object? portfolio = null,
    Object? hourlyRate = freezed,
    Object? availability = freezed,
    Object? experienceLevel = freezed,
    Object? languages = null,
    Object? responseTime = freezed,
    Object? deliveryTime = freezed,
  }) {
    return _then(_$FreelancerProfileModelImpl(
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      portfolio: null == portfolio
          ? _value._portfolio
          : portfolio // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String?,
      experienceLevel: freezed == experienceLevel
          ? _value.experienceLevel
          : experienceLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      languages: null == languages
          ? _value._languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<LanguageModel>,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryTime: freezed == deliveryTime
          ? _value.deliveryTime
          : deliveryTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreelancerProfileModelImpl implements _FreelancerProfileModel {
  const _$FreelancerProfileModelImpl(
      {this.bio,
      final List<String> skills = const [],
      final List<String> portfolio = const [],
      this.hourlyRate,
      this.availability,
      this.experienceLevel,
      final List<LanguageModel> languages = const [],
      this.responseTime,
      this.deliveryTime})
      : _skills = skills,
        _portfolio = portfolio,
        _languages = languages;

  factory _$FreelancerProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreelancerProfileModelImplFromJson(json);

  @override
  final String? bio;
  final List<String> _skills;
  @override
  @JsonKey()
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<String> _portfolio;
  @override
  @JsonKey()
  List<String> get portfolio {
    if (_portfolio is EqualUnmodifiableListView) return _portfolio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_portfolio);
  }

  @override
  final double? hourlyRate;
  @override
  final String? availability;
// 'full-time', 'part-time', 'open'
  @override
  final String? experienceLevel;
// 'junior', 'mid', 'senior'
  final List<LanguageModel> _languages;
// 'junior', 'mid', 'senior'
  @override
  @JsonKey()
  List<LanguageModel> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  @override
  final int? responseTime;
  @override
  final String? deliveryTime;

  @override
  String toString() {
    return 'FreelancerProfileModel(bio: $bio, skills: $skills, portfolio: $portfolio, hourlyRate: $hourlyRate, availability: $availability, experienceLevel: $experienceLevel, languages: $languages, responseTime: $responseTime, deliveryTime: $deliveryTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreelancerProfileModelImpl &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._portfolio, _portfolio) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.availability, availability) ||
                other.availability == availability) &&
            (identical(other.experienceLevel, experienceLevel) ||
                other.experienceLevel == experienceLevel) &&
            const DeepCollectionEquality()
                .equals(other._languages, _languages) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.deliveryTime, deliveryTime) ||
                other.deliveryTime == deliveryTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bio,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_portfolio),
      hourlyRate,
      availability,
      experienceLevel,
      const DeepCollectionEquality().hash(_languages),
      responseTime,
      deliveryTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreelancerProfileModelImplCopyWith<_$FreelancerProfileModelImpl>
      get copyWith => __$$FreelancerProfileModelImplCopyWithImpl<
          _$FreelancerProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreelancerProfileModelImplToJson(
      this,
    );
  }
}

abstract class _FreelancerProfileModel implements FreelancerProfileModel {
  const factory _FreelancerProfileModel(
      {final String? bio,
      final List<String> skills,
      final List<String> portfolio,
      final double? hourlyRate,
      final String? availability,
      final String? experienceLevel,
      final List<LanguageModel> languages,
      final int? responseTime,
      final String? deliveryTime}) = _$FreelancerProfileModelImpl;

  factory _FreelancerProfileModel.fromJson(Map<String, dynamic> json) =
      _$FreelancerProfileModelImpl.fromJson;

  @override
  String? get bio;
  @override
  List<String> get skills;
  @override
  List<String> get portfolio;
  @override
  double? get hourlyRate;
  @override
  String? get availability;
  @override // 'full-time', 'part-time', 'open'
  String? get experienceLevel;
  @override // 'junior', 'mid', 'senior'
  List<LanguageModel> get languages;
  @override
  int? get responseTime;
  @override
  String? get deliveryTime;
  @override
  @JsonKey(ignore: true)
  _$$FreelancerProfileModelImplCopyWith<_$FreelancerProfileModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) {
  return _LanguageModel.fromJson(json);
}

/// @nodoc
mixin _$LanguageModel {
  String get language => throw _privateConstructorUsedError;
  String get proficiency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LanguageModelCopyWith<LanguageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageModelCopyWith<$Res> {
  factory $LanguageModelCopyWith(
          LanguageModel value, $Res Function(LanguageModel) then) =
      _$LanguageModelCopyWithImpl<$Res, LanguageModel>;
  @useResult
  $Res call({String language, String proficiency});
}

/// @nodoc
class _$LanguageModelCopyWithImpl<$Res, $Val extends LanguageModel>
    implements $LanguageModelCopyWith<$Res> {
  _$LanguageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? proficiency = null,
  }) {
    return _then(_value.copyWith(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      proficiency: null == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageModelImplCopyWith<$Res>
    implements $LanguageModelCopyWith<$Res> {
  factory _$$LanguageModelImplCopyWith(
          _$LanguageModelImpl value, $Res Function(_$LanguageModelImpl) then) =
      __$$LanguageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String language, String proficiency});
}

/// @nodoc
class __$$LanguageModelImplCopyWithImpl<$Res>
    extends _$LanguageModelCopyWithImpl<$Res, _$LanguageModelImpl>
    implements _$$LanguageModelImplCopyWith<$Res> {
  __$$LanguageModelImplCopyWithImpl(
      _$LanguageModelImpl _value, $Res Function(_$LanguageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? proficiency = null,
  }) {
    return _then(_$LanguageModelImpl(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      proficiency: null == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageModelImpl implements _LanguageModel {
  const _$LanguageModelImpl(
      {required this.language, required this.proficiency});

  factory _$LanguageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageModelImplFromJson(json);

  @override
  final String language;
  @override
  final String proficiency;

  @override
  String toString() {
    return 'LanguageModel(language: $language, proficiency: $proficiency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageModelImpl &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, language, proficiency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      __$$LanguageModelImplCopyWithImpl<_$LanguageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageModelImplToJson(
      this,
    );
  }
}

abstract class _LanguageModel implements LanguageModel {
  const factory _LanguageModel(
      {required final String language,
      required final String proficiency}) = _$LanguageModelImpl;

  factory _LanguageModel.fromJson(Map<String, dynamic> json) =
      _$LanguageModelImpl.fromJson;

  @override
  String get language;
  @override
  String get proficiency;
  @override
  @JsonKey(ignore: true)
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreferencesModel _$PreferencesModelFromJson(Map<String, dynamic> json) {
  return _PreferencesModel.fromJson(json);
}

/// @nodoc
mixin _$PreferencesModel {
  NotificationsModel get notifications => throw _privateConstructorUsedError;
  String get theme => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferencesModelCopyWith<PreferencesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferencesModelCopyWith<$Res> {
  factory $PreferencesModelCopyWith(
          PreferencesModel value, $Res Function(PreferencesModel) then) =
      _$PreferencesModelCopyWithImpl<$Res, PreferencesModel>;
  @useResult
  $Res call(
      {NotificationsModel notifications,
      String theme,
      String language,
      String currency});

  $NotificationsModelCopyWith<$Res> get notifications;
}

/// @nodoc
class _$PreferencesModelCopyWithImpl<$Res, $Val extends PreferencesModel>
    implements $PreferencesModelCopyWith<$Res> {
  _$PreferencesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? theme = null,
    Object? language = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationsModel,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationsModelCopyWith<$Res> get notifications {
    return $NotificationsModelCopyWith<$Res>(_value.notifications, (value) {
      return _then(_value.copyWith(notifications: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PreferencesModelImplCopyWith<$Res>
    implements $PreferencesModelCopyWith<$Res> {
  factory _$$PreferencesModelImplCopyWith(_$PreferencesModelImpl value,
          $Res Function(_$PreferencesModelImpl) then) =
      __$$PreferencesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationsModel notifications,
      String theme,
      String language,
      String currency});

  @override
  $NotificationsModelCopyWith<$Res> get notifications;
}

/// @nodoc
class __$$PreferencesModelImplCopyWithImpl<$Res>
    extends _$PreferencesModelCopyWithImpl<$Res, _$PreferencesModelImpl>
    implements _$$PreferencesModelImplCopyWith<$Res> {
  __$$PreferencesModelImplCopyWithImpl(_$PreferencesModelImpl _value,
      $Res Function(_$PreferencesModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? theme = null,
    Object? language = null,
    Object? currency = null,
  }) {
    return _then(_$PreferencesModelImpl(
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationsModel,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferencesModelImpl implements _PreferencesModel {
  const _$PreferencesModelImpl(
      {required this.notifications,
      this.theme = 'light',
      this.language = 'es',
      this.currency = 'USD'});

  factory _$PreferencesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferencesModelImplFromJson(json);

  @override
  final NotificationsModel notifications;
  @override
  @JsonKey()
  final String theme;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'PreferencesModel(notifications: $notifications, theme: $theme, language: $language, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferencesModelImpl &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notifications, theme, language, currency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferencesModelImplCopyWith<_$PreferencesModelImpl> get copyWith =>
      __$$PreferencesModelImplCopyWithImpl<_$PreferencesModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferencesModelImplToJson(
      this,
    );
  }
}

abstract class _PreferencesModel implements PreferencesModel {
  const factory _PreferencesModel(
      {required final NotificationsModel notifications,
      final String theme,
      final String language,
      final String currency}) = _$PreferencesModelImpl;

  factory _PreferencesModel.fromJson(Map<String, dynamic> json) =
      _$PreferencesModelImpl.fromJson;

  @override
  NotificationsModel get notifications;
  @override
  String get theme;
  @override
  String get language;
  @override
  String get currency;
  @override
  @JsonKey(ignore: true)
  _$$PreferencesModelImplCopyWith<_$PreferencesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) {
  return _NotificationsModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationsModel {
  bool get email => throw _privateConstructorUsedError;
  bool get push => throw _privateConstructorUsedError;
  bool get sms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsModelCopyWith<NotificationsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsModelCopyWith<$Res> {
  factory $NotificationsModelCopyWith(
          NotificationsModel value, $Res Function(NotificationsModel) then) =
      _$NotificationsModelCopyWithImpl<$Res, NotificationsModel>;
  @useResult
  $Res call({bool email, bool push, bool sms});
}

/// @nodoc
class _$NotificationsModelCopyWithImpl<$Res, $Val extends NotificationsModel>
    implements $NotificationsModelCopyWith<$Res> {
  _$NotificationsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? push = null,
    Object? sms = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as bool,
      push: null == push
          ? _value.push
          : push // ignore: cast_nullable_to_non_nullable
              as bool,
      sms: null == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsModelImplCopyWith<$Res>
    implements $NotificationsModelCopyWith<$Res> {
  factory _$$NotificationsModelImplCopyWith(_$NotificationsModelImpl value,
          $Res Function(_$NotificationsModelImpl) then) =
      __$$NotificationsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool email, bool push, bool sms});
}

/// @nodoc
class __$$NotificationsModelImplCopyWithImpl<$Res>
    extends _$NotificationsModelCopyWithImpl<$Res, _$NotificationsModelImpl>
    implements _$$NotificationsModelImplCopyWith<$Res> {
  __$$NotificationsModelImplCopyWithImpl(_$NotificationsModelImpl _value,
      $Res Function(_$NotificationsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? push = null,
    Object? sms = null,
  }) {
    return _then(_$NotificationsModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as bool,
      push: null == push
          ? _value.push
          : push // ignore: cast_nullable_to_non_nullable
              as bool,
      sms: null == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsModelImpl implements _NotificationsModel {
  const _$NotificationsModelImpl(
      {this.email = true, this.push = true, this.sms = false});

  factory _$NotificationsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsModelImplFromJson(json);

  @override
  @JsonKey()
  final bool email;
  @override
  @JsonKey()
  final bool push;
  @override
  @JsonKey()
  final bool sms;

  @override
  String toString() {
    return 'NotificationsModel(email: $email, push: $push, sms: $sms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.push, push) || other.push == push) &&
            (identical(other.sms, sms) || other.sms == sms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, push, sms);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsModelImplCopyWith<_$NotificationsModelImpl> get copyWith =>
      __$$NotificationsModelImplCopyWithImpl<_$NotificationsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationsModel implements NotificationsModel {
  const factory _NotificationsModel(
      {final bool email,
      final bool push,
      final bool sms}) = _$NotificationsModelImpl;

  factory _NotificationsModel.fromJson(Map<String, dynamic> json) =
      _$NotificationsModelImpl.fromJson;

  @override
  bool get email;
  @override
  bool get push;
  @override
  bool get sms;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsModelImplCopyWith<_$NotificationsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GamificationModel _$GamificationModelFromJson(Map<String, dynamic> json) {
  return _GamificationModel.fromJson(json);
}

/// @nodoc
mixin _$GamificationModel {
  int get totalPoints => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  DateTime? get lastActivityDate => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamificationModelCopyWith<GamificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamificationModelCopyWith<$Res> {
  factory $GamificationModelCopyWith(
          GamificationModel value, $Res Function(GamificationModel) then) =
      _$GamificationModelCopyWithImpl<$Res, GamificationModel>;
  @useResult
  $Res call(
      {int totalPoints,
      int level,
      int currentStreak,
      DateTime? lastActivityDate,
      List<String> achievements});
}

/// @nodoc
class _$GamificationModelCopyWithImpl<$Res, $Val extends GamificationModel>
    implements $GamificationModelCopyWith<$Res> {
  _$GamificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPoints = null,
    Object? level = null,
    Object? currentStreak = null,
    Object? lastActivityDate = freezed,
    Object? achievements = null,
  }) {
    return _then(_value.copyWith(
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityDate: freezed == lastActivityDate
          ? _value.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamificationModelImplCopyWith<$Res>
    implements $GamificationModelCopyWith<$Res> {
  factory _$$GamificationModelImplCopyWith(_$GamificationModelImpl value,
          $Res Function(_$GamificationModelImpl) then) =
      __$$GamificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalPoints,
      int level,
      int currentStreak,
      DateTime? lastActivityDate,
      List<String> achievements});
}

/// @nodoc
class __$$GamificationModelImplCopyWithImpl<$Res>
    extends _$GamificationModelCopyWithImpl<$Res, _$GamificationModelImpl>
    implements _$$GamificationModelImplCopyWith<$Res> {
  __$$GamificationModelImplCopyWithImpl(_$GamificationModelImpl _value,
      $Res Function(_$GamificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPoints = null,
    Object? level = null,
    Object? currentStreak = null,
    Object? lastActivityDate = freezed,
    Object? achievements = null,
  }) {
    return _then(_$GamificationModelImpl(
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityDate: freezed == lastActivityDate
          ? _value.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamificationModelImpl implements _GamificationModel {
  const _$GamificationModelImpl(
      {this.totalPoints = 0,
      this.level = 1,
      this.currentStreak = 0,
      this.lastActivityDate,
      final List<String> achievements = const []})
      : _achievements = achievements;

  factory _$GamificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamificationModelImplFromJson(json);

  @override
  @JsonKey()
  final int totalPoints;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  final DateTime? lastActivityDate;
  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  String toString() {
    return 'GamificationModel(totalPoints: $totalPoints, level: $level, currentStreak: $currentStreak, lastActivityDate: $lastActivityDate, achievements: $achievements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamificationModelImpl &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.lastActivityDate, lastActivityDate) ||
                other.lastActivityDate == lastActivityDate) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalPoints,
      level,
      currentStreak,
      lastActivityDate,
      const DeepCollectionEquality().hash(_achievements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamificationModelImplCopyWith<_$GamificationModelImpl> get copyWith =>
      __$$GamificationModelImplCopyWithImpl<_$GamificationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamificationModelImplToJson(
      this,
    );
  }
}

abstract class _GamificationModel implements GamificationModel {
  const factory _GamificationModel(
      {final int totalPoints,
      final int level,
      final int currentStreak,
      final DateTime? lastActivityDate,
      final List<String> achievements}) = _$GamificationModelImpl;

  factory _GamificationModel.fromJson(Map<String, dynamic> json) =
      _$GamificationModelImpl.fromJson;

  @override
  int get totalPoints;
  @override
  int get level;
  @override
  int get currentStreak;
  @override
  DateTime? get lastActivityDate;
  @override
  List<String> get achievements;
  @override
  @JsonKey(ignore: true)
  _$$GamificationModelImplCopyWith<_$GamificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
