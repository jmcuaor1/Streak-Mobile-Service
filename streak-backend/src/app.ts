import express, { Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { env } from './config/env.config';
import { isDatabaseConnected } from './core/database/connection';
import { morganLogger, requestLogger } from './core/middlewares/logger';
import { errorHandler, notFoundHandler } from './core/middlewares/errorHandler';
import { apiLimiter } from './core/middlewares/rateLimiter';

// Rutas
import authRoutes from './api/auth/auth.routes';
import userRoutes from './api/users/user.routes';
// import userProfessionalRoutes from './api/users/user-professional.routes';
import jobRoutes from './api/jobs/job.routes';
import applicationRoutes from './api/applications/application.routes';
import gamificationRoutes from './api/gamification/gamification.routes';
// import postRoutes from './api/social/post.routes';
// import connectionRoutes from './api/social/connection.routes';
// import companyRoutes from './api/companies/company.routes';

const app: Application = express();

// Middlewares de seguridad
app.use(helmet());
app.use(
  cors({
    origin: env.ALLOWED_ORIGINS,
    credentials: true,
  })
);

// Middlewares de logging
app.use(morganLogger);
app.use(requestLogger);

// Body parsers
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Rate limiting
app.use('/api', apiLimiter);

// Ruta raíz
app.get('/', (_req, res) => {
  res.json({
    success: true,
    message: 'Streak API - Bienvenido',
    version: '1.0.0',
    environment: env.NODE_ENV,
    docs: '/api/docs', // Para cuando implementemos Swagger
  });
});

// Health check
app.get('/health', (_req, res) => {
  const dbConnected = isDatabaseConnected();

  res.status(dbConnected ? 200 : 503).json({
    success: dbConnected,
    status: dbConnected ? 'OK' : 'Service Unavailable',
    timestamp: new Date().toISOString(),
    environment: env.NODE_ENV,
    services: {
      api: 'OK',
      database: dbConnected ? 'OK' : 'DISCONNECTED',
    },
  });
});

// Rutas de la API
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
// app.use('/api/users', userProfessionalRoutes); // Rutas profesionales del usuario (temporalmente deshabilitadas)
app.use('/api/jobs', jobRoutes);
app.use('/api/applications', applicationRoutes);
app.use('/api/gamification', gamificationRoutes);
// app.use('/api/posts', postRoutes);
// app.use('/api/connections', connectionRoutes);
// app.use('/api/companies', companyRoutes);
// app.use('/api/gigs', gigRoutes);
// app.use('/api/orders', orderRoutes);
// app.use('/api/messages', messageRoutes);
// app.use('/api/streaks', streakRoutes);
// app.use('/api/notifications', notificationRoutes);
// app.use('/api/achievements', achievementRoutes);
// app.use('/api/reviews', reviewRoutes);

// Manejador de rutas no encontradas
app.use(notFoundHandler);

// Manejador de errores (debe ser el último middleware)
app.use(errorHandler);

export default app;
