// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) {
  return _ApplicationModel.fromJson(json);
}

/// @nodoc
mixin _$ApplicationModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get jobId => throw _privateConstructorUsedError;
  String get freelancerId => throw _privateConstructorUsedError;
  String get freelancerName => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  String get proposal => throw _privateConstructorUsedError;
  double? get bidAmount => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'pending', 'accepted', 'rejected'
  DateTime get appliedAt => throw _privateConstructorUsedError;
  DateTime? get reviewedAt => throw _privateConstructorUsedError;
  String? get clientNotes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplicationModelCopyWith<ApplicationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationModelCopyWith<$Res> {
  factory $ApplicationModelCopyWith(
          ApplicationModel value, $Res Function(ApplicationModel) then) =
      _$ApplicationModelCopyWithImpl<$Res, ApplicationModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String jobId,
      String freelancerId,
      String freelancerName,
      String jobTitle,
      String proposal,
      double? bidAmount,
      String status,
      DateTime appliedAt,
      DateTime? reviewedAt,
      String? clientNotes});
}

/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res, $Val extends ApplicationModel>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobId = null,
    Object? freelancerId = null,
    Object? freelancerName = null,
    Object? jobTitle = null,
    Object? proposal = null,
    Object? bidAmount = freezed,
    Object? status = null,
    Object? appliedAt = null,
    Object? reviewedAt = freezed,
    Object? clientNotes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobId: null == jobId
          ? _value.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      freelancerId: null == freelancerId
          ? _value.freelancerId
          : freelancerId // ignore: cast_nullable_to_non_nullable
              as String,
      freelancerName: null == freelancerName
          ? _value.freelancerName
          : freelancerName // ignore: cast_nullable_to_non_nullable
              as String,
      jobTitle: null == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      proposal: null == proposal
          ? _value.proposal
          : proposal // ignore: cast_nullable_to_non_nullable
              as String,
      bidAmount: freezed == bidAmount
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientNotes: freezed == clientNotes
          ? _value.clientNotes
          : clientNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationModelImplCopyWith<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  factory _$$ApplicationModelImplCopyWith(_$ApplicationModelImpl value,
          $Res Function(_$ApplicationModelImpl) then) =
      __$$ApplicationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String jobId,
      String freelancerId,
      String freelancerName,
      String jobTitle,
      String proposal,
      double? bidAmount,
      String status,
      DateTime appliedAt,
      DateTime? reviewedAt,
      String? clientNotes});
}

/// @nodoc
class __$$ApplicationModelImplCopyWithImpl<$Res>
    extends _$ApplicationModelCopyWithImpl<$Res, _$ApplicationModelImpl>
    implements _$$ApplicationModelImplCopyWith<$Res> {
  __$$ApplicationModelImplCopyWithImpl(_$ApplicationModelImpl _value,
      $Res Function(_$ApplicationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobId = null,
    Object? freelancerId = null,
    Object? freelancerName = null,
    Object? jobTitle = null,
    Object? proposal = null,
    Object? bidAmount = freezed,
    Object? status = null,
    Object? appliedAt = null,
    Object? reviewedAt = freezed,
    Object? clientNotes = freezed,
  }) {
    return _then(_$ApplicationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobId: null == jobId
          ? _value.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      freelancerId: null == freelancerId
          ? _value.freelancerId
          : freelancerId // ignore: cast_nullable_to_non_nullable
              as String,
      freelancerName: null == freelancerName
          ? _value.freelancerName
          : freelancerName // ignore: cast_nullable_to_non_nullable
              as String,
      jobTitle: null == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      proposal: null == proposal
          ? _value.proposal
          : proposal // ignore: cast_nullable_to_non_nullable
              as String,
      bidAmount: freezed == bidAmount
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientNotes: freezed == clientNotes
          ? _value.clientNotes
          : clientNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationModelImpl implements _ApplicationModel {
  const _$ApplicationModelImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.jobId,
      required this.freelancerId,
      required this.freelancerName,
      required this.jobTitle,
      required this.proposal,
      this.bidAmount,
      required this.status,
      required this.appliedAt,
      this.reviewedAt,
      this.clientNotes});

  factory _$ApplicationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String jobId;
  @override
  final String freelancerId;
  @override
  final String freelancerName;
  @override
  final String jobTitle;
  @override
  final String proposal;
  @override
  final double? bidAmount;
  @override
  final String status;
// 'pending', 'accepted', 'rejected'
  @override
  final DateTime appliedAt;
  @override
  final DateTime? reviewedAt;
  @override
  final String? clientNotes;

  @override
  String toString() {
    return 'ApplicationModel(id: $id, jobId: $jobId, freelancerId: $freelancerId, freelancerName: $freelancerName, jobTitle: $jobTitle, proposal: $proposal, bidAmount: $bidAmount, status: $status, appliedAt: $appliedAt, reviewedAt: $reviewedAt, clientNotes: $clientNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.freelancerId, freelancerId) ||
                other.freelancerId == freelancerId) &&
            (identical(other.freelancerName, freelancerName) ||
                other.freelancerName == freelancerName) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.proposal, proposal) ||
                other.proposal == proposal) &&
            (identical(other.bidAmount, bidAmount) ||
                other.bidAmount == bidAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.clientNotes, clientNotes) ||
                other.clientNotes == clientNotes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      jobId,
      freelancerId,
      freelancerName,
      jobTitle,
      proposal,
      bidAmount,
      status,
      appliedAt,
      reviewedAt,
      clientNotes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationModelImplCopyWith<_$ApplicationModelImpl> get copyWith =>
      __$$ApplicationModelImplCopyWithImpl<_$ApplicationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationModelImplToJson(
      this,
    );
  }
}

abstract class _ApplicationModel implements ApplicationModel {
  const factory _ApplicationModel(
      {@JsonKey(name: '_id') required final String id,
      required final String jobId,
      required final String freelancerId,
      required final String freelancerName,
      required final String jobTitle,
      required final String proposal,
      final double? bidAmount,
      required final String status,
      required final DateTime appliedAt,
      final DateTime? reviewedAt,
      final String? clientNotes}) = _$ApplicationModelImpl;

  factory _ApplicationModel.fromJson(Map<String, dynamic> json) =
      _$ApplicationModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get jobId;
  @override
  String get freelancerId;
  @override
  String get freelancerName;
  @override
  String get jobTitle;
  @override
  String get proposal;
  @override
  double? get bidAmount;
  @override
  String get status;
  @override // 'pending', 'accepted', 'rejected'
  DateTime get appliedAt;
  @override
  DateTime? get reviewedAt;
  @override
  String? get clientNotes;
  @override
  @JsonKey(ignore: true)
  _$$ApplicationModelImplCopyWith<_$ApplicationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
