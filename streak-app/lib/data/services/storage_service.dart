import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/config/api_constants.dart';
import '../models/user_model.dart';

/// Servicio de almacenamiento local
/// - FlutterSecureStorage para tokens (seguro)
/// - SharedPreferences para datos no sensibles
class StorageService {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  StorageService({
    required FlutterSecureStorage secureStorage,
    required SharedPreferences prefs,
  })  : _secureStorage = secureStorage,
        _prefs = prefs;

  // ==================== TOKENS (Secure Storage) ====================

  /// Guardar access token
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(
      key: ApiConstants.accessTokenKey,
      value: token,
    );
  }

  /// Obtener access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: ApiConstants.accessTokenKey);
  }

  /// Guardar refresh token
  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(
      key: ApiConstants.refreshTokenKey,
      value: token,
    );
  }

  /// Obtener refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: ApiConstants.refreshTokenKey);
  }

  /// Guardar ambos tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  /// Eliminar todos los tokens
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: ApiConstants.accessTokenKey),
      _secureStorage.delete(key: ApiConstants.refreshTokenKey),
    ]);
  }

  /// Verificar si hay tokens guardados
  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  // ==================== USER DATA (SharedPreferences) ====================

  /// Guardar datos del usuario
  Future<void> saveUserData(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(ApiConstants.userDataKey, userJson);
  }

  /// Obtener datos del usuario
  Future<UserModel?> getUserData() async {
    final userJson = _prefs.getString(ApiConstants.userDataKey);
    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      // Si hay error al parsear, eliminar datos corruptos
      await clearUserData();
      return null;
    }
  }

  /// Eliminar datos del usuario
  Future<void> clearUserData() async {
    await _prefs.remove(ApiConstants.userDataKey);
  }

  // ==================== PREFERENCES ====================

  /// Guardar preferencias del usuario
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    final prefJson = jsonEncode(preferences);
    await _prefs.setString(ApiConstants.userPreferencesKey, prefJson);
  }

  /// Obtener preferencias del usuario
  Future<Map<String, dynamic>?> getPreferences() async {
    final prefJson = _prefs.getString(ApiConstants.userPreferencesKey);
    if (prefJson == null) return null;

    try {
      return jsonDecode(prefJson) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // ==================== THEME ====================

  /// Guardar tema (dark/light)
  Future<void> saveTheme(String theme) async {
    await _prefs.setString('app_theme', theme);
  }

  /// Obtener tema
  String getTheme() {
    return _prefs.getString('app_theme') ?? 'light';
  }

  // ==================== LANGUAGE ====================

  /// Guardar idioma
  Future<void> saveLanguage(String language) async {
    await _prefs.setString('app_language', language);
  }

  /// Obtener idioma
  String getLanguage() {
    return _prefs.getString('app_language') ?? 'es';
  }

  // ==================== FIRST RUN ====================

  /// Verificar si es la primera vez que se abre la app
  bool isFirstRun() {
    return _prefs.getBool('first_run') ?? true;
  }

  /// Marcar que ya no es la primera vez
  Future<void> setFirstRunComplete() async {
    await _prefs.setBool('first_run', false);
  }

  // ==================== ONBOARDING ====================

  /// Verificar si ya se completó el onboarding
  bool hasCompletedOnboarding() {
    return _prefs.getBool('onboarding_completed') ?? false;
  }

  /// Marcar onboarding como completado
  Future<void> setOnboardingComplete() async {
    await _prefs.setBool('onboarding_completed', true);
  }

  // ==================== CLEAR ALL ====================

  /// Limpiar TODOS los datos (logout completo)
  Future<void> clearAll() async {
    await Future.wait([
      clearTokens(),
      clearUserData(),
      _prefs.clear(),
    ]);
  }

  /// Limpiar solo datos de sesión (mantener preferencias)
  Future<void> clearSessionData() async {
    await Future.wait([
      clearTokens(),
      clearUserData(),
    ]);
  }
}

