import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_model.freezed.dart';
part 'education_model.g.dart';

@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    required String institutionName,
    required String fieldOfStudy,
    required String level,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    String? location,
    String? description,
    double? gpa,
    List<String>? achievements,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);
}

class EducationLevel {
  static const String highSchool = 'high_school';
  static const String associate = 'associate';
  static const String bachelor = 'bachelor';
  static const String master = 'master';
  static const String phd = 'phd';
  static const String certificate = 'certificate';
  static const String diploma = 'diploma';

  static String getDisplayName(String level) {
    switch (level) {
      case highSchool:
        return 'Bachillerato';
      case associate:
        return 'Técnico';
      case bachelor:
        return 'Licenciatura';
      case master:
        return 'Maestría';
      case phd:
        return 'Doctorado';
      case certificate:
        return 'Certificado';
      case diploma:
        return 'Diploma';
      default:
        return level;
    }
  }
}
