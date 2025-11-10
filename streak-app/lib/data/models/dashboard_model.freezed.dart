// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) {
  return _DashboardModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardModel {
  UserStats get userStats => throw _privateConstructorUsedError;
  JobStats get jobStats => throw _privateConstructorUsedError;
  ProfileStats get profileStats => throw _privateConstructorUsedError;
  List<RecentActivity> get recentActivities =>
      throw _privateConstructorUsedError;
  List<Achievement> get achievements => throw _privateConstructorUsedError;
  List<JobRecommendation> get jobRecommendations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardModelCopyWith<DashboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardModelCopyWith<$Res> {
  factory $DashboardModelCopyWith(
          DashboardModel value, $Res Function(DashboardModel) then) =
      _$DashboardModelCopyWithImpl<$Res, DashboardModel>;
  @useResult
  $Res call(
      {UserStats userStats,
      JobStats jobStats,
      ProfileStats profileStats,
      List<RecentActivity> recentActivities,
      List<Achievement> achievements,
      List<JobRecommendation> jobRecommendations});

  $UserStatsCopyWith<$Res> get userStats;
  $JobStatsCopyWith<$Res> get jobStats;
  $ProfileStatsCopyWith<$Res> get profileStats;
}

/// @nodoc
class _$DashboardModelCopyWithImpl<$Res, $Val extends DashboardModel>
    implements $DashboardModelCopyWith<$Res> {
  _$DashboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userStats = null,
    Object? jobStats = null,
    Object? profileStats = null,
    Object? recentActivities = null,
    Object? achievements = null,
    Object? jobRecommendations = null,
  }) {
    return _then(_value.copyWith(
      userStats: null == userStats
          ? _value.userStats
          : userStats // ignore: cast_nullable_to_non_nullable
              as UserStats,
      jobStats: null == jobStats
          ? _value.jobStats
          : jobStats // ignore: cast_nullable_to_non_nullable
              as JobStats,
      profileStats: null == profileStats
          ? _value.profileStats
          : profileStats // ignore: cast_nullable_to_non_nullable
              as ProfileStats,
      recentActivities: null == recentActivities
          ? _value.recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<RecentActivity>,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<Achievement>,
      jobRecommendations: null == jobRecommendations
          ? _value.jobRecommendations
          : jobRecommendations // ignore: cast_nullable_to_non_nullable
              as List<JobRecommendation>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserStatsCopyWith<$Res> get userStats {
    return $UserStatsCopyWith<$Res>(_value.userStats, (value) {
      return _then(_value.copyWith(userStats: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $JobStatsCopyWith<$Res> get jobStats {
    return $JobStatsCopyWith<$Res>(_value.jobStats, (value) {
      return _then(_value.copyWith(jobStats: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileStatsCopyWith<$Res> get profileStats {
    return $ProfileStatsCopyWith<$Res>(_value.profileStats, (value) {
      return _then(_value.copyWith(profileStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardModelImplCopyWith<$Res>
    implements $DashboardModelCopyWith<$Res> {
  factory _$$DashboardModelImplCopyWith(_$DashboardModelImpl value,
          $Res Function(_$DashboardModelImpl) then) =
      __$$DashboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserStats userStats,
      JobStats jobStats,
      ProfileStats profileStats,
      List<RecentActivity> recentActivities,
      List<Achievement> achievements,
      List<JobRecommendation> jobRecommendations});

  @override
  $UserStatsCopyWith<$Res> get userStats;
  @override
  $JobStatsCopyWith<$Res> get jobStats;
  @override
  $ProfileStatsCopyWith<$Res> get profileStats;
}

/// @nodoc
class __$$DashboardModelImplCopyWithImpl<$Res>
    extends _$DashboardModelCopyWithImpl<$Res, _$DashboardModelImpl>
    implements _$$DashboardModelImplCopyWith<$Res> {
  __$$DashboardModelImplCopyWithImpl(
      _$DashboardModelImpl _value, $Res Function(_$DashboardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userStats = null,
    Object? jobStats = null,
    Object? profileStats = null,
    Object? recentActivities = null,
    Object? achievements = null,
    Object? jobRecommendations = null,
  }) {
    return _then(_$DashboardModelImpl(
      userStats: null == userStats
          ? _value.userStats
          : userStats // ignore: cast_nullable_to_non_nullable
              as UserStats,
      jobStats: null == jobStats
          ? _value.jobStats
          : jobStats // ignore: cast_nullable_to_non_nullable
              as JobStats,
      profileStats: null == profileStats
          ? _value.profileStats
          : profileStats // ignore: cast_nullable_to_non_nullable
              as ProfileStats,
      recentActivities: null == recentActivities
          ? _value._recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<RecentActivity>,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<Achievement>,
      jobRecommendations: null == jobRecommendations
          ? _value._jobRecommendations
          : jobRecommendations // ignore: cast_nullable_to_non_nullable
              as List<JobRecommendation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardModelImpl implements _DashboardModel {
  const _$DashboardModelImpl(
      {required this.userStats,
      required this.jobStats,
      required this.profileStats,
      required final List<RecentActivity> recentActivities,
      required final List<Achievement> achievements,
      required final List<JobRecommendation> jobRecommendations})
      : _recentActivities = recentActivities,
        _achievements = achievements,
        _jobRecommendations = jobRecommendations;

  factory _$DashboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardModelImplFromJson(json);

  @override
  final UserStats userStats;
  @override
  final JobStats jobStats;
  @override
  final ProfileStats profileStats;
  final List<RecentActivity> _recentActivities;
  @override
  List<RecentActivity> get recentActivities {
    if (_recentActivities is EqualUnmodifiableListView)
      return _recentActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivities);
  }

  final List<Achievement> _achievements;
  @override
  List<Achievement> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  final List<JobRecommendation> _jobRecommendations;
  @override
  List<JobRecommendation> get jobRecommendations {
    if (_jobRecommendations is EqualUnmodifiableListView)
      return _jobRecommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_jobRecommendations);
  }

  @override
  String toString() {
    return 'DashboardModel(userStats: $userStats, jobStats: $jobStats, profileStats: $profileStats, recentActivities: $recentActivities, achievements: $achievements, jobRecommendations: $jobRecommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardModelImpl &&
            (identical(other.userStats, userStats) ||
                other.userStats == userStats) &&
            (identical(other.jobStats, jobStats) ||
                other.jobStats == jobStats) &&
            (identical(other.profileStats, profileStats) ||
                other.profileStats == profileStats) &&
            const DeepCollectionEquality()
                .equals(other._recentActivities, _recentActivities) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            const DeepCollectionEquality()
                .equals(other._jobRecommendations, _jobRecommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userStats,
      jobStats,
      profileStats,
      const DeepCollectionEquality().hash(_recentActivities),
      const DeepCollectionEquality().hash(_achievements),
      const DeepCollectionEquality().hash(_jobRecommendations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      __$$DashboardModelImplCopyWithImpl<_$DashboardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardModel implements DashboardModel {
  const factory _DashboardModel(
          {required final UserStats userStats,
          required final JobStats jobStats,
          required final ProfileStats profileStats,
          required final List<RecentActivity> recentActivities,
          required final List<Achievement> achievements,
          required final List<JobRecommendation> jobRecommendations}) =
      _$DashboardModelImpl;

  factory _DashboardModel.fromJson(Map<String, dynamic> json) =
      _$DashboardModelImpl.fromJson;

  @override
  UserStats get userStats;
  @override
  JobStats get jobStats;
  @override
  ProfileStats get profileStats;
  @override
  List<RecentActivity> get recentActivities;
  @override
  List<Achievement> get achievements;
  @override
  List<JobRecommendation> get jobRecommendations;
  @override
  @JsonKey(ignore: true)
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  int get totalApplications => throw _privateConstructorUsedError;
  int get savedJobs => throw _privateConstructorUsedError;
  int get profileViews => throw _privateConstructorUsedError;
  int get connections => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;
  String get currentStreak => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {int totalApplications,
      int savedJobs,
      int profileViews,
      int connections,
      int streakDays,
      String currentStreak,
      int totalPoints});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalApplications = null,
    Object? savedJobs = null,
    Object? profileViews = null,
    Object? connections = null,
    Object? streakDays = null,
    Object? currentStreak = null,
    Object? totalPoints = null,
  }) {
    return _then(_value.copyWith(
      totalApplications: null == totalApplications
          ? _value.totalApplications
          : totalApplications // ignore: cast_nullable_to_non_nullable
              as int,
      savedJobs: null == savedJobs
          ? _value.savedJobs
          : savedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      profileViews: null == profileViews
          ? _value.profileViews
          : profileViews // ignore: cast_nullable_to_non_nullable
              as int,
      connections: null == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as String,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
          _$UserStatsImpl value, $Res Function(_$UserStatsImpl) then) =
      __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalApplications,
      int savedJobs,
      int profileViews,
      int connections,
      int streakDays,
      String currentStreak,
      int totalPoints});
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
      _$UserStatsImpl _value, $Res Function(_$UserStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalApplications = null,
    Object? savedJobs = null,
    Object? profileViews = null,
    Object? connections = null,
    Object? streakDays = null,
    Object? currentStreak = null,
    Object? totalPoints = null,
  }) {
    return _then(_$UserStatsImpl(
      totalApplications: null == totalApplications
          ? _value.totalApplications
          : totalApplications // ignore: cast_nullable_to_non_nullable
              as int,
      savedJobs: null == savedJobs
          ? _value.savedJobs
          : savedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      profileViews: null == profileViews
          ? _value.profileViews
          : profileViews // ignore: cast_nullable_to_non_nullable
              as int,
      connections: null == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as String,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl(
      {required this.totalApplications,
      required this.savedJobs,
      required this.profileViews,
      required this.connections,
      required this.streakDays,
      required this.currentStreak,
      required this.totalPoints});

  factory _$UserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsImplFromJson(json);

  @override
  final int totalApplications;
  @override
  final int savedJobs;
  @override
  final int profileViews;
  @override
  final int connections;
  @override
  final int streakDays;
  @override
  final String currentStreak;
  @override
  final int totalPoints;

  @override
  String toString() {
    return 'UserStats(totalApplications: $totalApplications, savedJobs: $savedJobs, profileViews: $profileViews, connections: $connections, streakDays: $streakDays, currentStreak: $currentStreak, totalPoints: $totalPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.totalApplications, totalApplications) ||
                other.totalApplications == totalApplications) &&
            (identical(other.savedJobs, savedJobs) ||
                other.savedJobs == savedJobs) &&
            (identical(other.profileViews, profileViews) ||
                other.profileViews == profileViews) &&
            (identical(other.connections, connections) ||
                other.connections == connections) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalApplications, savedJobs,
      profileViews, connections, streakDays, currentStreak, totalPoints);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsImplToJson(
      this,
    );
  }
}

abstract class _UserStats implements UserStats {
  const factory _UserStats(
      {required final int totalApplications,
      required final int savedJobs,
      required final int profileViews,
      required final int connections,
      required final int streakDays,
      required final String currentStreak,
      required final int totalPoints}) = _$UserStatsImpl;

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$UserStatsImpl.fromJson;

  @override
  int get totalApplications;
  @override
  int get savedJobs;
  @override
  int get profileViews;
  @override
  int get connections;
  @override
  int get streakDays;
  @override
  String get currentStreak;
  @override
  int get totalPoints;
  @override
  @JsonKey(ignore: true)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JobStats _$JobStatsFromJson(Map<String, dynamic> json) {
  return _JobStats.fromJson(json);
}

/// @nodoc
mixin _$JobStats {
  int get applicationsThisMonth => throw _privateConstructorUsedError;
  int get interviewsScheduled => throw _privateConstructorUsedError;
  int get offersReceived => throw _privateConstructorUsedError;
  double get applicationSuccessRate => throw _privateConstructorUsedError;
  List<String> get topSkills => throw _privateConstructorUsedError;
  List<String> get preferredJobTypes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobStatsCopyWith<JobStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobStatsCopyWith<$Res> {
  factory $JobStatsCopyWith(JobStats value, $Res Function(JobStats) then) =
      _$JobStatsCopyWithImpl<$Res, JobStats>;
  @useResult
  $Res call(
      {int applicationsThisMonth,
      int interviewsScheduled,
      int offersReceived,
      double applicationSuccessRate,
      List<String> topSkills,
      List<String> preferredJobTypes});
}

/// @nodoc
class _$JobStatsCopyWithImpl<$Res, $Val extends JobStats>
    implements $JobStatsCopyWith<$Res> {
  _$JobStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationsThisMonth = null,
    Object? interviewsScheduled = null,
    Object? offersReceived = null,
    Object? applicationSuccessRate = null,
    Object? topSkills = null,
    Object? preferredJobTypes = null,
  }) {
    return _then(_value.copyWith(
      applicationsThisMonth: null == applicationsThisMonth
          ? _value.applicationsThisMonth
          : applicationsThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      interviewsScheduled: null == interviewsScheduled
          ? _value.interviewsScheduled
          : interviewsScheduled // ignore: cast_nullable_to_non_nullable
              as int,
      offersReceived: null == offersReceived
          ? _value.offersReceived
          : offersReceived // ignore: cast_nullable_to_non_nullable
              as int,
      applicationSuccessRate: null == applicationSuccessRate
          ? _value.applicationSuccessRate
          : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
              as double,
      topSkills: null == topSkills
          ? _value.topSkills
          : topSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredJobTypes: null == preferredJobTypes
          ? _value.preferredJobTypes
          : preferredJobTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobStatsImplCopyWith<$Res>
    implements $JobStatsCopyWith<$Res> {
  factory _$$JobStatsImplCopyWith(
          _$JobStatsImpl value, $Res Function(_$JobStatsImpl) then) =
      __$$JobStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int applicationsThisMonth,
      int interviewsScheduled,
      int offersReceived,
      double applicationSuccessRate,
      List<String> topSkills,
      List<String> preferredJobTypes});
}

/// @nodoc
class __$$JobStatsImplCopyWithImpl<$Res>
    extends _$JobStatsCopyWithImpl<$Res, _$JobStatsImpl>
    implements _$$JobStatsImplCopyWith<$Res> {
  __$$JobStatsImplCopyWithImpl(
      _$JobStatsImpl _value, $Res Function(_$JobStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationsThisMonth = null,
    Object? interviewsScheduled = null,
    Object? offersReceived = null,
    Object? applicationSuccessRate = null,
    Object? topSkills = null,
    Object? preferredJobTypes = null,
  }) {
    return _then(_$JobStatsImpl(
      applicationsThisMonth: null == applicationsThisMonth
          ? _value.applicationsThisMonth
          : applicationsThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      interviewsScheduled: null == interviewsScheduled
          ? _value.interviewsScheduled
          : interviewsScheduled // ignore: cast_nullable_to_non_nullable
              as int,
      offersReceived: null == offersReceived
          ? _value.offersReceived
          : offersReceived // ignore: cast_nullable_to_non_nullable
              as int,
      applicationSuccessRate: null == applicationSuccessRate
          ? _value.applicationSuccessRate
          : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
              as double,
      topSkills: null == topSkills
          ? _value._topSkills
          : topSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredJobTypes: null == preferredJobTypes
          ? _value._preferredJobTypes
          : preferredJobTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobStatsImpl implements _JobStats {
  const _$JobStatsImpl(
      {required this.applicationsThisMonth,
      required this.interviewsScheduled,
      required this.offersReceived,
      required this.applicationSuccessRate,
      required final List<String> topSkills,
      required final List<String> preferredJobTypes})
      : _topSkills = topSkills,
        _preferredJobTypes = preferredJobTypes;

  factory _$JobStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobStatsImplFromJson(json);

  @override
  final int applicationsThisMonth;
  @override
  final int interviewsScheduled;
  @override
  final int offersReceived;
  @override
  final double applicationSuccessRate;
  final List<String> _topSkills;
  @override
  List<String> get topSkills {
    if (_topSkills is EqualUnmodifiableListView) return _topSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topSkills);
  }

  final List<String> _preferredJobTypes;
  @override
  List<String> get preferredJobTypes {
    if (_preferredJobTypes is EqualUnmodifiableListView)
      return _preferredJobTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredJobTypes);
  }

  @override
  String toString() {
    return 'JobStats(applicationsThisMonth: $applicationsThisMonth, interviewsScheduled: $interviewsScheduled, offersReceived: $offersReceived, applicationSuccessRate: $applicationSuccessRate, topSkills: $topSkills, preferredJobTypes: $preferredJobTypes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobStatsImpl &&
            (identical(other.applicationsThisMonth, applicationsThisMonth) ||
                other.applicationsThisMonth == applicationsThisMonth) &&
            (identical(other.interviewsScheduled, interviewsScheduled) ||
                other.interviewsScheduled == interviewsScheduled) &&
            (identical(other.offersReceived, offersReceived) ||
                other.offersReceived == offersReceived) &&
            (identical(other.applicationSuccessRate, applicationSuccessRate) ||
                other.applicationSuccessRate == applicationSuccessRate) &&
            const DeepCollectionEquality()
                .equals(other._topSkills, _topSkills) &&
            const DeepCollectionEquality()
                .equals(other._preferredJobTypes, _preferredJobTypes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      applicationsThisMonth,
      interviewsScheduled,
      offersReceived,
      applicationSuccessRate,
      const DeepCollectionEquality().hash(_topSkills),
      const DeepCollectionEquality().hash(_preferredJobTypes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobStatsImplCopyWith<_$JobStatsImpl> get copyWith =>
      __$$JobStatsImplCopyWithImpl<_$JobStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobStatsImplToJson(
      this,
    );
  }
}

abstract class _JobStats implements JobStats {
  const factory _JobStats(
      {required final int applicationsThisMonth,
      required final int interviewsScheduled,
      required final int offersReceived,
      required final double applicationSuccessRate,
      required final List<String> topSkills,
      required final List<String> preferredJobTypes}) = _$JobStatsImpl;

  factory _JobStats.fromJson(Map<String, dynamic> json) =
      _$JobStatsImpl.fromJson;

  @override
  int get applicationsThisMonth;
  @override
  int get interviewsScheduled;
  @override
  int get offersReceived;
  @override
  double get applicationSuccessRate;
  @override
  List<String> get topSkills;
  @override
  List<String> get preferredJobTypes;
  @override
  @JsonKey(ignore: true)
  _$$JobStatsImplCopyWith<_$JobStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileStats _$ProfileStatsFromJson(Map<String, dynamic> json) {
  return _ProfileStats.fromJson(json);
}

/// @nodoc
mixin _$ProfileStats {
  int get profileCompletion => throw _privateConstructorUsedError;
  int get skillsCount => throw _privateConstructorUsedError;
  int get experienceCount => throw _privateConstructorUsedError;
  int get educationCount => throw _privateConstructorUsedError;
  int get languagesCount => throw _privateConstructorUsedError;
  int get cvCount => throw _privateConstructorUsedError;
  bool get hasProfilePhoto => throw _privateConstructorUsedError;
  bool get hasCoverPhoto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileStatsCopyWith<ProfileStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStatsCopyWith<$Res> {
  factory $ProfileStatsCopyWith(
          ProfileStats value, $Res Function(ProfileStats) then) =
      _$ProfileStatsCopyWithImpl<$Res, ProfileStats>;
  @useResult
  $Res call(
      {int profileCompletion,
      int skillsCount,
      int experienceCount,
      int educationCount,
      int languagesCount,
      int cvCount,
      bool hasProfilePhoto,
      bool hasCoverPhoto});
}

/// @nodoc
class _$ProfileStatsCopyWithImpl<$Res, $Val extends ProfileStats>
    implements $ProfileStatsCopyWith<$Res> {
  _$ProfileStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileCompletion = null,
    Object? skillsCount = null,
    Object? experienceCount = null,
    Object? educationCount = null,
    Object? languagesCount = null,
    Object? cvCount = null,
    Object? hasProfilePhoto = null,
    Object? hasCoverPhoto = null,
  }) {
    return _then(_value.copyWith(
      profileCompletion: null == profileCompletion
          ? _value.profileCompletion
          : profileCompletion // ignore: cast_nullable_to_non_nullable
              as int,
      skillsCount: null == skillsCount
          ? _value.skillsCount
          : skillsCount // ignore: cast_nullable_to_non_nullable
              as int,
      experienceCount: null == experienceCount
          ? _value.experienceCount
          : experienceCount // ignore: cast_nullable_to_non_nullable
              as int,
      educationCount: null == educationCount
          ? _value.educationCount
          : educationCount // ignore: cast_nullable_to_non_nullable
              as int,
      languagesCount: null == languagesCount
          ? _value.languagesCount
          : languagesCount // ignore: cast_nullable_to_non_nullable
              as int,
      cvCount: null == cvCount
          ? _value.cvCount
          : cvCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasProfilePhoto: null == hasProfilePhoto
          ? _value.hasProfilePhoto
          : hasProfilePhoto // ignore: cast_nullable_to_non_nullable
              as bool,
      hasCoverPhoto: null == hasCoverPhoto
          ? _value.hasCoverPhoto
          : hasCoverPhoto // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileStatsImplCopyWith<$Res>
    implements $ProfileStatsCopyWith<$Res> {
  factory _$$ProfileStatsImplCopyWith(
          _$ProfileStatsImpl value, $Res Function(_$ProfileStatsImpl) then) =
      __$$ProfileStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int profileCompletion,
      int skillsCount,
      int experienceCount,
      int educationCount,
      int languagesCount,
      int cvCount,
      bool hasProfilePhoto,
      bool hasCoverPhoto});
}

/// @nodoc
class __$$ProfileStatsImplCopyWithImpl<$Res>
    extends _$ProfileStatsCopyWithImpl<$Res, _$ProfileStatsImpl>
    implements _$$ProfileStatsImplCopyWith<$Res> {
  __$$ProfileStatsImplCopyWithImpl(
      _$ProfileStatsImpl _value, $Res Function(_$ProfileStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileCompletion = null,
    Object? skillsCount = null,
    Object? experienceCount = null,
    Object? educationCount = null,
    Object? languagesCount = null,
    Object? cvCount = null,
    Object? hasProfilePhoto = null,
    Object? hasCoverPhoto = null,
  }) {
    return _then(_$ProfileStatsImpl(
      profileCompletion: null == profileCompletion
          ? _value.profileCompletion
          : profileCompletion // ignore: cast_nullable_to_non_nullable
              as int,
      skillsCount: null == skillsCount
          ? _value.skillsCount
          : skillsCount // ignore: cast_nullable_to_non_nullable
              as int,
      experienceCount: null == experienceCount
          ? _value.experienceCount
          : experienceCount // ignore: cast_nullable_to_non_nullable
              as int,
      educationCount: null == educationCount
          ? _value.educationCount
          : educationCount // ignore: cast_nullable_to_non_nullable
              as int,
      languagesCount: null == languagesCount
          ? _value.languagesCount
          : languagesCount // ignore: cast_nullable_to_non_nullable
              as int,
      cvCount: null == cvCount
          ? _value.cvCount
          : cvCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasProfilePhoto: null == hasProfilePhoto
          ? _value.hasProfilePhoto
          : hasProfilePhoto // ignore: cast_nullable_to_non_nullable
              as bool,
      hasCoverPhoto: null == hasCoverPhoto
          ? _value.hasCoverPhoto
          : hasCoverPhoto // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileStatsImpl implements _ProfileStats {
  const _$ProfileStatsImpl(
      {required this.profileCompletion,
      required this.skillsCount,
      required this.experienceCount,
      required this.educationCount,
      required this.languagesCount,
      required this.cvCount,
      required this.hasProfilePhoto,
      required this.hasCoverPhoto});

  factory _$ProfileStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileStatsImplFromJson(json);

  @override
  final int profileCompletion;
  @override
  final int skillsCount;
  @override
  final int experienceCount;
  @override
  final int educationCount;
  @override
  final int languagesCount;
  @override
  final int cvCount;
  @override
  final bool hasProfilePhoto;
  @override
  final bool hasCoverPhoto;

  @override
  String toString() {
    return 'ProfileStats(profileCompletion: $profileCompletion, skillsCount: $skillsCount, experienceCount: $experienceCount, educationCount: $educationCount, languagesCount: $languagesCount, cvCount: $cvCount, hasProfilePhoto: $hasProfilePhoto, hasCoverPhoto: $hasCoverPhoto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStatsImpl &&
            (identical(other.profileCompletion, profileCompletion) ||
                other.profileCompletion == profileCompletion) &&
            (identical(other.skillsCount, skillsCount) ||
                other.skillsCount == skillsCount) &&
            (identical(other.experienceCount, experienceCount) ||
                other.experienceCount == experienceCount) &&
            (identical(other.educationCount, educationCount) ||
                other.educationCount == educationCount) &&
            (identical(other.languagesCount, languagesCount) ||
                other.languagesCount == languagesCount) &&
            (identical(other.cvCount, cvCount) || other.cvCount == cvCount) &&
            (identical(other.hasProfilePhoto, hasProfilePhoto) ||
                other.hasProfilePhoto == hasProfilePhoto) &&
            (identical(other.hasCoverPhoto, hasCoverPhoto) ||
                other.hasCoverPhoto == hasCoverPhoto));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      profileCompletion,
      skillsCount,
      experienceCount,
      educationCount,
      languagesCount,
      cvCount,
      hasProfilePhoto,
      hasCoverPhoto);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStatsImplCopyWith<_$ProfileStatsImpl> get copyWith =>
      __$$ProfileStatsImplCopyWithImpl<_$ProfileStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileStatsImplToJson(
      this,
    );
  }
}

abstract class _ProfileStats implements ProfileStats {
  const factory _ProfileStats(
      {required final int profileCompletion,
      required final int skillsCount,
      required final int experienceCount,
      required final int educationCount,
      required final int languagesCount,
      required final int cvCount,
      required final bool hasProfilePhoto,
      required final bool hasCoverPhoto}) = _$ProfileStatsImpl;

  factory _ProfileStats.fromJson(Map<String, dynamic> json) =
      _$ProfileStatsImpl.fromJson;

  @override
  int get profileCompletion;
  @override
  int get skillsCount;
  @override
  int get experienceCount;
  @override
  int get educationCount;
  @override
  int get languagesCount;
  @override
  int get cvCount;
  @override
  bool get hasProfilePhoto;
  @override
  bool get hasCoverPhoto;
  @override
  @JsonKey(ignore: true)
  _$$ProfileStatsImplCopyWith<_$ProfileStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentActivity _$RecentActivityFromJson(Map<String, dynamic> json) {
  return _RecentActivity.fromJson(json);
}

/// @nodoc
mixin _$RecentActivity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ActivityType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String? get actionUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentActivityCopyWith<RecentActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentActivityCopyWith<$Res> {
  factory $RecentActivityCopyWith(
          RecentActivity value, $Res Function(RecentActivity) then) =
      _$RecentActivityCopyWithImpl<$Res, RecentActivity>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      ActivityType type,
      DateTime timestamp,
      String icon,
      String? actionUrl});
}

/// @nodoc
class _$RecentActivityCopyWithImpl<$Res, $Val extends RecentActivity>
    implements $RecentActivityCopyWith<$Res> {
  _$RecentActivityCopyWithImpl(this._value, this._then);

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
    Object? type = null,
    Object? timestamp = null,
    Object? icon = null,
    Object? actionUrl = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentActivityImplCopyWith<$Res>
    implements $RecentActivityCopyWith<$Res> {
  factory _$$RecentActivityImplCopyWith(_$RecentActivityImpl value,
          $Res Function(_$RecentActivityImpl) then) =
      __$$RecentActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      ActivityType type,
      DateTime timestamp,
      String icon,
      String? actionUrl});
}

/// @nodoc
class __$$RecentActivityImplCopyWithImpl<$Res>
    extends _$RecentActivityCopyWithImpl<$Res, _$RecentActivityImpl>
    implements _$$RecentActivityImplCopyWith<$Res> {
  __$$RecentActivityImplCopyWithImpl(
      _$RecentActivityImpl _value, $Res Function(_$RecentActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? timestamp = null,
    Object? icon = null,
    Object? actionUrl = freezed,
  }) {
    return _then(_$RecentActivityImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentActivityImpl implements _RecentActivity {
  const _$RecentActivityImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.timestamp,
      required this.icon,
      this.actionUrl});

  factory _$RecentActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final ActivityType type;
  @override
  final DateTime timestamp;
  @override
  final String icon;
  @override
  final String? actionUrl;

  @override
  String toString() {
    return 'RecentActivity(id: $id, title: $title, description: $description, type: $type, timestamp: $timestamp, icon: $icon, actionUrl: $actionUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, type, timestamp, icon, actionUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentActivityImplCopyWith<_$RecentActivityImpl> get copyWith =>
      __$$RecentActivityImplCopyWithImpl<_$RecentActivityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentActivityImplToJson(
      this,
    );
  }
}

abstract class _RecentActivity implements RecentActivity {
  const factory _RecentActivity(
      {required final String id,
      required final String title,
      required final String description,
      required final ActivityType type,
      required final DateTime timestamp,
      required final String icon,
      final String? actionUrl}) = _$RecentActivityImpl;

  factory _RecentActivity.fromJson(Map<String, dynamic> json) =
      _$RecentActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  ActivityType get type;
  @override
  DateTime get timestamp;
  @override
  String get icon;
  @override
  String? get actionUrl;
  @override
  @JsonKey(ignore: true)
  _$$RecentActivityImplCopyWith<_$RecentActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;
  DateTime? get unlockedAt => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) then) =
      _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String icon,
      bool isUnlocked,
      DateTime? unlockedAt,
      int points});
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

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
    Object? icon = null,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
    Object? points = null,
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
          _$AchievementImpl value, $Res Function(_$AchievementImpl) then) =
      __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String icon,
      bool isUnlocked,
      DateTime? unlockedAt,
      int points});
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
      _$AchievementImpl _value, $Res Function(_$AchievementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? icon = null,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
    Object? points = null,
  }) {
    return _then(_$AchievementImpl(
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.icon,
      required this.isUnlocked,
      required this.unlockedAt,
      required this.points});

  factory _$AchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String icon;
  @override
  final bool isUnlocked;
  @override
  final DateTime? unlockedAt;
  @override
  final int points;

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, icon: $icon, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, icon,
      isUnlocked, unlockedAt, points);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementImplToJson(
      this,
    );
  }
}

abstract class _Achievement implements Achievement {
  const factory _Achievement(
      {required final String id,
      required final String title,
      required final String description,
      required final String icon,
      required final bool isUnlocked,
      required final DateTime? unlockedAt,
      required final int points}) = _$AchievementImpl;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$AchievementImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get icon;
  @override
  bool get isUnlocked;
  @override
  DateTime? get unlockedAt;
  @override
  int get points;
  @override
  @JsonKey(ignore: true)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JobRecommendation _$JobRecommendationFromJson(Map<String, dynamic> json) {
  return _JobRecommendation.fromJson(json);
}

/// @nodoc
mixin _$JobRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get salary => throw _privateConstructorUsedError;
  double get matchPercentage => throw _privateConstructorUsedError;
  List<String> get matchingSkills => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobRecommendationCopyWith<JobRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobRecommendationCopyWith<$Res> {
  factory $JobRecommendationCopyWith(
          JobRecommendation value, $Res Function(JobRecommendation) then) =
      _$JobRecommendationCopyWithImpl<$Res, JobRecommendation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String company,
      String location,
      String type,
      String salary,
      double matchPercentage,
      List<String> matchingSkills,
      String description});
}

/// @nodoc
class _$JobRecommendationCopyWithImpl<$Res, $Val extends JobRecommendation>
    implements $JobRecommendationCopyWith<$Res> {
  _$JobRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? company = null,
    Object? location = null,
    Object? type = null,
    Object? salary = null,
    Object? matchPercentage = null,
    Object? matchingSkills = null,
    Object? description = null,
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
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      salary: null == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as String,
      matchPercentage: null == matchPercentage
          ? _value.matchPercentage
          : matchPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      matchingSkills: null == matchingSkills
          ? _value.matchingSkills
          : matchingSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobRecommendationImplCopyWith<$Res>
    implements $JobRecommendationCopyWith<$Res> {
  factory _$$JobRecommendationImplCopyWith(_$JobRecommendationImpl value,
          $Res Function(_$JobRecommendationImpl) then) =
      __$$JobRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String company,
      String location,
      String type,
      String salary,
      double matchPercentage,
      List<String> matchingSkills,
      String description});
}

/// @nodoc
class __$$JobRecommendationImplCopyWithImpl<$Res>
    extends _$JobRecommendationCopyWithImpl<$Res, _$JobRecommendationImpl>
    implements _$$JobRecommendationImplCopyWith<$Res> {
  __$$JobRecommendationImplCopyWithImpl(_$JobRecommendationImpl _value,
      $Res Function(_$JobRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? company = null,
    Object? location = null,
    Object? type = null,
    Object? salary = null,
    Object? matchPercentage = null,
    Object? matchingSkills = null,
    Object? description = null,
  }) {
    return _then(_$JobRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      salary: null == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as String,
      matchPercentage: null == matchPercentage
          ? _value.matchPercentage
          : matchPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      matchingSkills: null == matchingSkills
          ? _value._matchingSkills
          : matchingSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobRecommendationImpl implements _JobRecommendation {
  const _$JobRecommendationImpl(
      {required this.id,
      required this.title,
      required this.company,
      required this.location,
      required this.type,
      required this.salary,
      required this.matchPercentage,
      required final List<String> matchingSkills,
      required this.description})
      : _matchingSkills = matchingSkills;

  factory _$JobRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String company;
  @override
  final String location;
  @override
  final String type;
  @override
  final String salary;
  @override
  final double matchPercentage;
  final List<String> _matchingSkills;
  @override
  List<String> get matchingSkills {
    if (_matchingSkills is EqualUnmodifiableListView) return _matchingSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchingSkills);
  }

  @override
  final String description;

  @override
  String toString() {
    return 'JobRecommendation(id: $id, title: $title, company: $company, location: $location, type: $type, salary: $salary, matchPercentage: $matchPercentage, matchingSkills: $matchingSkills, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.matchPercentage, matchPercentage) ||
                other.matchPercentage == matchPercentage) &&
            const DeepCollectionEquality()
                .equals(other._matchingSkills, _matchingSkills) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      company,
      location,
      type,
      salary,
      matchPercentage,
      const DeepCollectionEquality().hash(_matchingSkills),
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobRecommendationImplCopyWith<_$JobRecommendationImpl> get copyWith =>
      __$$JobRecommendationImplCopyWithImpl<_$JobRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobRecommendationImplToJson(
      this,
    );
  }
}

abstract class _JobRecommendation implements JobRecommendation {
  const factory _JobRecommendation(
      {required final String id,
      required final String title,
      required final String company,
      required final String location,
      required final String type,
      required final String salary,
      required final double matchPercentage,
      required final List<String> matchingSkills,
      required final String description}) = _$JobRecommendationImpl;

  factory _JobRecommendation.fromJson(Map<String, dynamic> json) =
      _$JobRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get company;
  @override
  String get location;
  @override
  String get type;
  @override
  String get salary;
  @override
  double get matchPercentage;
  @override
  List<String> get matchingSkills;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$JobRecommendationImplCopyWith<_$JobRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
