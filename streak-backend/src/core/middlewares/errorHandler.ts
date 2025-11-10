import { Request, Response, NextFunction } from 'express';
import { ZodError } from 'zod';
import { Error as MongooseError } from 'mongoose';
import { sendError } from '../utils/response.utils';
import { Logger } from './logger';
import { env } from '../../config/env.config';

/**
 * Clase base para errores personalizados de la aplicación
 */
export class AppError extends Error {
  constructor(
    public statusCode: number,
    public code: string,
    message: string,
    public isOperational: boolean = true
  ) {
    super(message);
    this.name = this.constructor.name;
    Error.captureStackTrace(this, this.constructor);
  }
}

/**
 * Errores específicos de la aplicación
 */
export class ValidationError extends AppError {
  constructor(
    message: string,
    public details?: unknown
  ) {
    super(422, 'VALIDATION_ERROR', message);
  }
}

export class NotFoundError extends AppError {
  constructor(message: string = 'Recurso no encontrado') {
    super(404, 'NOT_FOUND', message);
  }
}

export class UnauthorizedError extends AppError {
  constructor(message: string = 'No autenticado') {
    super(401, 'UNAUTHORIZED', message);
  }
}

export class ForbiddenError extends AppError {
  constructor(message: string = 'No tienes permisos para realizar esta acción') {
    super(403, 'FORBIDDEN', message);
  }
}

export class ConflictError extends AppError {
  constructor(
    message: string,
    public details?: unknown
  ) {
    super(409, 'CONFLICT', message);
  }
}

export class BadRequestError extends AppError {
  constructor(
    message: string,
    public details?: unknown
  ) {
    super(400, 'BAD_REQUEST', message);
  }
}

/**
 * Manejar errores de validación de Zod
 */
const handleZodError = (error: ZodError): { code: string; message: string; details: unknown } => {
  const errors = error.issues.map((err) => ({
    field: err.path.join('.'),
    message: err.message,
  }));

  return {
    code: 'VALIDATION_ERROR',
    message: 'Error de validación',
    details: errors,
  };
};

/**
 * Manejar errores de validación de Mongoose
 */
const handleMongooseValidationError = (
  error: MongooseError.ValidationError
): { code: string; message: string; details: unknown } => {
  const errors = Object.values(error.errors).map((err) => ({
    field: err.path,
    message: err.message,
  }));

  return {
    code: 'VALIDATION_ERROR',
    message: 'Error de validación de datos',
    details: errors,
  };
};

/**
 * Manejar errores de duplicado de Mongoose
 */
const handleMongoDuplicateError = (error: {
  code: number;
  keyValue: Record<string, unknown>;
}): { code: string; message: string; details: unknown } => {
  const field = Object.keys(error.keyValue)[0];
  return {
    code: 'DUPLICATE_ERROR',
    message: `El valor de '${field}' ya existe`,
    details: error.keyValue,
  };
};

/**
 * Manejar errores de cast de Mongoose (ID inválido)
 */
const handleMongoCastError = (
  error: MongooseError.CastError
): { code: string; message: string } => {
  return {
    code: 'INVALID_ID',
    message: `ID inválido: ${error.value}`,
  };
};

/**
 * Middleware de manejo de errores
 * Debe ser el último middleware en app.ts
 */
export const errorHandler = (
  error: Error,
  req: Request,
  res: Response,
  _next: NextFunction
): Response => {
  let statusCode = 500;
  let code = 'INTERNAL_ERROR';
  let message = 'Error interno del servidor';
  let details: unknown;

  // Log del error
  Logger.error('Error capturado por errorHandler', error, {
    path: req.path,
    method: req.method,
    ip: req.ip,
    userAgent: req.get('user-agent'),
  });

  // Errores personalizados de la aplicación
  if (error instanceof AppError) {
    statusCode = error.statusCode;
    code = error.code;
    message = error.message;
    details = 'details' in error ? error.details : undefined;
  }
  // Errores de validación de Zod
  else if (error instanceof ZodError) {
    statusCode = 422;
    const zodError = handleZodError(error);
    code = zodError.code;
    message = zodError.message;
    details = zodError.details;
  }
  // Errores de validación de Mongoose
  else if (error instanceof MongooseError.ValidationError) {
    statusCode = 422;
    const mongooseError = handleMongooseValidationError(error);
    code = mongooseError.code;
    message = mongooseError.message;
    details = mongooseError.details;
  }
  // Error de duplicado de MongoDB (código 11000)
  else if ('code' in error && (error as { code: number }).code === 11000 && 'keyValue' in error) {
    statusCode = 409;
    const duplicateError = handleMongoDuplicateError({
      code: (error as { code: number }).code,
      keyValue: (error as unknown as { keyValue: Record<string, unknown> }).keyValue,
    });
    code = duplicateError.code;
    message = duplicateError.message;
    details = duplicateError.details;
  }
  // Error de cast de Mongoose (ID inválido)
  else if (error instanceof MongooseError.CastError) {
    statusCode = 400;
    const castError = handleMongoCastError(error);
    code = castError.code;
    message = castError.message;
  }
  // Errores genéricos
  else if (error.message) {
    message = error.message;
  }

  // En desarrollo, incluir stack trace
  if (env.NODE_ENV === 'development' && error.stack) {
    details = {
      ...(details && typeof details === 'object' ? details : {}),
      stack: error.stack.split('\n'),
    };
  }

  // Enviar respuesta de error
  return sendError(res, code, message, statusCode, details, req.path);
};

/**
 * Middleware para capturar rutas no encontradas
 */
export const notFoundHandler = (req: Request, res: Response): Response => {
  return sendError(
    res,
    'NOT_FOUND',
    `Ruta no encontrada: ${req.method} ${req.path}`,
    404,
    undefined,
    req.path
  );
};

/**
 * Wrapper para async handlers
 * Captura errores de funciones asíncronas automáticamente
 */
export const asyncHandler = (
  fn: (req: Request, res: Response, next: NextFunction) => Promise<unknown>
) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};
