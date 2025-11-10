import { User, IUser, AccountStatus } from '../users/user.model';
import {
  RegisterInput,
  LoginInput,
  ForgotPasswordInput,
  ResetPasswordInput,
  ChangePasswordInput,
} from './auth.dto';
import { generateTokens, verifyToken, TokenType } from '../../core/utils/jwt.utils';
import {
  AppError,
  UnauthorizedError,
  ConflictError,
  NotFoundError,
} from '../../core/middlewares/errorHandler';

/**
 * Servicio de Autenticación
 */
export class AuthService {
  /**
   * Registrar nuevo usuario
   */
  async register(
    data: RegisterInput
  ): Promise<{ user: IUser; accessToken: string; refreshToken: string }> {
    // Verificar si el email ya existe
    const existingUser = await User.findOne({ email: data.email });
    if (existingUser) {
      throw new ConflictError('El email ya está registrado');
    }

    // Crear usuario
    const user = await User.create({
      email: data.email,
      password: data.password,
      role: data.role,
      accountStatus: AccountStatus.PENDING,
      profile: {
        firstName: data.firstName,
        lastName: data.lastName,
        phone: data.phone,
        location: data.location,
      },
      emailVerified: true, // Cambiado a true para presentación
      // Generar token de verificación
      emailVerificationToken: Math.random().toString(36).substring(2, 15),
    });

    // Generar tokens JWT
    const tokens = generateTokens({
      userId: (user._id as string).toString(),
      email: user.email,
      role: user.role,
    });

    // Guardar refresh token en el usuario
    user.refreshTokens.push(tokens.refreshToken);
    await user.save();

    // TODO: Enviar email de verificación
    // await emailService.sendVerificationEmail(user.email, user.emailVerificationToken);

    return {
      user,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    };
  }

  /**
   * Login de usuario
   */
  async login(
    data: LoginInput
  ): Promise<{ user: IUser; accessToken: string; refreshToken: string }> {
    // Buscar usuario con password (select: false por defecto)
    const user = await User.findOne({ email: data.email }).select('+password');

    if (!user) {
      throw new UnauthorizedError('Credenciales inválidas');
    }

    // Verificar contraseña
    const isPasswordValid = await user.comparePassword(data.password);
    if (!isPasswordValid) {
      throw new UnauthorizedError('Credenciales inválidas');
    }

    // Verificar que la cuenta no esté suspendida o eliminada
    if (user.accountStatus === AccountStatus.SUSPENDED) {
      throw new UnauthorizedError('Tu cuenta ha sido suspendida');
    }

    if (user.accountStatus === AccountStatus.DELETED) {
      throw new UnauthorizedError('Esta cuenta no existe');
    }

    // Generar tokens JWT
    const tokens = generateTokens({
      userId: (user._id as string).toString(),
      email: user.email,
      role: user.role,
    });

    // Guardar refresh token
    user.refreshTokens.push(tokens.refreshToken);
    user.lastLoginAt = new Date();
    await user.save();

    // Remover password del objeto user antes de devolverlo
    user.password = undefined as any;

    return {
      user,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    };
  }

  /**
   * Logout de usuario
   */
  async logout(userId: string, refreshToken: string): Promise<void> {
    const user = await User.findById(userId);
    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Remover refresh token
    user.refreshTokens = user.refreshTokens.filter((token) => token !== refreshToken);
    await user.save();
  }

  /**
   * Refresh access token
   */
  async refreshAccessToken(
    refreshToken: string
  ): Promise<{ accessToken: string; refreshToken: string }> {
    // Verificar refresh token
    let decoded;
    try {
      decoded = verifyToken(refreshToken, TokenType.REFRESH);
    } catch {
      throw new UnauthorizedError('Refresh token inválido o expirado');
    }

    // Buscar usuario
    const user = await User.findById(decoded.userId);
    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Verificar que el refresh token esté en la lista del usuario
    if (!user.refreshTokens.includes(refreshToken)) {
      throw new UnauthorizedError('Refresh token inválido');
    }

    // Generar nuevos tokens
    const tokens = generateTokens({
      userId: (user._id as string).toString(),
      email: user.email,
      role: user.role,
    });

    // Reemplazar refresh token viejo con el nuevo
    user.refreshTokens = user.refreshTokens.filter((token) => token !== refreshToken);
    user.refreshTokens.push(tokens.refreshToken);
    await user.save();

    return tokens;
  }

  /**
   * Verificar email
   */
  async verifyEmail(token: string): Promise<IUser> {
    const user = await User.findOne({ emailVerificationToken: token });

    if (!user) {
      throw new NotFoundError('Token de verificación inválido');
    }

    // Marcar email como verificado
    user.emailVerified = true;
    user.emailVerificationToken = undefined;
    user.accountStatus = AccountStatus.ACTIVE;
    await user.save();

    return user;
  }

  /**
   * Solicitar reset de contraseña
   */
  async forgotPassword(data: ForgotPasswordInput): Promise<void> {
    const user = await User.findOne({ email: data.email });

    if (!user) {
      // No revelar si el email existe o no (seguridad)
      return;
    }

    // Generar token de reset
    user.generatePasswordResetToken();
    await user.save({ validateBeforeSave: false });

    // TODO: Enviar email con el token
    // const resetToken = user.passwordResetToken;
    // await emailService.sendPasswordResetEmail(user.email, resetToken!);
  }

  /**
   * Resetear contraseña
   */
  async resetPassword(data: ResetPasswordInput): Promise<void> {
    const user = await User.findOne({
      passwordResetToken: data.token,
      passwordResetExpires: { $gt: Date.now() },
    });

    if (!user) {
      throw new AppError(400, 'INVALID_RESET_TOKEN', 'Token inválido o expirado');
    }

    // Actualizar contraseña
    user.password = data.password;
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;

    // Invalidar todos los refresh tokens por seguridad
    user.refreshTokens = [];

    await user.save();
  }

  /**
   * Cambiar contraseña (usuario autenticado)
   */
  async changePassword(userId: string, data: ChangePasswordInput): Promise<void> {
    const user = await User.findById(userId).select('+password');

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Verificar contraseña actual
    const isPasswordValid = await user.comparePassword(data.currentPassword);
    if (!isPasswordValid) {
      throw new UnauthorizedError('Contraseña actual incorrecta');
    }

    // Actualizar contraseña
    user.password = data.newPassword;

    // Invalidar todos los refresh tokens excepto el actual por seguridad
    user.refreshTokens = [];

    await user.save();
  }

  /**
   * Obtener usuario autenticado
   */
  async getMe(userId: string): Promise<IUser> {
    const user = await User.findById(userId).populate('gamification.achievements');

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    return user;
  }
}

export const authService = new AuthService();
