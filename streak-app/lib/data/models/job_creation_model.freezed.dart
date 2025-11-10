// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_creation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JobCreationModel _$JobCreationModelFromJson(Map<String, dynamic> json) {
  return _JobCreationModel.fromJson(json);
}

/// @nodoc
mixin _$JobCreationModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get subcategory => throw _privateConstructorUsedError;
  JobType get type => throw _privateConstructorUsedError;
  List<String> get skillsRequired => throw _privateConstructorUsedError;
  ExperienceLevel get experienceLevel => throw _privateConstructorUsedError;
  String? get estimatedDuration => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;
  bool get isRemote => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  BudgetInfo? get budget => throw _privateConstructorUsedError;
  HourlyRateInfo? get hourlyRate => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String? get additionalRequirements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCreationModelCopyWith<JobCreationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCreationModelCopyWith<$Res> {
  factory $JobCreationModelCopyWith(
          JobCreationModel value, $Res Function(JobCreationModel) then) =
      _$JobCreationModelCopyWithImpl<$Res, JobCreationModel>;
  @useResult
  $Res call(
      {String title,
      String description,
      String category,
      String? subcategory,
      JobType type,
      List<String> skillsRequired,
      ExperienceLevel experienceLevel,
      String? estimatedDuration,
      bool isUrgent,
      bool isRemote,
      String? location,
      BudgetInfo? budget,
      HourlyRateInfo? hourlyRate,
      List<String> attachments,
      List<String> tags,
      String status,
      DateTime? deadline,
      String? additionalRequirements});

  $BudgetInfoCopyWith<$Res>? get budget;
  $HourlyRateInfoCopyWith<$Res>? get hourlyRate;
}

