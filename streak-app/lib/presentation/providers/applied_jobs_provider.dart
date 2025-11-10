import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/api_service.dart';
import '../../core/providers.dart';

/// Notifier para manejar trabajos aplicados
class AppliedJobsNotifier extends Notifier<Set<String>> {
  late final ApiService _apiService;

  @override
  Set<String> build() {
    _apiService = ref.read(apiServiceProvider);
    return <String>{};
  }

  /// Aplicar a trabajo
  Future<bool> applyToJob(String jobId) async {
    try {
      // Por ahora solo agregamos a la lista local
      // En el futuro se podría implementar la aplicación real
      state = {...state, jobId};
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Retirar aplicación
  Future<bool> withdrawApplication(String jobId) async {
    try {
      // Por ahora solo removemos de la lista local
      state = {...state}..remove(jobId);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Alternar estado de aplicación
  Future<bool> toggleApplied(String jobId) async {
    if (state.contains(jobId)) {
      return await withdrawApplication(jobId);
    } else {
      return await applyToJob(jobId);
    }
  }

  /// Verificar si ya aplicó a un trabajo
  bool hasAppliedToJob(String jobId) {
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

/// Provider para trabajos aplicados
final appliedJobsProvider =
    NotifierProvider<AppliedJobsNotifier, Set<String>>(AppliedJobsNotifier.new);

/// Provider para verificar si ya aplicó a un trabajo específico
final hasAppliedToJobProvider = Provider.family<bool, String>((ref, jobId) {
  final appliedJobs = ref.watch(appliedJobsProvider);
  return appliedJobs.contains(jobId);
});
