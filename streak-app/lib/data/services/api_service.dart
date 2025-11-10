import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../core/config/api_constants.dart';
import 'storage_service.dart';

/// Servicio de API con Dio
/// Maneja todas las peticiones HTTP al backend
class ApiService {
  final Dio _dio;
  final StorageService _storage;
  final Logger _logger = Logger();

  ApiService({
    required StorageService storage,
  })  : _storage = storage,
        _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: ApiConstants.connectTimeout,
            receiveTimeout: ApiConstants.receiveTimeout,
            sendTimeout: ApiConstants.sendTimeout,
            headers: ApiConstants.defaultHeaders,
          ),
        ) {
    _initializeInterceptors();
  }

  /// Getter para acceder al Dio instance
  Dio get dio => _dio;

  /// Inicializar interceptors
  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // REQUEST: Agregar token de autenticación
        onRequest: (options, handler) async {
          final accessToken = await _storage.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
            print('🔑 Usando token real: ${accessToken.substring(0, 20)}...');
          } else {
            print('⚠️ No hay token disponible');
          }

          _logger.d('📤 REQUEST: ${options.method} ${options.uri}');
          _logger.d('Headers: ${options.headers}');
          if (options.data != null) {
            _logger.d('Data: ${options.data}');
          }

          return handler.next(options);
        },

        // RESPONSE: Logging
        onResponse: (response, handler) {
          _logger.i('📥 RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
          _logger.i('Data: ${response.data}');
          return handler.next(response);
        },

        // ERROR: Manejo de errores y refresh token
        onError: (error, handler) async {
          _logger.e('❌ ERROR: ${error.response?.statusCode} ${error.requestOptions.uri}');
          _logger.e('Error: ${error.message}');
          _logger.e('Response: ${error.response?.data}');

          // Si el error es 401 (Unauthorized), intentar refresh token
          if (error.response?.statusCode == 401) {
            final refreshed = await _refreshToken();
            if (refreshed) {
              // Reintentar la petición original
              return handler.resolve(await _retry(error.requestOptions));
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  /// Refrescar access token usando el refresh token
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) return false;

      _logger.w('🔄 Refrescando access token...');

      final response = await _dio.post(
        ApiConstants.authRefresh,
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {
            'Authorization': null, // No enviar el token expirado
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final newAccessToken = data['accessToken'] as String;
        final newRefreshToken = data['refreshToken'] as String;

        await _storage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        _logger.i('✅ Access token refrescado exitosamente');
        return true;
      }

      return false;
    } catch (e) {
      _logger.e('❌ Error al refrescar token: $e');
      return false;
    }
  }

  /// Reintentar petición con el nuevo token
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accessToken = await _storage.getAccessToken();

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $accessToken',
      },
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  // ==================== AUTH ENDPOINTS ====================

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.authRegister, data: data);
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.authLogin, data: data);
  }

  Future<Response> logout(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.authLogout, data: data);
  }

  Future<Response> getMe() async {
    return await _dio.get(ApiConstants.authMe);
  }

  Future<Response> changePassword(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.authChangePassword, data: data);
  }

  Future<Response> forgotPassword(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.authForgotPassword, data: data);
  }

  Future<Response> resetPassword(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.authResetPassword, data: data);
  }

  // ==================== USER ENDPOINTS ====================

  Future<Response> getUsers({Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(ApiConstants.users, queryParameters: queryParameters);
  }

  Future<Response> getUserById(String id) async {
    return await _dio.get(ApiConstants.userById(id));
  }

  Future<Response> updateUser(String id, Map<String, dynamic> data) async {
    return await _dio.put(ApiConstants.userById(id), data: data);
  }

  Future<Response> deleteUser(String id) async {
    return await _dio.delete(ApiConstants.userById(id));
  }

  Future<Response> updateProfile(String id, Map<String, dynamic> data) async {
    return await _dio.put(ApiConstants.userProfile(id), data: data);
  }

  Future<Response> updateFreelancerProfile(String id, Map<String, dynamic> data) async {
    return await _dio.put(ApiConstants.userFreelancerProfile(id), data: data);
  }

  Future<Response> searchFreelancers({Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(
      ApiConstants.usersFreelancersSearch,
      queryParameters: queryParameters,
    );
  }

  // ==================== JOB ENDPOINTS ====================

  Future<Response> getJobs({Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(ApiConstants.jobs, queryParameters: queryParameters);
  }

  Future<Response> getRecommendedJobs() async {
    return await _dio.get(ApiConstants.jobsRecommended);
  }

  Future<Response> createJob(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.jobs, data: data);
  }

  Future<Response> getJobById(String id) async {
    return await _dio.get(ApiConstants.jobById(id));
  }

  Future<Response> updateJob(String id, Map<String, dynamic> data) async {
    return await _dio.put(ApiConstants.jobById(id), data: data);
  }

  Future<Response> deleteJob(String id) async {
    return await _dio.delete(ApiConstants.jobById(id));
  }

  Future<Response> publishJob(String id) async {
    return await _dio.post(ApiConstants.jobPublish(id));
  }

  Future<Response> saveJob(String id) async {
    return await _dio.post(ApiConstants.jobSave(id));
  }

  Future<Response> unsaveJob(String id) async {
    return await _dio.delete(ApiConstants.jobSave(id));
  }

  // ==================== APPLICATION ENDPOINTS ====================

  Future<Response> getApplications({Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(
      ApiConstants.applications,
      queryParameters: queryParameters,
    );
  }

  Future<Response> getClientApplications({Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(
      ApiConstants.clientApplications,
      queryParameters: queryParameters,
    );
  }

  Future<Response> applyToJob(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.applications, data: data);
  }

  Future<Response> updateApplicationStatus(String applicationId, String status) async {
    return await _dio.put(
      ApiConstants.applicationById(applicationId),
      data: {'status': status},
    );
  }

  Future<Response> getApplicationById(String id) async {
    return await _dio.get(ApiConstants.applicationById(id));
  }

  Future<Response> deleteApplication(String id) async {
    return await _dio.delete(ApiConstants.applicationById(id));
  }

  Future<Response> createApplication(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.applications, data: data);
  }

  Future<Response> acceptApplication(String id, Map<String, dynamic>? data) async {
    return await _dio.post(ApiConstants.applicationAccept(id), data: data);
  }

  Future<Response> rejectApplication(String id, Map<String, dynamic>? data) async {
    return await _dio.post(ApiConstants.applicationReject(id), data: data);
  }

  Future<Response> withdrawApplication(String id) async {
    return await _dio.post(ApiConstants.applicationWithdraw(id));
  }

  // ==================== GAMIFICATION ENDPOINTS ====================

  Future<Response> getGamificationStats() async {
    return await _dio.get(ApiConstants.gamificationStats);
  }

  Future<Response> getLeaderboard({Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(
      ApiConstants.gamificationLeaderboard,
      queryParameters: queryParameters,
    );
  }

  Future<Response> getAchievements() async {
    return await _dio.get(ApiConstants.gamificationAchievements);
  }
}

