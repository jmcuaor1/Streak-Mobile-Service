import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/models/job_model.dart';
import '../../data/services/api_service.dart';
import '../../core/providers.dart';

/// Estado de gigs (freelance jobs)
class GigsState {
  final List<JobModel> gigs;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final int currentPage;

  GigsState({
    required this.gigs,
    required this.isLoading,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  GigsState copyWith({
    List<JobModel>? gigs,
    bool? isLoading,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return GigsState(
      gigs: gigs ?? this.gigs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  factory GigsState.initial() {
    return GigsState(
      gigs: [],
      isLoading: false,
      error: null,
      hasMore: true,
      currentPage: 1,
    );
  }

  factory GigsState.loading() {
    return GigsState(
      gigs: [],
      isLoading: true,
      error: null,
    );
  }
}

/// Notifier de gigs (freelance jobs)
class GigsNotifier extends Notifier<GigsState> {
  late final ApiService _apiService;

  @override
  GigsState build() {
    _apiService = ref.read(apiServiceProvider);
    return GigsState.initial();
  }

  /// Obtener lista de gigs (freelance jobs)
  Future<void> getGigs({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? experienceLevel,
    String? sort,
    bool refresh = false,
  }) async {
    if (refresh) {
      state = GigsState.loading();
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
          case 'budget_asc':
            sortBy = 'budget';
            sortOrder = 'asc';
            break;
          case 'budget_desc':
            sortBy = 'budget';
            sortOrder = 'desc';
            break;
        }
      }

      // Hacer dos llamadas separadas para fixed_price y hourly
      final List<JobModel> allJobs = [];
      
      // Llamada para fixed_price
      final fixedPriceParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
        if (category != null && category.isNotEmpty) 'category': category,
        if (experienceLevel != null && experienceLevel.isNotEmpty) 'experienceLevel': experienceLevel,
        if (sortBy != null) 'sortBy': sortBy,
        if (sortOrder != null) 'sortOrder': sortOrder,
        'type': 'fixed_price',
      };

      final fixedPriceResponse = await _apiService.getJobs(queryParameters: fixedPriceParams);
      
      if (fixedPriceResponse.statusCode == 200 && fixedPriceResponse.data['success'] == true) {
        final fixedPriceData = fixedPriceResponse.data['data'] as List;
        allJobs.addAll(fixedPriceData.map((json) => JobModel.fromJson(json)));
      }

      // Llamada para hourly
      final hourlyParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
        if (category != null && category.isNotEmpty) 'category': category,
        if (experienceLevel != null && experienceLevel.isNotEmpty) 'experienceLevel': experienceLevel,
        if (sortBy != null) 'sortBy': sortBy,
        if (sortOrder != null) 'sortOrder': sortOrder,
        'type': 'hourly',
      };

      final hourlyResponse = await _apiService.getJobs(queryParameters: hourlyParams);
      
      if (hourlyResponse.statusCode == 200 && hourlyResponse.data['success'] == true) {
        final hourlyData = hourlyResponse.data['data'] as List;
        allJobs.addAll(hourlyData.map((json) => JobModel.fromJson(json)));
      }

      // Combinar y ordenar resultados
      final jobs = allJobs;

      // Simular paginación combinada (simplificado)
      final hasMore = jobs.length >= limit;

      if (refresh || page == 1) {
        state = GigsState(
          gigs: jobs,
          isLoading: false,
          hasMore: hasMore,
          currentPage: page,
        );
      } else {
        state = GigsState(
          gigs: [...state.gigs, ...jobs],
          isLoading: false,
          hasMore: hasMore,
          currentPage: page,
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

  /// Cargar más gigs (paginación)
  Future<void> loadMore({
    String? search,
    String? category,
    String? experienceLevel,
    String? sort,
  }) async {
    if (!state.hasMore || state.isLoading) return;

    await getGigs(
      page: state.currentPage + 1,
      search: search,
      category: category,
      experienceLevel: experienceLevel,
      sort: sort,
    );
  }

  /// Refrescar lista
  Future<void> refresh({
    String? search,
    String? category,
    String? experienceLevel,
    String? sort,
  }) async {
    await getGigs(
      page: 1,
      search: search,
      category: category,
      experienceLevel: experienceLevel,
      sort: sort,
      refresh: true,
    );
  }

  /// Buscar gigs
  Future<void> searchGigs(String query) async {
    await getGigs(page: 1, search: query, refresh: true);
  }

  /// Filtrar gigs
  Future<void> filterGigs({
    String? category,
    String? experienceLevel,
  }) async {
    await getGigs(
      page: 1,
      category: category,
      experienceLevel: experienceLevel,
      refresh: true,
    );
  }

  /// Limpiar error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider del estado de gigs
final gigsProvider = NotifierProvider<GigsNotifier, GigsState>(GigsNotifier.new);

/// Provider para un gig específico por ID
final gigByIdProvider = FutureProvider.family<JobModel?, String>((ref, id) async {
  final apiService = ref.read(apiServiceProvider);
  
  try {
    final response = await apiService.getJobById(id);
    
    if (response.statusCode == 200 && response.data['success'] == true) {
      return JobModel.fromJson(response.data['data']);
    }
    return null;
  } catch (e) {
    return null;
  }
});

/// Notifier para gigs guardados
class SavedGigsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void add(String gigId) {
    state = {...state, gigId};
  }

  void remove(String gigId) {
    state = {...state}..remove(gigId);
  }
}

/// Notifier para gigs aplicados
class AppliedGigsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void add(String gigId) {
    state = {...state, gigId};
  }

  void remove(String gigId) {
    state = {...state}..remove(gigId);
  }
}

/// Provider para gigs guardados (IDs)
final savedGigsProvider = NotifierProvider<SavedGigsNotifier, Set<String>>(
  SavedGigsNotifier.new,
);

/// Provider para gigs aplicados (IDs)
final appliedGigsProvider = NotifierProvider<AppliedGigsNotifier, Set<String>>(
  AppliedGigsNotifier.new,
);
