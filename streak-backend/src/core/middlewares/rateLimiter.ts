import rateLimit from 'express-rate-limit';
import { env } from '../../config/env.config';

/**
 * Rate limiter general para la API
 */
export const apiLimiter = rateLimit({
  windowMs: env.RATE_LIMIT_WINDOW_MS, // 15 minutos por defecto
  max: env.RATE_LIMIT_MAX_REQUESTS, // 100 requests por ventana por defecto
  message: {
    success: false,
    error: {
      code: 'TOO_MANY_REQUESTS',
      message: 'Demasiadas solicitudes desde esta IP, por favor intenta más tarde',
    },
    timestamp: new Date().toISOString(),
  },
  standardHeaders: true, // Return rate limit info in the `RateLimit-*` headers
  legacyHeaders: false, // Disable the `X-RateLimit-*` headers
  // Skip rate limiting for certain requests
  skip: (req) => {
    // No limitar health check
    return req.path === '/health';
  },
});

/**
 * Rate limiter más estricto para auth (login, register)
 */
export const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 5, // 5 requests por ventana
  message: {
    success: false,
    error: {
      code: 'TOO_MANY_AUTH_ATTEMPTS',
      message: 'Demasiados intentos de autenticación, por favor intenta más tarde',
    },
    timestamp: new Date().toISOString(),
  },
  standardHeaders: true,
  legacyHeaders: false,
  // Express-rate-limit maneja automáticamente IPv4 e IPv6
});

/**
 * Rate limiter para creación de recursos
 */
export const createResourceLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hora
  max: 20, // 20 creaciones por hora
  message: {
    success: false,
    error: {
      code: 'TOO_MANY_CREATIONS',
      message: 'Demasiadas creaciones, por favor intenta más tarde',
    },
    timestamp: new Date().toISOString(),
  },
  standardHeaders: true,
  legacyHeaders: false,
  skip: (req) => {
    // Solo aplicar a POST requests
    return req.method !== 'POST';
  },
});
