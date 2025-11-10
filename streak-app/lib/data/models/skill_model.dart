import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_model.freezed.dart';
part 'skill_model.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String name,
    required String category,
    required String level,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

class SkillCategory {
  static const String technical = 'technical';
  static const String soft = 'soft';
  static const String language = 'language';
  static const String certification = 'certification';
  static const String tool = 'tool';

  static String getDisplayName(String category) {
    switch (category) {
      case technical:
        return 'Técnica';
      case soft:
        return 'Blanda';
      case language:
        return 'Idioma';
      case certification:
        return 'Certificación';
      case tool:
        return 'Herramienta';
      default:
        return category;
    }
  }
}

class SkillLevel {
  static const String beginner = 'beginner';
  static const String intermediate = 'intermediate';
  static const String advanced = 'advanced';
  static const String expert = 'expert';

  static String getDisplayName(String level) {
    switch (level) {
      case beginner:
        return 'Principiante';
      case intermediate:
        return 'Intermedio';
      case advanced:
        return 'Avanzado';
      case expert:
        return 'Experto';
      default:
        return level;
    }
  }
}
