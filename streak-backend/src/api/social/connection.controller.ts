import { Request, Response } from 'express';
import { connectionService } from './connection.service';

export class ConnectionController {
  async getConnections(req: Request, res: Response) {
    try {
      const connections = await connectionService.getConnections(req.query);
      res.json({
        success: true,
        data: connections,
        message: 'Connections retrieved successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving connections',
          details: { stack: error },
        },
      });
    }
  }

  async getConnectionById(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const connection = await connectionService.getConnectionById(id);

      if (!connection) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Connection not found',
          },
        });
      }

      return res.json({
        success: true,
        data: connection,
        message: 'Connection retrieved successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving connection',
          details: { stack: error },
        },
      });
    }
  }

  async sendConnectionRequest(req: Request, res: Response) {
    try {
      const connectionData = req.body;
      const connection = await connectionService.sendConnectionRequest(connectionData);

      res.status(201).json({
        success: true,
        data: connection,
        message: 'Connection request sent successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error sending connection request',
          details: { stack: error },
        },
      });
    }
  }

  async acceptConnection(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const connection = await connectionService.acceptConnection(id);

      if (!connection) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Connection not found',
          },
        });
      }

      return res.json({
        success: true,
        data: connection,
        message: 'Connection accepted successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error accepting connection',
          details: { stack: error },
        },
      });
    }
  }

  async rejectConnection(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const deleted = await connectionService.rejectConnection(id);

      if (!deleted) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Connection not found',
          },
        });
      }

      return res.json({
        success: true,
        message: 'Connection rejected successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error rejecting connection',
          details: { stack: error },
        },
      });
    }
  }

  async removeConnection(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const deleted = await connectionService.removeConnection(id);

      if (!deleted) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Connection not found',
          },
        });
      }

      return res.json({
        success: true,
        message: 'Connection removed successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error removing connection',
          details: { stack: error },
        },
      });
    }
  }
}

export const connectionController = new ConnectionController();