/// @nodoc
class _$JobCreationModelCopyWithImpl<$Res, $Val extends JobCreationModel>
    implements $JobCreationModelCopyWith<$Res> {
  _$JobCreationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? type = null,
    Object? skillsRequired = null,
    Object? experienceLevel = null,
    Object? estimatedDuration = freezed,
    Object? isUrgent = null,
    Object? isRemote = null,
    Object? location = freezed,
    Object? budget = freezed,
    Object? hourlyRate = freezed,
    Object? attachments = null,
    Object? tags = null,
    Object? status = null,
    Object? deadline = freezed,
    Object? additionalRequirements = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as JobType,
      skillsRequired: null == skillsRequired
          ? _value.skillsRequired
          : skillsRequired // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experienceLevel: null == experienceLevel
          ? _value.experienceLevel
          : experienceLevel // ignore: cast_nullable_to_non_nullable
              as ExperienceLevel,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      isRemote: null == isRemote
          ? _value.isRemote
          : isRemote // ignore: cast_nullable_to_non_nullable
              as bool,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as BudgetInfo?,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as HourlyRateInfo?,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      additionalRequirements: freezed == additionalRequirements
          ? _value.additionalRequirements
          : additionalRequirements // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetInfoCopyWith<$Res>? get budget {
    if (_value.budget == null) {
      return null;
    }

    return $BudgetInfoCopyWith<$Res>(_value.budget!, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HourlyRateInfoCopyWith<$Res>? get hourlyRate {
    if (_value.hourlyRate == null) {
      return null;
    }

    return $HourlyRateInfoCopyWith<$Res>(_value.hourlyRate!, (value) {
      return _then(_value.copyWith(hourlyRate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JobCreationModelImplCopyWith<$Res>
    implements $JobCreationModelCopyWith<$Res> {
  factory _$$JobCreationModelImplCopyWith(_$JobCreationModelImpl value,
          $Res Function(_$JobCreationModelImpl) then) =
      __$$JobCreationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String category,
      String? subcategory,
      JobType type,
      List<String> skillsRequired,
      ExperienceLevel experienceLevel,
      String? estimatedDuration,
      bool isUrgent,
      bool isRemote,
      String? location,
      BudgetInfo? budget,
      HourlyRateInfo? hourlyRate,
      List<String> attachments,
      List<String> tags,
      String status,
      DateTime? deadline,
      String? additionalRequirements});

  @override
  $BudgetInfoCopyWith<$Res>? get budget;
  @override
  $HourlyRateInfoCopyWith<$Res>? get hourlyRate;
}

/// @nodoc
class __$$JobCreationModelImplCopyWithImpl<$Res>
    extends _$JobCreationModelCopyWithImpl<$Res, _$JobCreationModelImpl>
    implements _$$JobCreationModelImplCopyWith<$Res> {
  __$$JobCreationModelImplCopyWithImpl(_$JobCreationModelImpl _value,
      $Res Function(_$JobCreationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? type = null,
    Object? skillsRequired = null,
    Object? experienceLevel = null,
    Object? estimatedDuration = freezed,
    Object? isUrgent = null,
    Object? isRemote = null,
    Object? location = freezed,
    Object? budget = freezed,
    Object? hourlyRate = freezed,
    Object? attachments = null,
    Object? tags = null,
    Object? status = null,
    Object? deadline = freezed,
    Object? additionalRequirements = freezed,
  }) {
    return _then(_$JobCreationModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as JobType,
      skillsRequired: null == skillsRequired
          ? _value._skillsRequired
          : skillsRequired // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experienceLevel: null == experienceLevel
          ? _value.experienceLevel
          : experienceLevel // ignore: cast_nullable_to_non_nullable
              as ExperienceLevel,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      isRemote: null == isRemote
          ? _value.isRemote
          : isRemote // ignore: cast_nullable_to_non_nullable
              as bool,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as BudgetInfo?,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as HourlyRateInfo?,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      additionalRequirements: freezed == additionalRequirements
          ? _value.additionalRequirements
          : additionalRequirements // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobCreationModelImpl implements _JobCreationModel {
  const _$JobCreationModelImpl(
      {required this.title,
      required this.description,
      required this.category,
      this.subcategory,
      required this.type,
      required final List<String> skillsRequired,
      required this.experienceLevel,
      this.estimatedDuration,
      this.isUrgent = false,
      this.isRemote = false,
      this.location,
      this.budget,
      this.hourlyRate,
      final List<String> attachments = const [],
      final List<String> tags = const [],
      this.status = 'open',
      this.deadline,
      this.additionalRequirements})
      : _skillsRequired = skillsRequired,
        _attachments = attachments,
        _tags = tags;

  factory _$JobCreationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobCreationModelImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
  @override
  final String? subcategory;
  @override
  final JobType type;
  final List<String> _skillsRequired;
  @override
  List<String> get skillsRequired {
    if (_skillsRequired is EqualUnmodifiableListView) return _skillsRequired;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skillsRequired);
  }

  @override
  final ExperienceLevel experienceLevel;
  @override
  final String? estimatedDuration;
  @override
  @JsonKey()
  final bool isUrgent;
  @override
  @JsonKey()
  final bool isRemote;
  @override
  final String? location;
  @override
  final BudgetInfo? budget;
  @override
  final HourlyRateInfo? hourlyRate;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? deadline;
  @override
  final String? additionalRequirements;

  @override
  String toString() {
    return 'JobCreationModel(title: $title, description: $description, category: $category, subcategory: $subcategory, type: $type, skillsRequired: $skillsRequired, experienceLevel: $experienceLevel, estimatedDuration: $estimatedDuration, isUrgent: $isUrgent, isRemote: $isRemote, location: $location, budget: $budget, hourlyRate: $hourlyRate, attachments: $attachments, tags: $tags, status: $status, deadline: $deadline, additionalRequirements: $additionalRequirements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobCreationModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._skillsRequired, _skillsRequired) &&
            (identical(other.experienceLevel, experienceLevel) ||
                other.experienceLevel == experienceLevel) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.isRemote, isRemote) ||
                other.isRemote == isRemote) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.additionalRequirements, additionalRequirements) ||
                other.additionalRequirements == additionalRequirements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      category,
      subcategory,
      type,
      const DeepCollectionEquality().hash(_skillsRequired),
      experienceLevel,
      estimatedDuration,
      isUrgent,
      isRemote,
      location,
      budget,
      hourlyRate,
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_tags),
      status,
      deadline,
      additionalRequirements);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobCreationModelImplCopyWith<_$JobCreationModelImpl> get copyWith =>
      __$$JobCreationModelImplCopyWithImpl<_$JobCreationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobCreationModelImplToJson(
      this,
    );
  }
}

abstract class _JobCreationModel implements JobCreationModel {
  const factory _JobCreationModel(
      {required final String title,
      required final String description,
      required final String category,
      final String? subcategory,
      required final JobType type,
      required final List<String> skillsRequired,
      required final ExperienceLevel experienceLevel,
      final String? estimatedDuration,
      final bool isUrgent,
      final bool isRemote,
      final String? location,
      final BudgetInfo? budget,
      final HourlyRateInfo? hourlyRate,
      final List<String> attachments,
      final List<String> tags,
      final String status,
      final DateTime? deadline,
      final String? additionalRequirements}) = _$JobCreationModelImpl;

  factory _JobCreationModel.fromJson(Map<String, dynamic> json) =
      _$JobCreationModelImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get category;
  @override
  String? get subcategory;
  @override
  JobType get type;
  @override
  List<String> get skillsRequired;
  @override
  ExperienceLevel get experienceLevel;
  @override
  String? get estimatedDuration;
  @override
  bool get isUrgent;
  @override
  bool get isRemote;
  @override
  String? get location;
  @override
  BudgetInfo? get budget;
  @override
  HourlyRateInfo? get hourlyRate;
  @override
  List<String> get attachments;
  @override
  List<String> get tags;
  @override
  String get status;
  @override
  DateTime? get deadline;
  @override
  String? get additionalRequirements;
  @override
  @JsonKey(ignore: true)
  _$$JobCreationModelImplCopyWith<_$JobCreationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetInfo _$BudgetInfoFromJson(Map<String, dynamic> json) {
  return _BudgetInfo.fromJson(json);
}

/// @nodoc
mixin _$BudgetInfo {
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get isNegotiable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetInfoCopyWith<BudgetInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetInfoCopyWith<$Res> {
  factory $BudgetInfoCopyWith(
          BudgetInfo value, $Res Function(BudgetInfo) then) =
      _$BudgetInfoCopyWithImpl<$Res, BudgetInfo>;
  @useResult
  $Res call({double amount, String currency, bool isNegotiable});
}

/// @nodoc
class _$BudgetInfoCopyWithImpl<$Res, $Val extends BudgetInfo>
    implements $BudgetInfoCopyWith<$Res> {
  _$BudgetInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? currency = null,
    Object? isNegotiable = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isNegotiable: null == isNegotiable
          ? _value.isNegotiable
          : isNegotiable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetInfoImplCopyWith<$Res>
    implements $BudgetInfoCopyWith<$Res> {
  factory _$$BudgetInfoImplCopyWith(
          _$BudgetInfoImpl value, $Res Function(_$BudgetInfoImpl) then) =
      __$$BudgetInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, String currency, bool isNegotiable});
}

/// @nodoc
class __$$BudgetInfoImplCopyWithImpl<$Res>
    extends _$BudgetInfoCopyWithImpl<$Res, _$BudgetInfoImpl>
    implements _$$BudgetInfoImplCopyWith<$Res> {
  __$$BudgetInfoImplCopyWithImpl(
      _$BudgetInfoImpl _value, $Res Function(_$BudgetInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? currency = null,
    Object? isNegotiable = null,
  }) {
    return _then(_$BudgetInfoImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isNegotiable: null == isNegotiable
          ? _value.isNegotiable
          : isNegotiable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetInfoImpl implements _BudgetInfo {
  const _$BudgetInfoImpl(
      {required this.amount,
      required this.currency,
      this.isNegotiable = false});

  factory _$BudgetInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetInfoImplFromJson(json);

  @override
  final double amount;
  @override
  final String currency;
  @override
  @JsonKey()
  final bool isNegotiable;

  @override
  String toString() {
    return 'BudgetInfo(amount: $amount, currency: $currency, isNegotiable: $isNegotiable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetInfoImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isNegotiable, isNegotiable) ||
                other.isNegotiable == isNegotiable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, currency, isNegotiable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetInfoImplCopyWith<_$BudgetInfoImpl> get copyWith =>
      __$$BudgetInfoImplCopyWithImpl<_$BudgetInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetInfoImplToJson(
      this,
    );
  }
}

abstract class _BudgetInfo implements BudgetInfo {
  const factory _BudgetInfo(
      {required final double amount,
      required final String currency,
      final bool isNegotiable}) = _$BudgetInfoImpl;

  factory _BudgetInfo.fromJson(Map<String, dynamic> json) =
      _$BudgetInfoImpl.fromJson;

  @override
  double get amount;
  @override
  String get currency;
  @override
  bool get isNegotiable;
  @override
  @JsonKey(ignore: true)
  _$$BudgetInfoImplCopyWith<_$BudgetInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HourlyRateInfo _$HourlyRateInfoFromJson(Map<String, dynamic> json) {
  return _HourlyRateInfo.fromJson(json);
}

/// @nodoc
mixin _$HourlyRateInfo {
  double get minRate => throw _privateConstructorUsedError;
  double get maxRate => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get isNegotiable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HourlyRateInfoCopyWith<HourlyRateInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HourlyRateInfoCopyWith<$Res> {
  factory $HourlyRateInfoCopyWith(
          HourlyRateInfo value, $Res Function(HourlyRateInfo) then) =
      _$HourlyRateInfoCopyWithImpl<$Res, HourlyRateInfo>;
  @useResult
  $Res call(
      {double minRate, double maxRate, String currency, bool isNegotiable});
}

/// @nodoc
class _$HourlyRateInfoCopyWithImpl<$Res, $Val extends HourlyRateInfo>
    implements $HourlyRateInfoCopyWith<$Res> {
  _$HourlyRateInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minRate = null,
    Object? maxRate = null,
    Object? currency = null,
    Object? isNegotiable = null,
  }) {
    return _then(_value.copyWith(
      minRate: null == minRate
          ? _value.minRate
          : minRate // ignore: cast_nullable_to_non_nullable
              as double,
      maxRate: null == maxRate
          ? _value.maxRate
          : maxRate // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isNegotiable: null == isNegotiable
          ? _value.isNegotiable
          : isNegotiable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HourlyRateInfoImplCopyWith<$Res>
    implements $HourlyRateInfoCopyWith<$Res> {
  factory _$$HourlyRateInfoImplCopyWith(_$HourlyRateInfoImpl value,
          $Res Function(_$HourlyRateInfoImpl) then) =
      __$$HourlyRateInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double minRate, double maxRate, String currency, bool isNegotiable});
}

/// @nodoc
class __$$HourlyRateInfoImplCopyWithImpl<$Res>
    extends _$HourlyRateInfoCopyWithImpl<$Res, _$HourlyRateInfoImpl>
    implements _$$HourlyRateInfoImplCopyWith<$Res> {
  __$$HourlyRateInfoImplCopyWithImpl(
      _$HourlyRateInfoImpl _value, $Res Function(_$HourlyRateInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minRate = null,
    Object? maxRate = null,
    Object? currency = null,
    Object? isNegotiable = null,
  }) {
    return _then(_$HourlyRateInfoImpl(
      minRate: null == minRate
          ? _value.minRate
          : minRate // ignore: cast_nullable_to_non_nullable
              as double,
      maxRate: null == maxRate
          ? _value.maxRate
          : maxRate // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isNegotiable: null == isNegotiable
          ? _value.isNegotiable
          : isNegotiable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HourlyRateInfoImpl implements _HourlyRateInfo {
  const _$HourlyRateInfoImpl(
      {required this.minRate,
      required this.maxRate,
      required this.currency,
      this.isNegotiable = false});

  factory _$HourlyRateInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HourlyRateInfoImplFromJson(json);

  @override
  final double minRate;
  @override
  final double maxRate;
  @override
  final String currency;
  @override
  @JsonKey()
  final bool isNegotiable;

  @override
  String toString() {
    return 'HourlyRateInfo(minRate: $minRate, maxRate: $maxRate, currency: $currency, isNegotiable: $isNegotiable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HourlyRateInfoImpl &&
            (identical(other.minRate, minRate) || other.minRate == minRate) &&
            (identical(other.maxRate, maxRate) || other.maxRate == maxRate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isNegotiable, isNegotiable) ||
                other.isNegotiable == isNegotiable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, minRate, maxRate, currency, isNegotiable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HourlyRateInfoImplCopyWith<_$HourlyRateInfoImpl> get copyWith =>
      __$$HourlyRateInfoImplCopyWithImpl<_$HourlyRateInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HourlyRateInfoImplToJson(
      this,
    );
  }
}

abstract class _HourlyRateInfo implements HourlyRateInfo {
  const factory _HourlyRateInfo(
      {required final double minRate,
      required final double maxRate,
      required final String currency,
      final bool isNegotiable}) = _$HourlyRateInfoImpl;

  factory _HourlyRateInfo.fromJson(Map<String, dynamic> json) =
      _$HourlyRateInfoImpl.fromJson;

  @override
  double get minRate;
  @override
  double get maxRate;
  @override
  String get currency;
  @override
  bool get isNegotiable;
  @override
  @JsonKey(ignore: true)
  _$$HourlyRateInfoImplCopyWith<_$HourlyRateInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
