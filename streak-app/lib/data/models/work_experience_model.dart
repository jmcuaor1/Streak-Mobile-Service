import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_experience_model.freezed.dart';
part 'work_experience_model.g.dart';

@freezed
class WorkExperience with _$WorkExperience {
  const factory WorkExperience({
    required String id,
    required String companyName,
    required String position,
    required String description,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    String? location,
    String? companyWebsite,
    List<String>? achievements,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);
}
