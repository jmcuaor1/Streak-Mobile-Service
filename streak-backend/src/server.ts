import dotenv from 'dotenv';

// Cargar variables de entorno primero
dotenv.config();

import app from './app';
import { env } from './config/env.config';
import { connectDatabase } from './core/database/connection';

const PORT = env.PORT || 4000;

/**
 * Iniciar el servidor
 */
const startServer = async () => {
  try {
    // Conectar a la base de datos
    await connectDatabase();

    // Iniciar servidor HTTP
    app.listen(PORT, () => {
      console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
      console.log(`📍 Entorno: ${env.NODE_ENV}`);
      console.log(`🌐 URL: ${env.API_URL}`);
    });
  } catch (error) {
    console.error('❌ Error iniciando el servidor:', error);
    process.exit(1);
  }
};

// Iniciar servidor
startServer().catch((error) => {
  console.error('❌ Error fatal:', error);
  process.exit(1);
});

// Manejo de errores no capturados
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});

process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error);
  process.exit(1);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('👋 SIGTERM recibido, cerrando servidor gracefully...');
  process.exit(0);
});
