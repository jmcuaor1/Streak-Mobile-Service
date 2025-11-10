// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JobModel _$JobModelFromJson(Map<String, dynamic> json) {
  return _JobModel.fromJson(json);
}

/// @nodoc
mixin _$JobModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get subcategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'clientId')
  ClientModel? get clientId =>
      throw _privateConstructorUsedError; // Cambiado de String a ClientModel?
  String get type =>
      throw _privateConstructorUsedError; // 'fixed_price' | 'hourly'
  double? get budget => throw _privateConstructorUsedError; // Para fixed_price
  HourlyRateModel? get hourlyRate =>
      throw _privateConstructorUsedError; // Para hourly
  @JsonKey(name: 'skillsRequired')
  List<String> get skillsRequired => throw _privateConstructorUsedError;
  String get experienceLevel =>
      throw _privateConstructorUsedError; // 'entry' | 'intermediate' | 'expert'
  String? get estimatedDuration => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'draft' | 'open' | 'in_progress' | 'completed' | 'cancelled'
  bool get isUrgent => throw _privateConstructorUsedError;
  @JsonKey(name: 'assignedFreelancerId')
  String? get assignedFreelancerId => throw _privateConstructorUsedError;
  StatsModel get stats => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get completionDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Campos populados
  ClientModel? get client => throw _privateConstructorUsedError;
  UserModel? get assignedFreelancer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobModelCopyWith<JobModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobModelCopyWith<$Res> {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) then) =
      _$JobModelCopyWithImpl<$Res, JobModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String title,
      String description,
      String category,
      String? subcategory,
      @JsonKey(name: 'clientId') ClientModel? clientId,
      String type,
      double? budget,
      HourlyRateModel? hourlyRate,
      @JsonKey(name: 'skillsRequired') List<String> skillsRequired,
      String experienceLevel,
      String? estimatedDuration,
      List<String> attachments,
      String status,
      bool isUrgent,
      @JsonKey(name: 'assignedFreelancerId') String? assignedFreelancerId,
      StatsModel stats,
      DateTime? deadline,
      DateTime? startDate,
      DateTime? completionDate,
      DateTime createdAt,
      DateTime updatedAt,
      ClientModel? client,
      UserModel? assignedFreelancer});

  $ClientModelCopyWith<$Res>? get clientId;
  $HourlyRateModelCopyWith<$Res>? get hourlyRate;
  $StatsModelCopyWith<$Res> get stats;
  $ClientModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res>? get assignedFreelancer;
}

