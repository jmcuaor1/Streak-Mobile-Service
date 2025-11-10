import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/application_model.dart';
import '../../data/services/api_service.dart';
import '../../core/providers.dart';

/// Estado de aplicaciones
class ApplicationsState {
  final List<ApplicationModel> applications;
  final bool isLoading;
  final String? error;

  ApplicationsState({
    required this.applications,
    required this.isLoading,
    this.error,
  });

  ApplicationsState copyWith({
    List<ApplicationModel>? applications,
    bool? isLoading,
    String? error,
  }) {
    return ApplicationsState(
      applications: applications ?? this.applications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory ApplicationsState.initial() {
    return ApplicationsState(
      applications: [],
      isLoading: false,
      error: null,
    );
  }
}

/// Notifier de aplicaciones
class ApplicationsNotifier extends Notifier<ApplicationsState> {
  late final ApiService _apiService;

  @override
  ApplicationsState build() {
    _apiService = ref.read(apiServiceProvider);
    return ApplicationsState.initial();
  }

  /// Obtener aplicaciones del freelancer
  Future<void> getApplications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.getApplications();
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        final applications = (response.data['data'] as List)
            .map((json) => ApplicationModel.fromJson(json))
            .toList();
        
        state = state.copyWith(
          applications: applications,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.data['message'] ?? 'Error al cargar aplicaciones',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión',
      );
    }
  }

  /// Obtener aplicaciones recibidas por el cliente
  Future<void> getClientApplications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.getClientApplications();
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        final applications = (response.data['data'] as List)
            .map((json) => ApplicationModel.fromJson(json))
            .toList();
        
        state = state.copyWith(
          applications: applications,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.data['message'] ?? 'Error al cargar aplicaciones',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión',
      );
    }
  }

  /// Actualizar estado de aplicación
  Future<void> updateApplicationStatus(String applicationId, String status) async {
    try {
      final response = await _apiService.updateApplicationStatus(applicationId, status);
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Actualizar la aplicación en la lista local
        final updatedApplications = state.applications.map((app) {
          if (app.id == applicationId) {
            return app.copyWith(
              status: status,
              reviewedAt: DateTime.now(),
            );
          }
          return app;
        }).toList();
        
        state = state.copyWith(applications: updatedApplications);
      }
    } catch (e) {
      // Manejar error
    }
  }

  /// Aplicar a un trabajo
  Future<bool> applyToJob({
    required String jobId,
    required String proposal,
    double? bidAmount,
  }) async {
    try {
      final response = await _apiService.applyToJob({
        'jobId': jobId,
        'proposal': proposal,
        if (bidAmount != null) 'bidAmount': bidAmount,
      });
      
      return response.statusCode == 201 && response.data['success'] == true;
    } catch (e) {
      return false;
    }
  }
}

/// Provider de aplicaciones
final applicationsProvider = NotifierProvider<ApplicationsNotifier, ApplicationsState>(
  ApplicationsNotifier.new,
);
