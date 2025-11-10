import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/models/job_model.dart';
import '../../data/services/api_service.dart';
import '../../core/providers.dart';

/// Estado de trabajos
class JobState {
  final List<JobModel> jobs;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final int currentPage;

  JobState({
    required this.jobs,
    required this.isLoading,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  JobState copyWith({
    List<JobModel>? jobs,
    bool? isLoading,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return JobState(
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  factory JobState.initial() {
    return JobState(
      jobs: [],
      isLoading: false,
      error: null,
      hasMore: true,
      currentPage: 1,
    );
  }

  factory JobState.loading() {
    return JobState(
      jobs: [],
      isLoading: true,
      error: null,
    );
  }
}

/// Notifier de trabajos
class JobNotifier extends Notifier<JobState> {
  late final ApiService _apiService;

  @override
  JobState build() {
    _apiService = ref.read(apiServiceProvider);
    return JobState.initial();
  }

  /// Obtener lista de trabajos
  Future<void> getJobs({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? locationType,
    String? jobType,
    String? experienceLevel,
    String? sort,
    bool refresh = false,
  }) async {
    if (refresh) {
      state = JobState.loading();
    } else if (state.isLoading) {
      return; // Evitar múltiples peticiones simultáneas
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      // Mapear parámetros del frontend a los del backend
      String? sortBy;
      String? sortOrder;
      
      if (sort != null) {
        switch (sort) {
          case 'recent':
            sortBy = 'createdAt';
            sortOrder = 'desc';
            break;
          case 'salary_asc':
            sortBy = 'budget';
            sortOrder = 'asc';
            break;
          case 'salary_desc':
            sortBy = 'budget';
            sortOrder = 'desc';
            break;
        }
      }

      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
        if (category != null && category.isNotEmpty) 'category': category,
        if (experienceLevel != null && experienceLevel.isNotEmpty) 'experienceLevel': experienceLevel,
        if (sortBy != null) 'sortBy': sortBy,
        if (sortOrder != null) 'sortOrder': sortOrder,
        // El backend usa 'type' en lugar de 'jobType'
        if (jobType != null && jobType.isNotEmpty) 'type': jobType,
        // El backend no tiene locationType, pero podemos usar skills o search
        // if (locationType != null && locationType.isNotEmpty) 'locationType': locationType,
      };

      final response = await _apiService.getJobs(queryParameters: queryParams);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final jobsData = response.data['data'] as List;
        
        print('🔍 JobProvider: Procesando ${jobsData.length} trabajos...');
        
        try {
          final jobs = jobsData.map((json) {
            print('🔍 JobProvider: Procesando trabajo: ${json['title']}');
            return JobModel.fromJson(json);
          }).toList();

          final pagination = response.data['pagination'];
          final hasMore = pagination['hasNext'] as bool? ?? false;

          print('✅ JobProvider: ${jobs.length} trabajos procesados exitosamente');

          if (refresh || page == 1) {
            state = JobState(
              jobs: jobs,
              isLoading: false,
              hasMore: hasMore,
              currentPage: page,
            );
          } else {
            state = JobState(
              jobs: [...state.jobs, ...jobs],
              isLoading: false,
              hasMore: hasMore,
              currentPage: page,
            );
          }
        } catch (e) {
          print('❌ JobProvider: Error procesando trabajos: $e');
          state = state.copyWith(
            isLoading: false,
            error: 'Error procesando datos: ${e.toString()}',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.data['message'] ?? 'Error al cargar trabajos',
        );
      }
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? 'Error de conexión',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error inesperado',
      );
    }
  }

  /// Obtener trabajos del cliente actual
  Future<void> getClientJobs() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.getJobs(queryParameters: {'client': 'me'});
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        final jobsData = response.data['data'] as List;
        final jobs = jobsData.map((json) => JobModel.fromJson(json)).toList();
        
        state = state.copyWith(
          jobs: jobs,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.data['message'] ?? 'Error al cargar trabajos',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión',
      );
    }
  }

  /// Cargar más trabajos (paginación)
  Future<void> loadMore({
    String? search,
    String? category,
    String? locationType,
    String? jobType,
    String? experienceLevel,
    String? sort,
  }) async {
    if (!state.hasMore || state.isLoading) return;

    await getJobs(
      page: state.currentPage + 1,
      search: search,
      category: category,
      locationType: locationType,
      jobType: jobType,
      experienceLevel: experienceLevel,
      sort: sort,
    );
  }

  /// Refrescar lista
  Future<void> refresh({
    String? search,
    String? category,
    String? locationType,
    String? jobType,
    String? experienceLevel,
    String? sort,
  }) async {
    await getJobs(
      page: 1,
      search: search,
      category: category,
      locationType: locationType,
      jobType: jobType,
      experienceLevel: experienceLevel,
      sort: sort,
      refresh: true,
    );
  }

  /// Buscar trabajos
  Future<void> searchJobs(String query) async {
    await getJobs(page: 1, search: query, refresh: true);
  }

  /// Filtrar trabajos
  Future<void> filterJobs({
    String? category,
    String? locationType,
    String? jobType,
  }) async {
    await getJobs(
      page: 1,
      category: category,
      locationType: locationType,
      jobType: jobType,
      refresh: true,
    );
  }

  /// Limpiar error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Crear nuevo trabajo
  Future<bool> createJob(Map<String, dynamic> jobData) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final response = await _apiService.createJob(jobData);
      
      if (response.statusCode == 201 && response.data['success'] == true) {
        // Recargar la lista de trabajos
        await getJobs(page: 1, refresh: true);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.data['message'] ?? 'Error al crear el trabajo',
        );
        return false;
      }
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? 'Error de conexión',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error inesperado: ${e.toString()}',
      );
      return false;
    }
  }
}

/// Provider del estado de trabajos
final jobProvider = NotifierProvider<JobNotifier, JobState>(JobNotifier.new);

/// Provider para un trabajo específico por ID
final jobByIdProvider = FutureProvider.family<JobModel?, String>((ref, id) async {
  print('🎯 jobByIdProvider: Obteniendo trabajo con ID: $id');
  final apiService = ref.read(apiServiceProvider);
  
  try {
    final response = await apiService.getJobById(id);
    print('🎯 jobByIdProvider: Respuesta recibida: ${response.statusCode}');
    
    if (response.statusCode == 200 && response.data['success'] == true) {
      print('🎯 jobByIdProvider: Trabajo encontrado exitosamente');
      return JobModel.fromJson(response.data['data']);
    }
    print('🎯 jobByIdProvider: Trabajo no encontrado en respuesta');
    return null;
  } on DioException catch (e) {
    // Manejar específicamente errores 400 (ID inválido)
    if (e.response?.statusCode == 400) {
      print('⚠️ Job ID inválido: $id - ${e.response?.data['message']}');
      return null;
    }
    // Para otros errores de Dio, también retornar null
    print('❌ Error obteniendo trabajo $id: ${e.message}');
    return null;
  } catch (e) {
    print('❌ Error inesperado obteniendo trabajo $id: $e');
    return null;
  }
});


