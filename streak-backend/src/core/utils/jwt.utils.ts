import jwt from 'jsonwebtoken';
import { env } from '../../config/env.config';
import { UserRole } from '../../api/users/user.model';

/**
 * Payload del JWT
 */
export interface JWTPayload {
  userId: string;
  email: string;
  role: UserRole;
}

/**
 * Tipo de token
 */
export enum TokenType {
  ACCESS = 'access',
  REFRESH = 'refresh',
}

/**
 * Generar Access Token
 * Expira en 1 hora por defecto
 */
export const generateAccessToken = (payload: JWTPayload): string => {
  return jwt.sign(
    {
      ...payload,
      type: TokenType.ACCESS,
    },
    env.JWT_SECRET,
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    { expiresIn: env.JWT_ACCESS_EXPIRES_IN as any }
  );
};

/**
 * Generar Refresh Token
 * Expira en 7 días por defecto
 */
export const generateRefreshToken = (payload: JWTPayload): string => {
  return jwt.sign(
    {
      ...payload,
      type: TokenType.REFRESH,
    },
    env.JWT_SECRET,
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    { expiresIn: env.JWT_REFRESH_EXPIRES_IN as any }
  );
};

/**
 * Generar ambos tokens
 */
export const generateTokens = (
  payload: JWTPayload
): { accessToken: string; refreshToken: string } => {
  return {
    accessToken: generateAccessToken(payload),
    refreshToken: generateRefreshToken(payload),
  };
};

/**
 * Verificar token
 */
export const verifyToken = (
  token: string,
  expectedType?: TokenType
): JWTPayload & { type: TokenType } => {
  try {
    const decoded = jwt.verify(token, env.JWT_SECRET) as JWTPayload & {
      type: TokenType;
    };

    // Verificar el tipo de token si se especifica
    if (expectedType && decoded.type !== expectedType) {
      throw new Error(`Token inválido: se esperaba tipo ${expectedType}`);
    }

    return decoded;
  } catch (error) {
    if (error instanceof jwt.TokenExpiredError) {
      throw new Error('Token expirado');
    }
    if (error instanceof jwt.JsonWebTokenError) {
      throw new Error('Token inválido');
    }
    throw error;
  }
};

/**
 * Decodificar token sin verificar (útil para debugging)
 */
export const decodeToken = (token: string): (JWTPayload & { type: TokenType }) | null => {
  try {
    return jwt.decode(token) as JWTPayload & { type: TokenType };
  } catch {
    return null;
  }
};

/**
 * Verificar si un token está expirado
 */
export const isTokenExpired = (token: string): boolean => {
  try {
    const decoded = jwt.decode(token) as { exp?: number } | null;
    if (!decoded || !decoded.exp) {
      return true;
    }
    return decoded.exp * 1000 < Date.now();
  } catch {
    return true;
  }
};
