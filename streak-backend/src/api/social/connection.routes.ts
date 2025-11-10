import { Router } from 'express';
import { connectionController } from './connection.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import { authenticate } from '../../core/middlewares/auth.middleware';
import {
  SendConnectionRequestDTO,
  AcceptConnectionDTO,
  GetConnectionsQueryDTO,
} from './connection.dto';

const router = Router();

/**
 * @route   GET /api/connections
 * @desc    Obtener conexiones del usuario
 * @access  Private
 */
router.get(
  '/',
  authenticate,
  validateRequest(GetConnectionsQueryDTO, 'query'),
  connectionController.getConnections.bind(connectionController)
);

/**
 * @route   GET /api/connections/requests
 * @desc    Obtener solicitudes de conexión pendientes
 * @access  Private
 */
// router.get(
//   '/requests',
//   authenticate,
//   connectionController.getConnectionRequests.bind(connectionController)
// );

/**
 * @route   POST /api/connections/request
 * @desc    Enviar solicitud de conexión
 * @access  Private
 */
router.post(
  '/request',
  authenticate,
  validateRequest(SendConnectionRequestDTO),
  connectionController.sendConnectionRequest.bind(connectionController)
);

/**
 * @route   POST /api/connections/:id/accept
 * @desc    Aceptar solicitud de conexión
 * @access  Private
 */
router.post(
  '/:id/accept',
  authenticate,
  validateRequest(AcceptConnectionDTO),
  connectionController.acceptConnection.bind(connectionController)
);

/**
 * @route   POST /api/connections/:id/reject
 * @desc    Rechazar solicitud de conexión
 * @access  Private
 */
router.post(
  '/:id/reject',
  authenticate,
  connectionController.rejectConnection.bind(connectionController)
);

/**
 * @route   DELETE /api/connections/:id
 * @desc    Eliminar conexión
 * @access  Private
 */
router.delete(
  '/:id',
  authenticate,
  connectionController.removeConnection.bind(connectionController)
);

/**
 * @route   GET /api/connections/suggestions
 * @desc    Obtener sugerencias de conexiones
 * @access  Private
 */
// router.get(
//   '/suggestions',
//   authenticate,
//   connectionController.getConnectionSuggestions.bind(connectionController)
// );

/**
 * @route   GET /api/connections/mutual/:userId
 * @desc    Obtener conexiones mutuas con otro usuario
 * @access  Private
 */
// router.get(
//   '/mutual/:userId',
//   authenticate,
//   connectionController.getMutualConnections.bind(connectionController)
// );

export default router;
