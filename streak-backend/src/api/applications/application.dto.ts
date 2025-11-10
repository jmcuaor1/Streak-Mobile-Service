import { z } from 'zod';
import { ApplicationStatus } from './application.model';

/**
 * DTO: Crear Application
 */
export const CreateApplicationDTO = z.object({
  jobId: z.string().min(1, 'El ID del trabajo es requerido'),
  coverLetter: z
    .string()
    .min(50, 'La carta debe tener al menos 50 caracteres')
    .max(2000, 'La carta no puede exceder 2000 caracteres'),
  proposedRate: z.number().min(0).optional(),
  proposedDuration: z.string().optional(),
  portfolio: z.array(z.string().url()).optional(),
});

export type CreateApplicationInput = z.infer<typeof CreateApplicationDTO>;

/**
 * DTO: Actualizar Application
 */
export const UpdateApplicationDTO = z.object({
  coverLetter: z.string().min(50).max(2000).optional(),
  proposedRate: z.number().min(0).optional(),
  proposedDuration: z.string().optional(),
  portfolio: z.array(z.string().url()).optional(),
});

export type UpdateApplicationInput = z.infer<typeof UpdateApplicationDTO>;

/**
 * DTO: Query parameters para listar applications
 */
export const GetApplicationsQueryDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),

  status: z.enum(Object.values(ApplicationStatus) as [string, ...string[]]).optional(),
  jobId: z.string().optional(),
  freelancerId: z.string().optional(),

  sortBy: z.string().optional().default('createdAt'),
  sortOrder: z.enum(['asc', 'desc']).optional().default('desc'),
});

export type GetApplicationsQueryInput = z.infer<typeof GetApplicationsQueryDTO>;
