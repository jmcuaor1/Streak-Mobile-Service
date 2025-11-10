import { Request, Response, NextFunction } from 'express';
import { ZodSchema, ZodError } from 'zod';
import { ValidationError } from './errorHandler';

/**
 * Tipos de validación
 */
type ValidationTarget = 'body' | 'query' | 'params';

/**
 * Middleware para validar requests con Zod
 * @param schema - Schema de Zod para validar
 * @param target - Parte del request a validar (body, query, params)
 */
export const validateRequest = (schema: ZodSchema, target: ValidationTarget = 'body') => {
  return async (req: Request, _res: Response, next: NextFunction): Promise<void> => {
    try {
      // Obtener los datos a validar según el target
      const dataToValidate = req[target];

      // Validar datos con Zod
      const validated = await schema.parseAsync(dataToValidate);

      // Reemplazar los datos del request con los validados y sanitizados
      req[target] = validated;

      next();
    } catch (error) {
      // Si es error de Zod, pasar al error handler
      if (error instanceof ZodError) {
        next(error);
      } else {
        // Si es otro tipo de error, crear ValidationError
        next(new ValidationError('Error de validación'));
      }
    }
  };
};

/**
 * Middleware para validar múltiples partes del request
 */
export const validateMultiple = (schemas: {
  body?: ZodSchema;
  query?: ZodSchema;
  params?: ZodSchema;
}) => {
  return async (req: Request, _res: Response, next: NextFunction): Promise<void> => {
    try {
      // Validar body si existe schema
      if (schemas.body) {
        req.body = await schemas.body.parseAsync(req.body);
      }

      // Validar query si existe schema
      if (schemas.query) {
        req.query = (await schemas.query.parseAsync(req.query)) as typeof req.query;
      }

      // Validar params si existe schema
      if (schemas.params) {
        req.params = (await schemas.params.parseAsync(req.params)) as typeof req.params;
      }

      next();
    } catch (error) {
      if (error instanceof ZodError) {
        next(error);
      } else {
        next(new ValidationError('Error de validación'));
      }
    }
  };
};

/**
 * Validar solo el body del request
 */
export const validateBody = (schema: ZodSchema) => validateRequest(schema, 'body');

/**
 * Validar solo los query params del request
 */
export const validateQuery = (schema: ZodSchema) => validateRequest(schema, 'query');

/**
 * Validar solo los route params del request
 */
export const validateParams = (schema: ZodSchema) => validateRequest(schema, 'params');
