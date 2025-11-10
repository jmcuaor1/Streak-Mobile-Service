import { Response } from 'express';

/**
 * Estructura estándar de respuesta exitosa
 */
export interface SuccessResponse<T = unknown> {
  success: true;
  data: T;
  message?: string;
  meta?: Record<string, unknown>;
}

/**
 * Estructura estándar de respuesta de error
 */
export interface ErrorResponse {
  success: false;
  error: {
    code: string;
    message: string;
    details?: unknown;
  };
  timestamp: string;
  path?: string;
}

/**
 * Enviar respuesta exitosa
 */
export const sendSuccess = <T>(
  res: Response,
  payload:
    | {
        data?: T;
        message?: string;
      }
    | T,
  statusCode: number = 200
): Response<SuccessResponse<T>> => {
  // Si payload tiene la estructura {data, message}
  const isObject =
    typeof payload === 'object' && payload !== null && ('data' in payload || 'message' in payload);

  const response: SuccessResponse<T> = {
    success: true,
    data: isObject ? ((payload as { data?: T; message?: string }).data as T) : (payload as T),
    ...(isObject &&
      (payload as { data?: T; message?: string }).message && {
        message: (payload as { data?: T; message?: string }).message,
      }),
  };

  return res.status(statusCode).json(response);
};

/**
 * Enviar respuesta de error
 */
export const sendError = (
  res: Response,
  code: string,
  message: string,
  statusCode: number = 500,
  details?: unknown,
  path?: string
): Response<ErrorResponse> => {
  const response: ErrorResponse = {
    success: false,
    error: {
      code,
      message,
      details,
    },
    timestamp: new Date().toISOString(),
    path,
  };

  return res.status(statusCode).json(response);
};

/**
 * Respuestas predefinidas comunes
 */
export class ApiResponse {
  /**
   * 200 OK - Solicitud exitosa
   */
  static ok<T>(res: Response, data: T, message?: string): Response {
    return sendSuccess(res, { data, message }, 200);
  }

  /**
   * 201 Created - Recurso creado exitosamente
   */
  static created<T>(res: Response, data: T, message?: string): Response {
    res.status(201);
    return sendSuccess(res, { data, message: message || 'Recurso creado exitosamente' });
  }

  /**
   * 204 No Content - Solicitud exitosa sin contenido
   */
  static noContent(res: Response): Response {
    return res.status(204).send();
  }

  /**
   * 400 Bad Request - Solicitud incorrecta
   */
  static badRequest(
    res: Response,
    message: string = 'Solicitud incorrecta',
    details?: unknown
  ): Response {
    return sendError(res, 'BAD_REQUEST', message, 400, details);
  }

  /**
   * 401 Unauthorized - No autenticado
   */
  static unauthorized(res: Response, message: string = 'No autenticado'): Response {
    return sendError(res, 'UNAUTHORIZED', message, 401);
  }

  /**
   * 403 Forbidden - Sin permisos
   */
  static forbidden(
    res: Response,
    message: string = 'No tienes permisos para realizar esta acción'
  ): Response {
    return sendError(res, 'FORBIDDEN', message, 403);
  }

  /**
   * 404 Not Found - Recurso no encontrado
   */
  static notFound(res: Response, message: string = 'Recurso no encontrado'): Response {
    return sendError(res, 'NOT_FOUND', message, 404);
  }

  /**
   * 409 Conflict - Conflicto con el estado actual
   */
  static conflict(res: Response, message: string, details?: unknown): Response {
    return sendError(res, 'CONFLICT', message, 409, details);
  }

  /**
   * 422 Unprocessable Entity - Validación fallida
   */
  static validationError(
    res: Response,
    message: string = 'Error de validación',
    details?: unknown
  ): Response {
    return sendError(res, 'VALIDATION_ERROR', message, 422, details);
  }

  /**
   * 429 Too Many Requests - Demasiadas solicitudes
   */
  static tooManyRequests(
    res: Response,
    message: string = 'Demasiadas solicitudes, intenta más tarde'
  ): Response {
    return sendError(res, 'TOO_MANY_REQUESTS', message, 429);
  }

  /**
   * 500 Internal Server Error - Error del servidor
   */
  static internalError(
    res: Response,
    message: string = 'Error interno del servidor',
    details?: unknown
  ): Response {
    return sendError(res, 'INTERNAL_ERROR', message, 500, details);
  }

  /**
   * 503 Service Unavailable - Servicio no disponible
   */
  static serviceUnavailable(
    res: Response,
    message: string = 'Servicio temporalmente no disponible'
  ): Response {
    return sendError(res, 'SERVICE_UNAVAILABLE', message, 503);
  }
}

/**
 * Respuesta paginada
 */
export interface PaginatedResponse<T> {
  success: true;
  data: T[];
  pagination: {
    total: number;
    page: number;
    limit: number;
    totalPages: number;
    hasNext: boolean;
    hasPrev: boolean;
  };
}

/**
 * Enviar respuesta paginada
 */
export const sendPaginatedResponse = <T>(
  res: Response,
  data: T[],
  total: number,
  page: number,
  limit: number
): Response<PaginatedResponse<T>> => {
  const totalPages = Math.ceil(total / limit);

  const response: PaginatedResponse<T> = {
    success: true,
    data,
    pagination: {
      total,
      page,
      limit,
      totalPages,
      hasNext: page < totalPages,
      hasPrev: page > 1,
    },
  };

  return res.status(200).json(response);
};

/**
 * Enviar respuesta paginada con mensaje
 */
export const sendPaginated = <T>(
  res: Response,
  payload: {
    data: T[];
    message?: string;
    pagination: {
      page: number;
      limit: number;
      total: number;
      totalPages: number;
    };
  }
): Response => {
  const response = {
    success: true,
    ...(payload.message && { message: payload.message }),
    data: payload.data,
    pagination: {
      ...payload.pagination,
      hasNext: payload.pagination.page < payload.pagination.totalPages,
      hasPrev: payload.pagination.page > 1,
    },
  };

  return res.status(200).json(response);
};
