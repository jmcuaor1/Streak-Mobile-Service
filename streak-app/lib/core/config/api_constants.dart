/// Constantes de configuración de la API
class ApiConstants {
  // ==================== URLs BASE ====================
  
static const String baseUrlDev = 'http://10.0.2.2:4000';
/// URL base del backend en producción
static const String baseUrlProd = 'https://api-streak.com'; // Cambiar cuando tengas dominio

/// URL base actual (cambia según el ambiente)
static String get baseUrl => _isDevelopment ? baseUrlDev : baseUrlProd;
static bool get _isDevelopment => true;
static bool get isDevelopment => _isDevelopment; // Getter público
  // ==================== ENDPOINTS ====================
  
  // Auth
  static const String authRegister = '/api/auth/register';
  static const String authLogin = '/api/auth/login';
  static const String authLogout = '/api/auth/logout';
  static const String authRefresh = '/api/auth/refresh';
  static const String authVerifyEmail = '/api/auth/verify-email';
  static const String authForgotPassword = '/api/auth/forgot-password';
  static const String authResetPassword = '/api/auth/reset-password';
  static const String authChangePassword = '/api/auth/change-password';
  static const String authMe = '/api/auth/me';
  
  // Users
  static const String users = '/api/users';
  static String userById(String id) => '/api/users/$id';
  static String userProfile(String id) => '/api/users/$id/profile';
  static String userFreelancerProfile(String id) => '/api/users/$id/freelancer-profile';
  static String userPreferences(String id) => '/api/users/$id/preferences';
  static const String usersFreelancersSearch = '/api/users/freelancers/search';
  
  // Jobs
  static const String jobs = '/api/jobs';
  static const String jobsRecommended = '/api/jobs/recommended';
  static String jobById(String id) => '/api/jobs/$id';
  static String jobPublish(String id) => '/api/jobs/$id/publish';
  static String jobAssign(String id) => '/api/jobs/$id/assign';
  static String jobComplete(String id) => '/api/jobs/$id/complete';
  static String jobCancel(String id) => '/api/jobs/$id/cancel';
  static String jobSave(String id) => '/api/jobs/$id/save';
  
  // Applications
  static const String applications = '/api/applications';
  static const String clientApplications = '/api/applications/client';
  static String applicationById(String id) => '/api/applications/$id';
  static String applicationAccept(String id) => '/api/applications/$id/accept';
  static String applicationReject(String id) => '/api/applications/$id/reject';
  static String applicationWithdraw(String id) => '/api/applications/$id/withdraw';
  
  // Gamification
  static const String gamificationStats = '/api/gamification/stats';
  static const String gamificationLeaderboard = '/api/gamification/leaderboard';
  static const String gamificationAchievements = '/api/gamification/achievements';
  
  // ==================== TIMEOUTS ====================
  
  /// Timeout para conexión (30 segundos)
  static const Duration connectTimeout = Duration(seconds: 30);
  
  /// Timeout para recibir respuesta (30 segundos)
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  /// Timeout para enviar datos (30 segundos)
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // ==================== HEADERS ====================
  
  /// Headers por defecto
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  
  // ==================== STORAGE KEYS ====================
  
  /// Key para el access token en secure storage
  static const String accessTokenKey = 'access_token';
  
  /// Key para el refresh token en secure storage
  static const String refreshTokenKey = 'refresh_token';
  
  /// Key para los datos del usuario en local storage
  static const String userDataKey = 'user_data';
  
  /// Key para las preferencias del usuario
  static const String userPreferencesKey = 'user_preferences';
}

