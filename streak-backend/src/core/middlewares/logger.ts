import { Request, Response, NextFunction } from 'express';
import morgan from 'morgan';
import { env } from '../../config/env.config';

/**
 * Formato personalizado de logging para Morgan
 */
const morganFormat =
  env.NODE_ENV === 'production'
    ? ':remote-addr - :remote-user [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] ":referrer" ":user-agent" :response-time ms'
    : 'dev';

/**
 * Middleware de Morgan configurado
 */
export const morganLogger = morgan(morganFormat, {
  skip: (req: Request) => {
    // Saltar logging para health check en producción
    return env.NODE_ENV === 'production' && req.url === '/health';
  },
});

/**
 * Logger personalizado para eventos importantes
 */
export class Logger {
  /**
   * Log de información general
   */
  static info(message: string, meta?: Record<string, unknown>): void {
    const timestamp = new Date().toISOString();
    console.log(`[INFO] ${timestamp} - ${message}`, meta ? JSON.stringify(meta) : '');
  }

  /**
   * Log de advertencias
   */
  static warn(message: string, meta?: Record<string, unknown>): void {
    const timestamp = new Date().toISOString();
    console.warn(`[WARN] ${timestamp} - ${message}`, meta ? JSON.stringify(meta) : '');
  }

  /**
   * Log de errores
   */
  static error(message: string, error?: Error | unknown, meta?: Record<string, unknown>): void {
    const timestamp = new Date().toISOString();
    console.error(`[ERROR] ${timestamp} - ${message}`);

    if (error instanceof Error) {
      console.error('Stack:', error.stack);
      console.error('Message:', error.message);
    } else if (error) {
      console.error('Error:', error);
    }

    if (meta) {
      console.error('Meta:', JSON.stringify(meta));
    }
  }

  /**
   * Log de debug (solo en desarrollo)
   */
  static debug(message: string, meta?: Record<string, unknown>): void {
    if (env.NODE_ENV === 'development') {
      const timestamp = new Date().toISOString();
      console.log(`[DEBUG] ${timestamp} - ${message}`, meta ? JSON.stringify(meta) : '');
    }
  }
}

/**
 * Middleware para loggear requests y responses
 */
export const requestLogger = (req: Request, res: Response, next: NextFunction): void => {
  const start = Date.now();

  // Log cuando la respuesta termina
  res.on('finish', () => {
    const duration = Date.now() - start;
    const { method, originalUrl, ip } = req;
    const { statusCode } = res;

    // Log solo en desarrollo o si hay error
    if (env.NODE_ENV === 'development' || statusCode >= 400) {
      Logger.info(`${method} ${originalUrl}`, {
        statusCode,
        duration: `${duration}ms`,
        ip,
        userAgent: req.get('user-agent'),
      });
    }
  });

  next();
};
