import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/saved_jobs_service.dart';
import '../../core/providers.dart';

/// Notifier para manejar trabajos guardados
class SavedJobsNotifier extends Notifier<Set<String>> {
  late final SavedJobsService _savedJobsService;

  @override
  Set<String> build() {
    final apiService = ref.read(apiServiceProvider);
    _savedJobsService = SavedJobsService(apiService.dio);
    return <String>{};
  }

  /// Guardar trabajo
  Future<bool> saveJob(String jobId) async {
    try {
      final response = await _savedJobsService.saveJob(jobId);

      if (response.statusCode == 200 && response.data['success'] == true) {
        state = {...state, jobId};
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Quitar trabajo de guardados
  Future<bool> unsaveJob(String jobId) async {
    try {
      final response = await _savedJobsService.unsaveJob(jobId);

      if (response.statusCode == 200 && response.data['success'] == true) {
        state = {...state}..remove(jobId);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Alternar estado de guardado
  Future<bool> toggleSaved(String jobId) async {
    if (state.contains(jobId)) {
      return await unsaveJob(jobId);
    } else {
      return await saveJob(jobId);
    }
  }

  /// Verificar si un trabajo está guardado
  bool isJobSaved(String jobId) {
    return state.contains(jobId);
  }

  /// Agregar trabajo a la lista local (sin llamada al backend)
  void add(String jobId) {
    state = {...state, jobId};
  }

  /// Remover trabajo de la lista local (sin llamada al backend)
  void remove(String jobId) {
    state = {...state}..remove(jobId);
  }
}

/// Provider para trabajos guardados
final savedJobsProvider =
    NotifierProvider<SavedJobsNotifier, Set<String>>(SavedJobsNotifier.new);

/// Provider para verificar si un trabajo específico está guardado
final isJobSavedProvider = Provider.family<bool, String>((ref, jobId) {
  final savedJobs = ref.watch(savedJobsProvider);
  return savedJobs.contains(jobId);
});
