import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

/// Modelo de Aplicación
@freezed
class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    @JsonKey(name: '_id') required String id,
    required String jobId,
    required String freelancerId,
    required String freelancerName,
    required String jobTitle,
    required String proposal,
    double? bidAmount,
    required String status, // 'pending', 'accepted', 'rejected'
    required DateTime appliedAt,
    DateTime? reviewedAt,
    String? clientNotes,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModelFromJson(json);
}

/// Extensión para ApplicationModel
extension ApplicationModelX on ApplicationModel {
  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';
  bool get isRejected => status == 'rejected';
  
  String get statusText {
    switch (status) {
      case 'accepted':
        return 'Aceptada';
      case 'rejected':
        return 'Rechazada';
      case 'pending':
      default:
        return 'Pendiente';
    }
  }
}
