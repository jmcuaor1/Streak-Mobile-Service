import 'package:dio/dio.dart';
import '../../core/config/api_constants.dart';

/// Servicio para manejar trabajos guardados
class SavedJobsService {
  final Dio _dio;

  SavedJobsService(this._dio);

  /// Guardar trabajo
  Future<Response> saveJob(String jobId) async {
    return await _dio.post(ApiConstants.jobSave(jobId));
  }

  /// Quitar trabajo de guardados
  Future<Response> unsaveJob(String jobId) async {
    return await _dio.delete(ApiConstants.jobSave(jobId));
  }

  /// Verificar si un trabajo está guardado
  Future<bool> isJobSaved(String jobId) async {
    try {
      // Por ahora retornamos false, ya que no hay endpoint específico
      // En el futuro se podría implementar un endpoint para obtener trabajos guardados
      return false;
    } catch (e) {
      return false;
    }
  }
}
