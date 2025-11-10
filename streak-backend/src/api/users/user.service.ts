import { User, IUser, AccountStatus } from './user.model';
import {
  UpdateProfileInput,
  UpdateFreelancerProfileInput,
  UpdatePreferencesInput,
  GetUsersQueryInput,
} from './user.dto';
import { NotFoundError, ForbiddenError } from '../../core/middlewares/errorHandler';

/**
 * Servicio de Usuarios
 */
export class UserService {
  /**
   * Obtener usuario por ID
   */
  async getUserById(userId: string): Promise<IUser> {
    const user = await User.findById(userId).populate('gamification.achievements');

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    return user;
  }

  /**
   * Listar usuarios con filtros y paginación
   */
  async getUsers(query: GetUsersQueryInput) {
    const { page, limit, role, search, sortBy, sortOrder } = query;

    // Construir filtros
    const filter: Record<string, unknown> = {};

    if (role) {
      filter.role = role;
    }

    if (search) {
      filter.$or = [
        { 'profile.firstName': { $regex: search, $options: 'i' } },
        { 'profile.lastName': { $regex: search, $options: 'i' } },
        { email: { $regex: search, $options: 'i' } },
      ];
    }

    // Calcular skip
    const skip = (Number(page) - 1) * Number(limit);

    // Ordenamiento
    const sort: Record<string, 1 | -1> = {
      [sortBy]: sortOrder === 'asc' ? 1 : -1,
    };

    // Ejecutar query
    const [users, total] = await Promise.all([
      User.find(filter)
        .sort(sort)
        .skip(skip)
        .limit(Number(limit))
        .populate('gamification.achievements'),
      User.countDocuments(filter),
    ]);

    return {
      users,
      total,
      page: Number(page),
      limit: Number(limit),
      totalPages: Math.ceil(total / Number(limit)),
    };
  }

  /**
   * Actualizar perfil de usuario
   */
  async updateProfile(userId: string, data: UpdateProfileInput): Promise<IUser> {
    const user = await User.findById(userId);

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Actualizar campos del perfil
    if (data.firstName) user.profile.firstName = data.firstName;
    if (data.lastName) user.profile.lastName = data.lastName;
    if (data.avatar !== undefined) user.profile.avatar = data.avatar;
    if (data.bio !== undefined) user.profile.bio = data.bio;
    if (data.location !== undefined) user.profile.location = data.location;
    if (data.phone !== undefined) user.profile.phone = data.phone;

    await user.save();

    return user;
  }

  /**
   * Actualizar perfil de freelancer
   */
  async updateFreelancerProfile(
    userId: string,
    data: UpdateFreelancerProfileInput
  ): Promise<IUser> {
    const user = await User.findById(userId);

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Verificar que el usuario sea freelancer
    if (user.role !== 'freelancer') {
      throw new ForbiddenError('Solo los freelancers pueden actualizar este perfil');
    }

    // Inicializar freelancerProfile si no existe
    if (!user.freelancerProfile) {
      user.freelancerProfile = {
        skills: [],
        portfolio: [],
        languages: [],
        availability: 'available',
      };
    }

    // Actualizar campos
    if (data.title !== undefined) user.freelancerProfile.title = data.title;
    if (data.hourlyRate !== undefined) user.freelancerProfile.hourlyRate = data.hourlyRate;
    if (data.skills !== undefined) user.freelancerProfile.skills = data.skills;
    if (data.portfolio !== undefined) user.freelancerProfile.portfolio = data.portfolio;
    if (data.experience !== undefined) user.freelancerProfile.experience = data.experience;
    if (data.education !== undefined) user.freelancerProfile.education = data.education;
    if (data.languages !== undefined) user.freelancerProfile.languages = data.languages;
    if (data.availability !== undefined) user.freelancerProfile.availability = data.availability;

    await user.save();

    return user;
  }

  /**
   * Actualizar preferencias
   */
  async updatePreferences(userId: string, data: UpdatePreferencesInput): Promise<IUser> {
    const user = await User.findById(userId);

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    // Actualizar preferencias
    if (data.emailNotifications !== undefined) {
      user.preferences.emailNotifications = data.emailNotifications;
    }
    if (data.pushNotifications !== undefined) {
      user.preferences.pushNotifications = data.pushNotifications;
    }
    if (data.language !== undefined) {
      user.preferences.language = data.language;
    }
    if (data.timezone !== undefined) {
      user.preferences.timezone = data.timezone;
    }

    await user.save();

    return user;
  }

  /**
   * Eliminar usuario (soft delete)
   */
  async deleteUser(userId: string): Promise<void> {
    const user = await User.findById(userId);

    if (!user) {
      throw new NotFoundError('Usuario no encontrado');
    }

    user.accountStatus = AccountStatus.DELETED;
    await user.save();
  }

  /**
   * Buscar freelancers por habilidades
   */
  async searchFreelancers(skills?: string[], minRating = 0, availability?: string) {
    const filter: Record<string, unknown> = {
      role: 'freelancer',
      'stats.rating': { $gte: minRating },
    };

    if (skills && skills.length > 0) {
      filter['freelancerProfile.skills'] = { $in: skills };
    }

    if (availability) {
      filter['freelancerProfile.availability'] = availability;
    }

    const freelancers = await User.find(filter).sort({ 'stats.rating': -1 }).limit(20);

    return freelancers;
  }
}

export const userService = new UserService();