/// @nodoc
class _$JobModelCopyWithImpl<$Res, $Val extends JobModel>
    implements $JobModelCopyWith<$Res> {
  _$JobModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? clientId = freezed,
    Object? type = null,
    Object? budget = freezed,
    Object? hourlyRate = freezed,
    Object? skillsRequired = null,
    Object? experienceLevel = null,
    Object? estimatedDuration = freezed,
    Object? attachments = null,
    Object? status = null,
    Object? isUrgent = null,
    Object? assignedFreelancerId = freezed,
    Object? stats = null,
    Object? deadline = freezed,
    Object? startDate = freezed,
    Object? completionDate = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? client = freezed,
    Object? assignedFreelancer = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as ClientModel?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double?,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as HourlyRateModel?,
      skillsRequired: null == skillsRequired
          ? _value.skillsRequired
          : skillsRequired // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experienceLevel: null == experienceLevel
          ? _value.experienceLevel
          : experienceLevel // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      assignedFreelancerId: freezed == assignedFreelancerId
          ? _value.assignedFreelancerId
          : assignedFreelancerId // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as StatsModel,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completionDate: freezed == completionDate
          ? _value.completionDate
          : completionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ClientModel?,
      assignedFreelancer: freezed == assignedFreelancer
          ? _value.assignedFreelancer
          : assignedFreelancer // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientModelCopyWith<$Res>? get clientId {
    if (_value.clientId == null) {
      return null;
    }

    return $ClientModelCopyWith<$Res>(_value.clientId!, (value) {
      return _then(_value.copyWith(clientId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HourlyRateModelCopyWith<$Res>? get hourlyRate {
    if (_value.hourlyRate == null) {
      return null;
    }

    return $HourlyRateModelCopyWith<$Res>(_value.hourlyRate!, (value) {
      return _then(_value.copyWith(hourlyRate: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatsModelCopyWith<$Res> get stats {
    return $StatsModelCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $ClientModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get assignedFreelancer {
    if (_value.assignedFreelancer == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.assignedFreelancer!, (value) {
      return _then(_value.copyWith(assignedFreelancer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JobModelImplCopyWith<$Res>
    implements $JobModelCopyWith<$Res> {
  factory _$$JobModelImplCopyWith(
          _$JobModelImpl value, $Res Function(_$JobModelImpl) then) =
      __$$JobModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String title,
      String description,
      String category,
      String? subcategory,
      @JsonKey(name: 'clientId') ClientModel? clientId,
      String type,
      double? budget,
      HourlyRateModel? hourlyRate,
      @JsonKey(name: 'skillsRequired') List<String> skillsRequired,
      String experienceLevel,
      String? estimatedDuration,
      List<String> attachments,
      String status,
      bool isUrgent,
      @JsonKey(name: 'assignedFreelancerId') String? assignedFreelancerId,
      StatsModel stats,
      DateTime? deadline,
      DateTime? startDate,
      DateTime? completionDate,
      DateTime createdAt,
      DateTime updatedAt,
      ClientModel? client,
      UserModel? assignedFreelancer});

  @override
  $ClientModelCopyWith<$Res>? get clientId;
  @override
  $HourlyRateModelCopyWith<$Res>? get hourlyRate;
  @override
  $StatsModelCopyWith<$Res> get stats;
  @override
  $ClientModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res>? get assignedFreelancer;
}

/// @nodoc
class __$$JobModelImplCopyWithImpl<$Res>
    extends _$JobModelCopyWithImpl<$Res, _$JobModelImpl>
    implements _$$JobModelImplCopyWith<$Res> {
  __$$JobModelImplCopyWithImpl(
      _$JobModelImpl _value, $Res Function(_$JobModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? clientId = freezed,
    Object? type = null,
    Object? budget = freezed,
    Object? hourlyRate = freezed,
    Object? skillsRequired = null,
    Object? experienceLevel = null,
    Object? estimatedDuration = freezed,
    Object? attachments = null,
    Object? status = null,
    Object? isUrgent = null,
    Object? assignedFreelancerId = freezed,
    Object? stats = null,
    Object? deadline = freezed,
    Object? startDate = freezed,
    Object? completionDate = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? client = freezed,
    Object? assignedFreelancer = freezed,
  }) {
    return _then(_$JobModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as ClientModel?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double?,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as HourlyRateModel?,
      skillsRequired: null == skillsRequired
          ? _value._skillsRequired
          : skillsRequired // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experienceLevel: null == experienceLevel
          ? _value.experienceLevel
          : experienceLevel // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      assignedFreelancerId: freezed == assignedFreelancerId
          ? _value.assignedFreelancerId
          : assignedFreelancerId // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as StatsModel,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completionDate: freezed == completionDate
          ? _value.completionDate
          : completionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ClientModel?,
      assignedFreelancer: freezed == assignedFreelancer
          ? _value.assignedFreelancer
          : assignedFreelancer // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobModelImpl implements _JobModel {
  const _$JobModelImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.title,
      required this.description,
      required this.category,
      this.subcategory,
      @JsonKey(name: 'clientId') this.clientId,
      required this.type,
      this.budget,
      this.hourlyRate,
      @JsonKey(name: 'skillsRequired')
      final List<String> skillsRequired = const [],
      this.experienceLevel = 'intermediate',
      this.estimatedDuration,
      final List<String> attachments = const [],
      required this.status,
      this.isUrgent = false,
      @JsonKey(name: 'assignedFreelancerId') this.assignedFreelancerId,
      required this.stats,
      this.deadline,
      this.startDate,
      this.completionDate,
      required this.createdAt,
      required this.updatedAt,
      this.client,
      this.assignedFreelancer})
      : _skillsRequired = skillsRequired,
        _attachments = attachments;

  factory _$JobModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
  @override
  final String? subcategory;
  @override
  @JsonKey(name: 'clientId')
  final ClientModel? clientId;
// Cambiado de String a ClientModel?
  @override
  final String type;
// 'fixed_price' | 'hourly'
  @override
  final double? budget;
// Para fixed_price
  @override
  final HourlyRateModel? hourlyRate;
// Para hourly
  final List<String> _skillsRequired;
// Para hourly
  @override
  @JsonKey(name: 'skillsRequired')
  List<String> get skillsRequired {
    if (_skillsRequired is EqualUnmodifiableListView) return _skillsRequired;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skillsRequired);
  }

  @override
  @JsonKey()
  final String experienceLevel;
// 'entry' | 'intermediate' | 'expert'
  @override
  final String? estimatedDuration;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final String status;
// 'draft' | 'open' | 'in_progress' | 'completed' | 'cancelled'
  @override
  @JsonKey()
  final bool isUrgent;
  @override
  @JsonKey(name: 'assignedFreelancerId')
  final String? assignedFreelancerId;
  @override
  final StatsModel stats;
  @override
  final DateTime? deadline;
  @override
  final DateTime? startDate;
  @override
  final DateTime? completionDate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// Campos populados
  @override
  final ClientModel? client;
  @override
  final UserModel? assignedFreelancer;

  @override
  String toString() {
    return 'JobModel(id: $id, title: $title, description: $description, category: $category, subcategory: $subcategory, clientId: $clientId, type: $type, budget: $budget, hourlyRate: $hourlyRate, skillsRequired: $skillsRequired, experienceLevel: $experienceLevel, estimatedDuration: $estimatedDuration, attachments: $attachments, status: $status, isUrgent: $isUrgent, assignedFreelancerId: $assignedFreelancerId, stats: $stats, deadline: $deadline, startDate: $startDate, completionDate: $completionDate, createdAt: $createdAt, updatedAt: $updatedAt, client: $client, assignedFreelancer: $assignedFreelancer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            const DeepCollectionEquality()
                .equals(other._skillsRequired, _skillsRequired) &&
            (identical(other.experienceLevel, experienceLevel) ||
                other.experienceLevel == experienceLevel) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.assignedFreelancerId, assignedFreelancerId) ||
                other.assignedFreelancerId == assignedFreelancerId) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.completionDate, completionDate) ||
                other.completionDate == completionDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.assignedFreelancer, assignedFreelancer) ||
                other.assignedFreelancer == assignedFreelancer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        category,
        subcategory,
        clientId,
        type,
        budget,
        hourlyRate,
        const DeepCollectionEquality().hash(_skillsRequired),
        experienceLevel,
        estimatedDuration,
        const DeepCollectionEquality().hash(_attachments),
        status,
        isUrgent,
        assignedFreelancerId,
        stats,
        deadline,
        startDate,
        completionDate,
        createdAt,
        updatedAt,
        client,
        assignedFreelancer
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobModelImplCopyWith<_$JobModelImpl> get copyWith =>
      __$$JobModelImplCopyWithImpl<_$JobModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobModelImplToJson(
      this,
    );
  }
}

abstract class _JobModel implements JobModel {
  const factory _JobModel(
      {@JsonKey(name: '_id') required final String id,
      required final String title,
      required final String description,
      required final String category,
      final String? subcategory,
      @JsonKey(name: 'clientId') final ClientModel? clientId,
      required final String type,
      final double? budget,
      final HourlyRateModel? hourlyRate,
      @JsonKey(name: 'skillsRequired') final List<String> skillsRequired,
      final String experienceLevel,
      final String? estimatedDuration,
      final List<String> attachments,
      required final String status,
      final bool isUrgent,
      @JsonKey(name: 'assignedFreelancerId') final String? assignedFreelancerId,
      required final StatsModel stats,
      final DateTime? deadline,
      final DateTime? startDate,
      final DateTime? completionDate,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final ClientModel? client,
      final UserModel? assignedFreelancer}) = _$JobModelImpl;

  factory _JobModel.fromJson(Map<String, dynamic> json) =
      _$JobModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get category;
  @override
  String? get subcategory;
  @override
  @JsonKey(name: 'clientId')
  ClientModel? get clientId;
  @override // Cambiado de String a ClientModel?
  String get type;
  @override // 'fixed_price' | 'hourly'
  double? get budget;
  @override // Para fixed_price
  HourlyRateModel? get hourlyRate;
  @override // Para hourly
  @JsonKey(name: 'skillsRequired')
  List<String> get skillsRequired;
  @override
  String get experienceLevel;
  @override // 'entry' | 'intermediate' | 'expert'
  String? get estimatedDuration;
  @override
  List<String> get attachments;
  @override
  String get status;
  @override // 'draft' | 'open' | 'in_progress' | 'completed' | 'cancelled'
  bool get isUrgent;
  @override
  @JsonKey(name: 'assignedFreelancerId')
  String? get assignedFreelancerId;
  @override
  StatsModel get stats;
  @override
  DateTime? get deadline;
  @override
  DateTime? get startDate;
  @override
  DateTime? get completionDate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override // Campos populados
  ClientModel? get client;
  @override
  UserModel? get assignedFreelancer;
  @override
  @JsonKey(ignore: true)
  _$$JobModelImplCopyWith<_$JobModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HourlyRateModel _$HourlyRateModelFromJson(Map<String, dynamic> json) {
  return _HourlyRateModel.fromJson(json);
}

/// @nodoc
mixin _$HourlyRateModel {
  double get min => throw _privateConstructorUsedError;
  double get max => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HourlyRateModelCopyWith<HourlyRateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HourlyRateModelCopyWith<$Res> {
  factory $HourlyRateModelCopyWith(
          HourlyRateModel value, $Res Function(HourlyRateModel) then) =
      _$HourlyRateModelCopyWithImpl<$Res, HourlyRateModel>;
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class _$HourlyRateModelCopyWithImpl<$Res, $Val extends HourlyRateModel>
    implements $HourlyRateModelCopyWith<$Res> {
  _$HourlyRateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_value.copyWith(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HourlyRateModelImplCopyWith<$Res>
    implements $HourlyRateModelCopyWith<$Res> {
  factory _$$HourlyRateModelImplCopyWith(_$HourlyRateModelImpl value,
          $Res Function(_$HourlyRateModelImpl) then) =
      __$$HourlyRateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class __$$HourlyRateModelImplCopyWithImpl<$Res>
    extends _$HourlyRateModelCopyWithImpl<$Res, _$HourlyRateModelImpl>
    implements _$$HourlyRateModelImplCopyWith<$Res> {
  __$$HourlyRateModelImplCopyWithImpl(
      _$HourlyRateModelImpl _value, $Res Function(_$HourlyRateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_$HourlyRateModelImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HourlyRateModelImpl implements _HourlyRateModel {
  const _$HourlyRateModelImpl({required this.min, required this.max});

  factory _$HourlyRateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HourlyRateModelImplFromJson(json);

  @override
  final double min;
  @override
  final double max;

  @override
  String toString() {
    return 'HourlyRateModel(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HourlyRateModelImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HourlyRateModelImplCopyWith<_$HourlyRateModelImpl> get copyWith =>
      __$$HourlyRateModelImplCopyWithImpl<_$HourlyRateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HourlyRateModelImplToJson(
      this,
    );
  }
}

abstract class _HourlyRateModel implements HourlyRateModel {
  const factory _HourlyRateModel(
      {required final double min,
      required final double max}) = _$HourlyRateModelImpl;

  factory _HourlyRateModel.fromJson(Map<String, dynamic> json) =
      _$HourlyRateModelImpl.fromJson;

  @override
  double get min;
  @override
  double get max;
  @override
  @JsonKey(ignore: true)
  _$$HourlyRateModelImplCopyWith<_$HourlyRateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) {
  return _StatsModel.fromJson(json);
}

/// @nodoc
mixin _$StatsModel {
  int get views => throw _privateConstructorUsedError;
  int get applicationsCount => throw _privateConstructorUsedError;
  int get savedCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsModelCopyWith<StatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsModelCopyWith<$Res> {
  factory $StatsModelCopyWith(
          StatsModel value, $Res Function(StatsModel) then) =
      _$StatsModelCopyWithImpl<$Res, StatsModel>;
  @useResult
  $Res call({int views, int applicationsCount, int savedCount});
}

/// @nodoc
class _$StatsModelCopyWithImpl<$Res, $Val extends StatsModel>
    implements $StatsModelCopyWith<$Res> {
  _$StatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? applicationsCount = null,
    Object? savedCount = null,
  }) {
    return _then(_value.copyWith(
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      applicationsCount: null == applicationsCount
          ? _value.applicationsCount
          : applicationsCount // ignore: cast_nullable_to_non_nullable
              as int,
      savedCount: null == savedCount
          ? _value.savedCount
          : savedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatsModelImplCopyWith<$Res>
    implements $StatsModelCopyWith<$Res> {
  factory _$$StatsModelImplCopyWith(
          _$StatsModelImpl value, $Res Function(_$StatsModelImpl) then) =
      __$$StatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int views, int applicationsCount, int savedCount});
}

/// @nodoc
class __$$StatsModelImplCopyWithImpl<$Res>
    extends _$StatsModelCopyWithImpl<$Res, _$StatsModelImpl>
    implements _$$StatsModelImplCopyWith<$Res> {
  __$$StatsModelImplCopyWithImpl(
      _$StatsModelImpl _value, $Res Function(_$StatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? applicationsCount = null,
    Object? savedCount = null,
  }) {
    return _then(_$StatsModelImpl(
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      applicationsCount: null == applicationsCount
          ? _value.applicationsCount
          : applicationsCount // ignore: cast_nullable_to_non_nullable
              as int,
      savedCount: null == savedCount
          ? _value.savedCount
          : savedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsModelImpl implements _StatsModel {
  const _$StatsModelImpl(
      {this.views = 0, this.applicationsCount = 0, this.savedCount = 0});

  factory _$StatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsModelImplFromJson(json);

  @override
  @JsonKey()
  final int views;
  @override
  @JsonKey()
  final int applicationsCount;
  @override
  @JsonKey()
  final int savedCount;

  @override
  String toString() {
    return 'StatsModel(views: $views, applicationsCount: $applicationsCount, savedCount: $savedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsModelImpl &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.applicationsCount, applicationsCount) ||
                other.applicationsCount == applicationsCount) &&
            (identical(other.savedCount, savedCount) ||
                other.savedCount == savedCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, views, applicationsCount, savedCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsModelImplCopyWith<_$StatsModelImpl> get copyWith =>
      __$$StatsModelImplCopyWithImpl<_$StatsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatsModelImplToJson(
      this,
    );
  }
}

abstract class _StatsModel implements StatsModel {
  const factory _StatsModel(
      {final int views,
      final int applicationsCount,
      final int savedCount}) = _$StatsModelImpl;

  factory _StatsModel.fromJson(Map<String, dynamic> json) =
      _$StatsModelImpl.fromJson;

  @override
  int get views;
  @override
  int get applicationsCount;
  @override
  int get savedCount;
  @override
  @JsonKey(ignore: true)
  _$$StatsModelImplCopyWith<_$StatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) {
  return _ClientModel.fromJson(json);
}

/// @nodoc
mixin _$ClientModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  ProfileModel get profile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientModelCopyWith<ClientModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientModelCopyWith<$Res> {
  factory $ClientModelCopyWith(
          ClientModel value, $Res Function(ClientModel) then) =
      _$ClientModelCopyWithImpl<$Res, ClientModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id, String email, ProfileModel profile});

  $ProfileModelCopyWith<$Res> get profile;
}

/// @nodoc
class _$ClientModelCopyWithImpl<$Res, $Val extends ClientModel>
    implements $ClientModelCopyWith<$Res> {
  _$ClientModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? profile = null,
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
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get profile {
    return $ProfileModelCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientModelImplCopyWith<$Res>
    implements $ClientModelCopyWith<$Res> {
  factory _$$ClientModelImplCopyWith(
          _$ClientModelImpl value, $Res Function(_$ClientModelImpl) then) =
      __$$ClientModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id, String email, ProfileModel profile});

  @override
  $ProfileModelCopyWith<$Res> get profile;
}

/// @nodoc
class __$$ClientModelImplCopyWithImpl<$Res>
    extends _$ClientModelCopyWithImpl<$Res, _$ClientModelImpl>
    implements _$$ClientModelImplCopyWith<$Res> {
  __$$ClientModelImplCopyWithImpl(
      _$ClientModelImpl _value, $Res Function(_$ClientModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? profile = null,
  }) {
    return _then(_$ClientModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientModelImpl implements _ClientModel {
  const _$ClientModelImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.email,
      required this.profile});

  factory _$ClientModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String email;
  @override
  final ProfileModel profile;

  @override
  String toString() {
    return 'ClientModel(id: $id, email: $email, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientModelImplCopyWith<_$ClientModelImpl> get copyWith =>
      __$$ClientModelImplCopyWithImpl<_$ClientModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientModelImplToJson(
      this,
    );
  }
}

abstract class _ClientModel implements ClientModel {
  const factory _ClientModel(
      {@JsonKey(name: '_id') required final String id,
      required final String email,
      required final ProfileModel profile}) = _$ClientModelImpl;

  factory _ClientModel.fromJson(Map<String, dynamic> json) =
      _$ClientModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get email;
  @override
  ProfileModel get profile;
  @override
  @JsonKey(ignore: true)
  _$$ClientModelImplCopyWith<_$ClientModelImpl> get copyWith =>
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
  $Res call({String firstName, String lastName, String? avatar});
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
    ) as $Val);
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
  $Res call({String firstName, String lastName, String? avatar});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl(
      {required this.firstName, required this.lastName, this.avatar});

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'ProfileModel(firstName: $firstName, lastName: $lastName, avatar: $avatar)';
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
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, avatar);

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
      final String? avatar}) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  ProfileModel get profile => throw _privateConstructorUsedError;

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
      {@JsonKey(name: '_id') String id, String email, ProfileModel profile});

  $ProfileModelCopyWith<$Res> get profile;
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
    Object? profile = null,
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
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get profile {
    return $ProfileModelCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
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
      {@JsonKey(name: '_id') String id, String email, ProfileModel profile});

  @override
  $ProfileModelCopyWith<$Res> get profile;
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
    Object? profile = null,
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
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.email,
      required this.profile});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String email;
  @override
  final ProfileModel profile;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, profile);

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
      required final ProfileModel profile}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get email;
  @override
  ProfileModel get profile;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
