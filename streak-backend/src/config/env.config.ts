import dotenv from 'dotenv';

// Cargar variables de entorno
dotenv.config();

interface EnvConfig {
  // Servidor
  NODE_ENV: string;
  PORT: number;
  API_URL: string;

  // Base de datos
  MONGODB_URI: string;
  MONGODB_URI_TEST?: string;

  // JWT
  JWT_SECRET: string;
  JWT_ACCESS_EXPIRES_IN: string;
  JWT_REFRESH_EXPIRES_IN: string;

  // CORS
  CORS_ORIGIN: string;
  ALLOWED_ORIGINS: string[];

  // Rate Limiting
  RATE_LIMIT_WINDOW_MS: number;
  RATE_LIMIT_MAX_REQUESTS: number;

  // Firebase
  FIREBASE_PROJECT_ID?: string;
  FIREBASE_PRIVATE_KEY?: string;
  FIREBASE_CLIENT_EMAIL?: string;
  FIREBASE_SERVICE_ACCOUNT_PATH?: string;

  // Logging
  LOG_LEVEL: string;
}

const getEnvVar = (key: string, defaultValue?: string): string => {
  const value = process.env[key];
  if (!value && !defaultValue) {
    throw new Error(`Falta la variable de entorno: ${key}`);
  }
  return value || defaultValue!;
};

const getEnvNumber = (key: string, defaultValue: number): number => {
  const value = process.env[key];
  return value ? parseInt(value, 10) : defaultValue;
};

export const env: EnvConfig = {
  // Servidor
  NODE_ENV: getEnvVar('NODE_ENV', 'development'),
  PORT: getEnvNumber('PORT', 4000),
  API_URL: getEnvVar('API_URL', 'http://localhost:4000'),

  // Base de datos
  MONGODB_URI: getEnvVar('MONGODB_URI'),
  MONGODB_URI_TEST: process.env.MONGODB_URI_TEST,

  // JWT
  JWT_SECRET: getEnvVar('JWT_SECRET'),
  JWT_ACCESS_EXPIRES_IN: getEnvVar('JWT_ACCESS_EXPIRES_IN', '1h'),
  JWT_REFRESH_EXPIRES_IN: getEnvVar('JWT_REFRESH_EXPIRES_IN', '7d'),

  // CORS
  CORS_ORIGIN: getEnvVar('CORS_ORIGIN', '*'),
  ALLOWED_ORIGINS: getEnvVar('ALLOWED_ORIGINS', '*').split(','),

  // Rate Limiting
  RATE_LIMIT_WINDOW_MS: getEnvNumber('RATE_LIMIT_WINDOW_MS', 900000),
  RATE_LIMIT_MAX_REQUESTS: getEnvNumber('RATE_LIMIT_MAX_REQUESTS', 100),

  // Firebase
  FIREBASE_PROJECT_ID: process.env.FIREBASE_PROJECT_ID,
  FIREBASE_PRIVATE_KEY: process.env.FIREBASE_PRIVATE_KEY,
  FIREBASE_CLIENT_EMAIL: process.env.FIREBASE_CLIENT_EMAIL,
  FIREBASE_SERVICE_ACCOUNT_PATH: process.env.FIREBASE_SERVICE_ACCOUNT_PATH,

  // Logging
  LOG_LEVEL: getEnvVar('LOG_LEVEL', 'debug'),
};
