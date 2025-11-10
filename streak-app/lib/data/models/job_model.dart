import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

/// Modelo de Trabajo/Job - Sincronizado con el backend
@freezed
class JobModel with _$JobModel {
  const factory JobModel({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String description,
    required String category,
    String? subcategory,
    @JsonKey(name: 'clientId') ClientModel? clientId, // Cambiado de String a ClientModel?
    required String type, // 'fixed_price' | 'hourly'
    double? budget, // Para fixed_price
    HourlyRateModel? hourlyRate, // Para hourly
    @Default([]) @JsonKey(name: 'skillsRequired') List<String> skillsRequired,
    @Default('intermediate') String experienceLevel, // 'entry' | 'intermediate' | 'expert'
    String? estimatedDuration,
    @Default([]) List<String> attachments,
    required String status, // 'draft' | 'open' | 'in_progress' | 'completed' | 'cancelled'
    @Default(false) bool isUrgent,
    @JsonKey(name: 'assignedFreelancerId') String? assignedFreelancerId,
    required StatsModel stats,
    DateTime? deadline,
    DateTime? startDate,
    DateTime? completionDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    // Campos populados
    ClientModel? client,
    UserModel? assignedFreelancer,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
}

/// Modelo de Tarifa por Hora
@freezed
class HourlyRateModel with _$HourlyRateModel {
  const factory HourlyRateModel({
    required double min,
    required double max,
  }) = _HourlyRateModel;

  factory HourlyRateModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyRateModelFromJson(json);
}

/// Modelo de Estadísticas
@freezed
class StatsModel with _$StatsModel {
  const factory StatsModel({
    @Default(0) int views,
    @Default(0) int applicationsCount,
    @Default(0) int savedCount,
  }) = _StatsModel;

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);
}

/// Modelo de Cliente (simplificado)
@freezed
class ClientModel with _$ClientModel {
  const factory ClientModel({
    @JsonKey(name: '_id') required String id,
    required String email,
    required ProfileModel profile,
  }) = _ClientModel;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}

/// Modelo de Perfil
@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String firstName,
    required String lastName,
    String? avatar,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

/// Modelo de Usuario (simplificado)
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: '_id') required String id,
    required String email,
    required ProfileModel profile,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Extensión para facilitar el uso del modelo
extension JobModelX on JobModel {
  bool get isOpen => status == 'open';
  bool get isDraft => status == 'draft';
  bool get isInProgress => status == 'in_progress';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
  
  bool get isFixedPrice => type == 'fixed_price';
  bool get isHourly => type == 'hourly';
  
  bool get hasDeadline => deadline != null;
  bool get isDeadlinePassed => deadline != null && deadline!.isBefore(DateTime.now());
  
  String get salaryRange {
    if (isFixedPrice && budget != null) {
      return '\$${budget!.toStringAsFixed(0)} (Proyecto fijo)';
    } else if (isHourly && hourlyRate != null) {
      return '\$${hourlyRate!.min.toStringAsFixed(0)} - \$${hourlyRate!.max.toStringAsFixed(0)} / hora';
    }
    return 'No especificado';
  }
  
  String get clientName {
    if (client != null) {
      return '${client!.profile.firstName} ${client!.profile.lastName}';
    }
    return 'Cliente';
  }
  
  String get experienceLevelText {
    switch (experienceLevel) {
      case 'entry':
        return 'Principiante';
      case 'intermediate':
        return 'Intermedio';
      case 'expert':
        return 'Experto';
      default:
        return 'Intermedio';
    }
  }
}

