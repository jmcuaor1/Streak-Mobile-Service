import { Request, Response, NextFunction } from 'express';
import { authService } from './auth.service';
import { sendSuccess } from '../../core/utils/response.utils';
import {
  RegisterInput,
  LoginInput,
  RefreshTokenInput,
  ForgotPasswordInput,
  ResetPasswordInput,
  VerifyEmailInput,
  ChangePasswordInput,
} from './auth.dto';

/**
 * Controlador de Autenticación
 */
export class AuthController {
  /**
   * @route   POST /api/auth/register
   * @desc    Registrar nuevo usuario
   * @access  Public
   */
  async register(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const data: RegisterInput = req.body;

      const result = await authService.register(data);

      res.status(201);
      sendSuccess(res, {
        message: 'Registro exitoso. ¡Bienvenido a Streak!',
        data: {
          user: result.user,
          tokens: {
            accessToken: result.accessToken,
            refreshToken: result.refreshToken,
          },
        },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/login
   * @desc    Login de usuario
   * @access  Public
   */
  async login(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const data: LoginInput = req.body;

      const result = await authService.login(data);

      sendSuccess(res, {
        message: 'Login exitoso',
        data: {
          user: result.user,
          tokens: {
            accessToken: result.accessToken,
            refreshToken: result.refreshToken,
          },
        },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/logout
   * @desc    Logout de usuario
   * @access  Private
   */
  async logout(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;
      const { refreshToken } = req.body;

      await authService.logout(userId, refreshToken);

      sendSuccess(res, {
        message: 'Logout exitoso',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/refresh
   * @desc    Refrescar access token
   * @access  Public
   */
  async refreshToken(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const data: RefreshTokenInput = req.body;

      const tokens = await authService.refreshAccessToken(data.refreshToken);

      sendSuccess(res, {
        message: 'Token refrescado exitosamente',
        data: { tokens },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/verify-email
   * @desc    Verificar email
   * @access  Public
   */
  async verifyEmail(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const data: VerifyEmailInput = req.body;

      const user = await authService.verifyEmail(data.token);

      sendSuccess(res, {
        message: 'Email verificado exitosamente',
        data: { user },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/forgot-password
   * @desc    Solicitar reset de contraseña
   * @access  Public
   */
  async forgotPassword(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const data: ForgotPasswordInput = req.body;

      await authService.forgotPassword(data);

      sendSuccess(res, {
        message: 'Si el email existe, recibirás instrucciones para resetear tu contraseña',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/reset-password
   * @desc    Resetear contraseña
   * @access  Public
   */
  async resetPassword(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const data: ResetPasswordInput = req.body;

      await authService.resetPassword(data);

      sendSuccess(res, {
        message: 'Contraseña reseteada exitosamente',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   POST /api/auth/change-password
   * @desc    Cambiar contraseña (usuario autenticado)
   * @access  Private
   */
  async changePassword(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;
      const data: ChangePasswordInput = req.body;

      await authService.changePassword(userId, data);

      sendSuccess(res, {
        message: 'Contraseña cambiada exitosamente',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/auth/me
   * @desc    Obtener usuario autenticado
   * @access  Private
   */
  async getMe(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const userId = req.user!.userId;

      const user = await authService.getMe(userId);

      sendSuccess(res, {
        message: 'Usuario obtenido exitosamente',
        data: { user },
      });
    } catch (error) {
      next(error);
    }
  }
}

export const authController = new AuthController();
