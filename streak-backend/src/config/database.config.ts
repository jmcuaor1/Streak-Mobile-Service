import { ConnectOptions } from 'mongoose';

/**
 * Opciones de configuración para Mongoose
 */
export const mongooseOptions: ConnectOptions = {
  // Configuración de pool de conexiones
  maxPoolSize: 10, // Máximo de conexiones en el pool
  minPoolSize: 5, // Mínimo de conexiones en el pool

  // Timeouts
  serverSelectionTimeoutMS: 5000, // Timeout para selección de servidor
  socketTimeoutMS: 45000, // Timeout de socket

  // Opciones de retry
  retryWrites: true,
  retryReads: true,

  // Compresión de datos
  compressors: ['zlib'],

  // Otras opciones
  autoIndex: true, // Crear índices automáticamente (desactivar en producción para mejor performance)
};

/**
 * Configuración específica para desarrollo
 */
export const developmentConfig: ConnectOptions = {
  ...mongooseOptions,
  autoIndex: true, // Permitir auto-indexing en desarrollo
};

/**
 * Configuración específica para producción
 */
export const productionConfig: ConnectOptions = {
  ...mongooseOptions,
  autoIndex: false, // Desactivar auto-indexing en producción
  maxPoolSize: 50, // Mayor pool para producción
};

/**
 * Configuración específica para testing
 */
export const testConfig: ConnectOptions = {
  ...mongooseOptions,
  maxPoolSize: 5,
  serverSelectionTimeoutMS: 10000,
};
