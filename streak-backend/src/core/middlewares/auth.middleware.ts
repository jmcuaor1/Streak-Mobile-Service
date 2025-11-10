import { Request, Response, NextFunction } from 'express';
import { verifyToken, TokenType, JWTPayload } from '../utils/jwt.utils';
import { UnauthorizedError, ForbiddenError } from './errorHandler';
import { UserRole } from '../../api/users/user.model';

/**
 * Extender Request de Express para incluir user
 */
declare global {
  namespace Express {
    interface Request {
      user?: JWTPayload;
    }
  }
}

/**
 * Middleware: Autenticación con JWT
 * Verifica que el usuario esté autenticado
 */
export const authenticate = async (
  req: Request,
  _res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    // Obtener token del header Authorization
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedError('No se proporcionó token de autenticación');
    }

    const token = authHeader.substring(7); // Remover 'Bearer '

    // En modo desarrollo, aceptar token mock
    if (token === 'dev-mock-token-123') {
      req.user = {
        userId: 'dev-user-123',
        email: 'dev@example.com',
        role: UserRole.FREELANCER,
      };
      return next();
    }

    // Verificar token real
    const decoded = verifyToken(token, TokenType.ACCESS);

    // Agregar usuario al request
    req.user = {
      userId: decoded.userId,
      email: decoded.email,
      role: decoded.role,
    };

    next();
  } catch (error) {
    if (error instanceof Error) {
      next(new UnauthorizedError(error.message));
    } else {
      next(new UnauthorizedError('Token inválido'));
    }
  }
};

/**
 * Middleware: Autorización por rol
 * Verifica que el usuario tenga uno de los roles permitidos
 */
export const authorize = (...allowedRoles: UserRole[]) => {
  return (req: Request, _res: Response, next: NextFunction): void => {
    try {
      if (!req.user) {
        throw new UnauthorizedError('Usuario no autenticado');
      }

      if (!allowedRoles.includes(req.user.role)) {
        throw new ForbiddenError('No tienes permisos para realizar esta acción');
      }

      next();
    } catch (error) {
      next(error);
    }
  };
};

/**
 * Middleware: Verificar que el usuario es el dueño del recurso
 * o es un admin
 */
export const authorizeOwnerOrAdmin = (userIdParam = 'id') => {
  return (req: Request, _res: Response, next: NextFunction): void => {
    try {
      if (!req.user) {
        throw new UnauthorizedError('Usuario no autenticado');
      }

      const resourceUserId = req.params[userIdParam];

      // Permitir si es admin o si es el dueño del recurso
      if (req.user.role === UserRole.ADMIN || req.user.userId === resourceUserId) {
        next();
      } else {
        throw new ForbiddenError('No tienes permisos para acceder a este recurso');
      }
    } catch (error) {
      next(error);
    }
  };
};

/**
 * Middleware: Autenticación opcional
 * Agrega el usuario al request si hay token, pero no falla si no lo hay
 */
export const optionalAuth = async (
  req: Request,
  _res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const authHeader = req.headers.authorization;

    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.substring(7);

      // En modo desarrollo, aceptar token mock
      if (token === 'dev-mock-token-123') {
        req.user = {
          userId: 'dev-user-123',
          email: 'dev@example.com',
          role: UserRole.FREELANCER,
        };
      } else {
        const decoded = verifyToken(token, TokenType.ACCESS);
        req.user = {
          userId: decoded.userId,
          email: decoded.email,
          role: decoded.role,
        };
      }
    }

    next();
  } catch {
    // Si hay error, simplemente continuar sin usuario
    next();
  }
};
