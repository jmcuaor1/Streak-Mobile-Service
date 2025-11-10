import { Request, Response, NextFunction } from 'express';
import { userService } from './user.service';
import { sendSuccess, sendPaginated } from '../../core/utils/response.utils';
import {
  UpdateProfileInput,
  UpdateFreelancerProfileInput,
  UpdatePreferencesInput,
  GetUsersQueryInput,
} from './user.dto';

/**
 * Controlador de Usuarios
 */
export class UserController {
  /**
   * @route   GET /api/users
   * @desc    Listar usuarios con filtros y paginación
   * @access  Private (Admin)
   */
  async getUsers(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const query: GetUsersQueryInput = req.query as unknown as GetUsersQueryInput;

      const result = await userService.getUsers(query);

      sendPaginated(res, {
        message: 'Usuarios obtenidos exitosamente',
        data: result.users,
        pagination: {
          page: result.page,
          limit: result.limit,
          total: result.total,
          totalPages: result.totalPages,
        },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/users/:id
   * @desc    Obtener usuario por ID
   * @access  Private
   */
  async getUserById(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;

      const user = await userService.getUserById(id);

      sendSuccess(res, {
        message: 'Usuario obtenido exitosamente',
        data: { user },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   PUT /api/users/:id/profile
   * @desc    Actualizar perfil de usuario
   * @access  Private (Owner or Admin)
   */
  async updateProfile(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const data: UpdateProfileInput = req.body;

      const user = await userService.updateProfile(id, data);

      sendSuccess(res, {
        message: 'Perfil actualizado exitosamente',
        data: { user },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   PUT /api/users/:id/freelancer-profile
   * @desc    Actualizar perfil de freelancer
   * @access  Private (Owner)
   */
  async updateFreelancerProfile(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const data: UpdateFreelancerProfileInput = req.body;

      const user = await userService.updateFreelancerProfile(id, data);

      sendSuccess(res, {
        message: 'Perfil de freelancer actualizado exitosamente',
        data: { user },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   PUT /api/users/:id/preferences
   * @desc    Actualizar preferencias de usuario
   * @access  Private (Owner)
   */
  async updatePreferences(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const data: UpdatePreferencesInput = req.body;

      const user = await userService.updatePreferences(id, data);

      sendSuccess(res, {
        message: 'Preferencias actualizadas exitosamente',
        data: { user },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   DELETE /api/users/:id
   * @desc    Eliminar usuario (soft delete)
   * @access  Private (Owner or Admin)
   */
  async deleteUser(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;

      await userService.deleteUser(id);

      sendSuccess(res, {
        message: 'Usuario eliminado exitosamente',
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * @route   GET /api/users/freelancers/search
   * @desc    Buscar freelancers por habilidades
   * @access  Public
   */
  async searchFreelancers(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { skills, minRating, availability } = req.query;

      const skillsArray = skills ? (skills as string).split(',') : undefined;
      const rating = minRating ? Number(minRating) : 0;

      const freelancers = await userService.searchFreelancers(
        skillsArray,
        rating,
        availability as string | undefined
      );

      sendSuccess(res, {
        message: 'Freelancers encontrados',
        data: { freelancers },
      });
    } catch (error) {
      next(error);
    }
  }
}

export const userController = new UserController();
