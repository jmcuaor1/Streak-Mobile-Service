import { z } from 'zod';
import { UserRole } from './user.model';

/**
 * DTO: Actualizar perfil de usuario
 */
export const UpdateProfileDTO = z.object({
  firstName: z.string().min(2).max(50).optional(),
  lastName: z.string().min(2).max(50).optional(),
  avatar: z.string().url().optional().or(z.literal('')),
  bio: z.string().max(500).optional(),
  location: z.string().optional(),
  phone: z.string().optional(),
});

export type UpdateProfileInput = z.infer<typeof UpdateProfileDTO>;

/**
 * DTO: Actualizar perfil de freelancer
 */
export const UpdateFreelancerProfileDTO = z.object({
  title: z.string().max(100).optional(),
  hourlyRate: z.number().min(0).optional(),
  skills: z.array(z.string()).optional(),
  portfolio: z.array(z.string().url()).optional(),
  experience: z.string().optional(),
  education: z.string().optional(),
  languages: z.array(z.string()).optional(),
  availability: z.enum(['available', 'busy', 'unavailable']).optional(),
});

export type UpdateFreelancerProfileInput = z.infer<typeof UpdateFreelancerProfileDTO>;

/**
 * DTO: Actualizar preferencias
 */
export const UpdatePreferencesDTO = z.object({
  emailNotifications: z.boolean().optional(),
  pushNotifications: z.boolean().optional(),
  language: z.string().optional(),
  timezone: z.string().optional(),
});

export type UpdatePreferencesInput = z.infer<typeof UpdatePreferencesDTO>;

/**
 * DTO: Query parameters para listar usuarios
 */
export const GetUsersQueryDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  role: z.enum([UserRole.CLIENT, UserRole.FREELANCER, UserRole.ADMIN]).optional(),
  search: z.string().optional(),
  sortBy: z.string().optional().default('createdAt'),
  sortOrder: z.enum(['asc', 'desc']).optional().default('desc'),
});

export type GetUsersQueryInput = z.infer<typeof GetUsersQueryDTO>;
