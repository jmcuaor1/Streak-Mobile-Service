import { z } from 'zod';
import { UserRole } from '../users/user.model';

/**
 * DTO: Registro de usuario
 */
export const RegisterDTO = z
  .object({
    email: z.string().min(1, 'El email es requerido').email('Email inválido').toLowerCase().trim(),

    password: z
      .string()
      .min(8, 'La contraseña debe tener al menos 8 caracteres')
      .regex(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
        'La contraseña debe contener al menos una mayúscula, una minúscula y un número'
      ),

    confirmPassword: z.string().min(1, 'La confirmación de contraseña es requerida'),

    firstName: z
      .string()
      .min(2, 'El nombre debe tener al menos 2 caracteres')
      .max(50, 'El nombre no puede exceder 50 caracteres')
      .trim(),

    lastName: z
      .string()
      .min(2, 'El apellido debe tener al menos 2 caracteres')
      .max(50, 'El apellido no puede exceder 50 caracteres')
      .trim(),

    role: z.enum([UserRole.CLIENT, UserRole.FREELANCER]).default(UserRole.CLIENT),

    // Campos opcionales
    phone: z.string().optional(),
    location: z.string().optional(),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: 'Las contraseñas no coinciden',
    path: ['confirmPassword'],
  });

export type RegisterInput = z.infer<typeof RegisterDTO>;

/**
 * DTO: Login
 */
export const LoginDTO = z.object({
  email: z.string().min(1, 'El email es requerido').email('Email inválido').toLowerCase().trim(),

  password: z.string().min(1, 'La contraseña es requerida'),
});

export type LoginInput = z.infer<typeof LoginDTO>;

/**
 * DTO: Refresh Token
 */
export const RefreshTokenDTO = z.object({
  refreshToken: z.string().min(1, 'El refresh token es requerido'),
});

export type RefreshTokenInput = z.infer<typeof RefreshTokenDTO>;

/**
 * DTO: Forgot Password
 */
export const ForgotPasswordDTO = z.object({
  email: z.string().min(1, 'El email es requerido').email('Email inválido').toLowerCase().trim(),
});

export type ForgotPasswordInput = z.infer<typeof ForgotPasswordDTO>;

/**
 * DTO: Reset Password
 */
export const ResetPasswordDTO = z
  .object({
    token: z.string().min(1, 'El token es requerido'),

    password: z
      .string()
      .min(8, 'La contraseña debe tener al menos 8 caracteres')
      .regex(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
        'La contraseña debe contener al menos una mayúscula, una minúscula y un número'
      ),

    confirmPassword: z.string().min(1, 'La confirmación de contraseña es requerida'),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: 'Las contraseñas no coinciden',
    path: ['confirmPassword'],
  });

export type ResetPasswordInput = z.infer<typeof ResetPasswordDTO>;

/**
 * DTO: Verificar Email
 */
export const VerifyEmailDTO = z.object({
  token: z.string().min(1, 'El token es requerido'),
});

export type VerifyEmailInput = z.infer<typeof VerifyEmailDTO>;

/**
 * DTO: Cambiar Contraseña
 */
export const ChangePasswordDTO = z
  .object({
    currentPassword: z.string().min(1, 'La contraseña actual es requerida'),

    newPassword: z
      .string()
      .min(8, 'La contraseña debe tener al menos 8 caracteres')
      .regex(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
        'La contraseña debe contener al menos una mayúscula, una minúscula y un número'
      ),

    confirmPassword: z.string().min(1, 'La confirmación de contraseña es requerida'),
  })
  .refine((data) => data.newPassword === data.confirmPassword, {
    message: 'Las contraseñas no coinciden',
    path: ['confirmPassword'],
  })
  .refine((data) => data.currentPassword !== data.newPassword, {
    message: 'La nueva contraseña debe ser diferente a la actual',
    path: ['newPassword'],
  });

export type ChangePasswordInput = z.infer<typeof ChangePasswordDTO>;
