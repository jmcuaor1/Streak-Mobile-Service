import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

/// ==================== REQUEST DTOs ====================

/// DTO para Register
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    @Default('client') String role,
    String? phone,
    String? location,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

/// DTO para Login
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

/// DTO para Refresh Token
@freezed
class RefreshTokenRequest with _$RefreshTokenRequest {
  const factory RefreshTokenRequest({
    required String refreshToken,
  }) = _RefreshTokenRequest;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
}

/// DTO para Forgot Password
@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({
    required String email,
  }) = _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

/// DTO para Reset Password
@freezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  const factory ResetPasswordRequest({
    required String token,
    required String password,
    required String confirmPassword,
  }) = _ResetPasswordRequest;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
}

/// DTO para Change Password
@freezed
class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

/// ==================== RESPONSE DTOs ====================

/// Respuesta de Login/Register
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required bool success,
    String? message,
    AuthDataModel? data,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Datos de autenticación (user + tokens)
@freezed
class AuthDataModel with _$AuthDataModel {
  const factory AuthDataModel({
    required UserModel user,
    required TokensModel tokens,
  }) = _AuthDataModel;

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);
}

/// Modelo de Tokens
@freezed
class TokensModel with _$TokensModel {
  const factory TokensModel({
    required String accessToken,
    required String refreshToken,
  }) = _TokensModel;

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);
}

/// Respuesta genérica de la API
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    String? message,
    T? data,
    Map<String, dynamic>? error,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

/// Respuesta paginada
@Freezed(genericArgumentFactories: true)
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required bool success,
    @Default([]) List<T> data,
    required PaginationModel pagination,
  }) = _PaginatedResponse<T>;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);
}

/// Modelo de Paginación
@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    required int total,
    required int page,
    required int limit,
    required int totalPages,
    required bool hasNext,
    required bool hasPrev,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

