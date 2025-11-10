import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import '../../data/models/user_model.dart';
import '../../data/models/auth_models.dart';
import '../../data/services/api_service.dart';
import '../../data/services/storage_service.dart';
import '../../core/providers.dart';
import '../../core/config/dev_credentials.dart';
import '../../core/config/dev_flags.dart';

/// Estado de autenticación
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final UserModel? user;
  final String? error;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  factory AuthState.initial() {
    return AuthState(
      isAuthenticated: false,
      isLoading: false,
      user: null,
      error: null,
    );
  }

  factory AuthState.authenticated(UserModel user) {
    return AuthState(
      isAuthenticated: true,
      isLoading: false,
      user: user,
      error: null,
    );
  }

  factory AuthState.unauthenticated({String? error}) {
    return AuthState(
      isAuthenticated: false,
      isLoading: false,
      user: null,
      error: error,
    );
  }

  factory AuthState.loading() {
    return AuthState(
      isAuthenticated: false,
      isLoading: true,
      user: null,
      error: null,
    );
  }
}

/// Notifier de autenticación
class AuthNotifier extends Notifier<AuthState> {
  late final ApiService _apiService;
  late final StorageService _storageService;

  @override
  AuthState build() {
    _apiService = ref.read(apiServiceProvider);
    _storageService = ref.read(storageServiceProvider);
    
    // Si bypassAuth está activo, hacer login automático
    if (DevFlags.bypassAuth) {
      // Hacer login automático en el siguiente frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _autoLogin();
      });
    }
    
    return AuthState.initial();
  }

  /// Login automático para desarrollo
  Future<void> _autoLogin() async {
    // Para la presentación, usar directamente el usuario mock
    print('🎯 Usando usuario mock para presentación');
    
    // Crear usuario mock
    final mockUser = _createMockUser();
    
    // Establecer estado como autenticado
    state = AuthState.authenticated(mockUser);
    
    print('✅ Estado actualizado: isAuthenticated=${state.isAuthenticated}, isLoading=${state.isLoading}');
    
    // Opcional: Intentar login real en segundo plano (sin bloquear)
    _tryRealLoginInBackground();
  }
  
  /// Intentar login real en segundo plano (no bloquea la UI)
  void _tryRealLoginInBackground() async {
    // Si el backend está deshabilitado, no hacer peticiones
    if (DevFlags.disableBackend) {
      print('🎯 Backend deshabilitado - saltando login real');
      return;
    }
    
    try {
      final success = await login(
        email: DevCredentials.presentationEmail,
        password: DevCredentials.presentationPassword,
      );
      
      if (success) {
        print('✅ Login real exitoso');
        return;
      }
      
      // Intentar registro
      final registered = await register(
        email: DevCredentials.presentationEmail,
        password: DevCredentials.presentationPassword,
        confirmPassword: DevCredentials.presentationPassword,
        firstName: DevCredentials.presentationFirstName,
        lastName: DevCredentials.presentationLastName,
        role: DevCredentials.presentationRole,
      );
      
      if (registered) {
        print('✅ Registro real exitoso');
      }
      
    } catch (e) {
      print('⚠️ Login real falló: $e');
    }
  }

  /// Crear usuario mock para desarrollo cuando bypassAuth está activo
  UserModel _createMockUser() {
    print('🎯 Creando usuario mock...');
    print('📧 Email: ${DevCredentials.presentationEmail}');
    print('👤 Rol: ${DevCredentials.presentationRole}');
    print('👤 Nombre: ${DevCredentials.presentationFirstName} ${DevCredentials.presentationLastName}');
    
    final user = UserModel(
      id: 'dev-user-123',
      email: DevCredentials.presentationEmail,
      role: DevCredentials.presentationRole, // Usar rol de presentación
      accountStatus: 'active',
      profile: ProfileModel(
        firstName: DevCredentials.presentationFirstName,
        lastName: DevCredentials.presentationLastName,
        avatar: null,
        bio: 'Desarrollador en desarrollo 🚀',
        phone: '+57 300 123 4567',
      ),
      gamification: GamificationModel(
        totalPoints: 1250,
        level: 5,
        currentStreak: 7,
        lastActivityDate: DateTime.now(),
        achievements: ['first_job', 'week_streak'],
      ),
      preferences: PreferencesModel(
        theme: 'light',
        language: 'es',
        currency: 'USD',
        notifications: NotificationsModel(
          email: true,
          push: true,
          sms: false,
        ),
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
    
    print('✅ Usuario mock creado exitosamente');
    print('🔍 isClient: ${user.isClient}');
    print('🔍 isFreelancer: ${user.isFreelancer}');
    
    return user;
  }

  /// Inicializar - verificar si hay sesión guardada
  Future<void> initialize() async {
    // Si bypassAuth está activo, usar directamente el usuario mock
    if (DevFlags.bypassAuth) {
      print('🎯 BypassAuth activo - usando usuario mock');
      final mockUser = _createMockUser();
      state = AuthState.authenticated(mockUser);
      return;
    }
    
    // Si el backend está deshabilitado, usar usuario mock
    if (DevFlags.disableBackend) {
      print('🎯 Backend deshabilitado - usando usuario mock');
      final mockUser = _createMockUser();
      state = AuthState.authenticated(mockUser);
      return;
    }
    
    // Si useMockAuth está activo pero el backend está habilitado, mostrar login
    if (DevFlags.useMockAuth && !DevFlags.disableBackend) {
      print('🎯 Modo híbrido: Backend habilitado + Auth mock - mostrando login');
      state = AuthState.unauthenticated();
      return;
    }
    
    // Modo presentación real
    if (DevFlags.presentationMode) {
      print('🎯 Modo presentación REAL: Intentando login automático...');
      await _initializeForRealPresentation();
      return;
    }

    state = AuthState.loading();

    try {
      // Verificar si hay tokens guardados
      final hasTokens = await _storageService.hasTokens();
      
      if (!hasTokens) {
        // Auto-login de desarrollo: intentar login y si falla, registrar
        try {
          final logged = await login(
            email: DevCredentials.presentationEmail,
            password: DevCredentials.presentationPassword,
          );
          if (logged) return;

          final registered = await register(
            email: DevCredentials.presentationEmail,
            password: DevCredentials.presentationPassword,
            confirmPassword: DevCredentials.presentationPassword,
            firstName: DevCredentials.presentationFirstName,
            lastName: DevCredentials.presentationLastName,
            role: DevCredentials.presentationRole,
          );
          if (registered) return;
        } catch (_) {}
        state = AuthState.unauthenticated();
        return;
      }

      // Obtener usuario actual del backend
      final response = await _apiService.getMe();

      if (response.statusCode == 200 && response.data['success'] == true) {
        final user = UserModel.fromJson(response.data['data']);
        state = AuthState.authenticated(user);
      } else {
        // Token inválido, limpiar
        await _storageService.clearTokens();
        state = AuthState.unauthenticated();
      }
    } catch (e) {
      // Error al verificar sesión, limpiar
      await _storageService.clearTokens();
      state = AuthState.unauthenticated();
    }
  }

  /// Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Si useMockAuth está activo, simular login exitoso con usuario mock
    if (DevFlags.useMockAuth) {
      print('🎯 Usando autenticación mock para login');
      final mockUser = _createMockUser();
      state = AuthState.authenticated(mockUser);
      return true;
    }

    // Si el backend está deshabilitado, usar usuario mock
    if (DevFlags.disableBackend) {
      print('🎯 Backend deshabilitado - usando usuario mock para login');
      final mockUser = _createMockUser();
      state = AuthState.authenticated(mockUser);
      return true;
    }

    state = AuthState.loading();

    try {
      final response = await _apiService.login({
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.data['success'] == true) {
        final authData = AuthDataModel.fromJson(response.data['data']);

        // Guardar tokens
        await _storageService.saveTokens(
          accessToken: authData.tokens.accessToken,
          refreshToken: authData.tokens.refreshToken,
        );

        // Guardar usuario
        await _storageService.saveUserData(authData.user);

        // Actualizar estado
        state = AuthState.authenticated(authData.user);
        return true;
      } else {
        // Login falló, volver a estado no autenticado
        print('⚠️ Login falló: ${response.data['message'] ?? 'Error al iniciar sesión'}');
        state = AuthState.unauthenticated();
        return false;
      }
    } on DioException catch (e) {
      // Error de conexión, volver a estado no autenticado
      final errorMessage = e.response?.data['message'] ?? 'Error de conexión';
      print('⚠️ Error de login: $errorMessage');
      state = AuthState.unauthenticated();
      return false;
    } catch (e) {
      // Error inesperado, volver a estado no autenticado
      print('⚠️ Error inesperado en login: $e');
      state = AuthState.unauthenticated();
      return false;
    }
  }

  /// Register
  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String role,
    String? phone,
  }) async {
    // Si useMockAuth está activo, simular registro exitoso con usuario mock
    if (DevFlags.useMockAuth) {
      print('🎯 Usando autenticación mock para registro');
      final mockUser = _createMockUser();
      state = AuthState.authenticated(mockUser);
      return true;
    }

    state = AuthState.loading();

    try {
      final response = await _apiService.register({
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        if (phone != null) 'phone': phone,
      });

      if (response.statusCode == 201 && response.data['success'] == true) {
        final authData = AuthDataModel.fromJson(response.data['data']);

        // Guardar tokens
        await _storageService.saveTokens(
          accessToken: authData.tokens.accessToken,
          refreshToken: authData.tokens.refreshToken,
        );

        // Guardar usuario
        await _storageService.saveUserData(authData.user);

        // Actualizar estado
        state = AuthState.authenticated(authData.user);
        print('✅ Registro exitoso: ${response.data['message']}');
        return true;
      } else {
        // Registro falló, volver a estado no autenticado
        print('⚠️ Registro falló: ${response.data['message'] ?? 'Error al registrarse'}');
        state = AuthState.unauthenticated();
        return false;
      }
    } on DioException catch (e) {
      // Error de conexión, volver a estado no autenticado
      final errorMessage = e.response?.data['message'] ?? 'Error de conexión';
      print('⚠️ Error de registro: $errorMessage');
      state = AuthState.unauthenticated();
      return false;
    } catch (e) {
      // Error inesperado, volver a estado no autenticado
      print('⚠️ Error inesperado en registro: $e');
      state = AuthState.unauthenticated();
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      // Obtener refresh token para invalidarlo en el backend
      final refreshToken = await _storageService.getRefreshToken();
      
      if (refreshToken != null) {
        await _apiService.logout({'refreshToken': refreshToken});
      }
    } catch (e) {
      // Ignorar errores de logout del backend
    } finally {
      // Limpiar almacenamiento local
      await _storageService.clearSessionData();
      
      // Actualizar estado - siempre ir a unauthenticated para mostrar login
      state = AuthState.unauthenticated();
    }
  }

  /// Cambiar contraseña
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiService.changePassword({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      });

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        state = state.copyWith(
          error: response.data['message'] ?? 'Error al cambiar contraseña',
        );
        return false;
      }
    } on DioException catch (e) {
      state = state.copyWith(
        error: e.response?.data['message'] ?? 'Error de conexión',
      );
      return false;
    } catch (e) {
      state = state.copyWith(error: 'Error inesperado');
      return false;
    }
  }

  /// Actualizar perfil
  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final userId = state.user?.id;
      if (userId == null) return false;

      final response = await _apiService.updateProfile(userId, profileData);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final updatedUser = UserModel.fromJson(response.data['data']);
        
        // Actualizar usuario en storage
        await _storageService.saveUserData(updatedUser);
        
        // Actualizar estado
        state = AuthState.authenticated(updatedUser);
        return true;
      } else {
        state = state.copyWith(
          error: response.data['message'] ?? 'Error al actualizar perfil',
        );
        return false;
      }
    } on DioException catch (e) {
      state = state.copyWith(
        error: e.response?.data['message'] ?? 'Error de conexión',
      );
      return false;
    } catch (e) {
      state = state.copyWith(error: 'Error inesperado');
      return false;
    }
  }

  /// Limpiar error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Inicializar para presentación real
  Future<void> _initializeForRealPresentation() async {
    try {
      // Intentar login con credenciales de presentación
      print('🎯 Intentando login real con: ${DevCredentials.presentationEmail}');
      final success = await login(
        email: DevCredentials.presentationEmail,
        password: DevCredentials.presentationPassword,
      );
      
      if (success) {
        print('✅ Login de presentación exitoso');
        return;
      }
      
      // Si falla login, mostrar pantalla de login para que el usuario ingrese manualmente
      print('⚠️ Login automático falló, mostrando pantalla de login');
      state = AuthState.unauthenticated();
      
    } catch (e) {
      print('❌ Error en presentación: $e');
      // En caso de error, mostrar login para entrada manual
      state = AuthState.unauthenticated();
    }
  }

  /// Intentar credenciales de respaldo
  Future<void> _tryBackupCredentials() async {
    try {
      print('🎯 Intentando credenciales de respaldo...');
      final success = await login(
        email: DevCredentials.backupEmail,
        password: DevCredentials.backupPassword,
      );
      
      if (success) {
        print('✅ Login de respaldo exitoso');
      } else {
        print('❌ Todo falló, usando usuario mock como último recurso');
        state = AuthState.authenticated(_createMockUser());
      }
    } catch (e) {
      print('❌ Error en respaldo: $e');
      state = AuthState.authenticated(_createMockUser());
    }
  }
}

/// Provider del estado de autenticación
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

/// Provider para verificar si está autenticado
final isAuthenticatedProvider = Provider<bool>((ref) => ref.watch(authProvider).isAuthenticated);

/// Provider para obtener el usuario actual
final currentUserProvider = Provider<UserModel?>((ref) => ref.watch(authProvider).user);

