import { z } from 'zod';
import { JobType, JobStatus } from './job.model';

/**
 * DTO: Crear Job
 */
export const CreateJobDTO = z.object({
  title: z.string().min(10, 'El título debe tener al menos 10 caracteres').max(100),
  description: z.string().min(50, 'La descripción debe tener al menos 50 caracteres').max(5000),
  category: z.string().min(1, 'La categoría es requerida'),
  subcategory: z.string().optional(),

  type: z.enum([JobType.FIXED_PRICE, JobType.HOURLY]),
  budget: z.number().min(0).optional(),
  hourlyRate: z
    .object({
      min: z.number().min(0),
      max: z.number().min(0),
    })
    .optional(),

  skillsRequired: z.array(z.string()).min(1, 'Se requiere al menos una habilidad'),
  experienceLevel: z.enum(['entry', 'intermediate', 'expert']).default('intermediate'),
  estimatedDuration: z.string().optional(),
  attachments: z.array(z.string().url()).optional(),

  isUrgent: z.boolean().default(false),
  deadline: z
    .string()
    .transform((str) => new Date(str))
    .optional(),
});

export type CreateJobInput = z.infer<typeof CreateJobDTO>;

/**
 * DTO: Actualizar Job
 */
export const UpdateJobDTO = z.object({
  title: z.string().min(10).max(100).optional(),
  description: z.string().min(50).max(5000).optional(),
  category: z.string().optional(),
  subcategory: z.string().optional(),

  type: z.enum([JobType.FIXED_PRICE, JobType.HOURLY]).optional(),
  budget: z.number().min(0).optional(),
  hourlyRate: z
    .object({
      min: z.number().min(0),
      max: z.number().min(0),
    })
    .optional(),

  skillsRequired: z.array(z.string()).optional(),
  experienceLevel: z.enum(['entry', 'intermediate', 'expert']).optional(),
  estimatedDuration: z.string().optional(),
  attachments: z.array(z.string().url()).optional(),

  isUrgent: z.boolean().optional(),
  deadline: z
    .string()
    .transform((str) => new Date(str))
    .optional(),
  status: z.enum(Object.values(JobStatus) as [string, ...string[]]).optional(),
});

export type UpdateJobInput = z.infer<typeof UpdateJobDTO>;

/**
 * DTO: Query parameters para listar jobs (simplificado para evitar errores de validación)
 */
export const GetJobsQueryDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  status: z.string().optional(),
  category: z.string().optional(),
  type: z.string().optional(),
  experienceLevel: z.string().optional(),
  skills: z.string().optional(),
  search: z.string().optional(),
  clientId: z.string().optional(),
  isUrgent: z.string().optional(),
  sortBy: z.string().optional().default('createdAt'),
  sortOrder: z.string().optional().default('desc'),
});

export type GetJobsQueryInput = z.infer<typeof GetJobsQueryDTO>;

/**
 * DTO: Asignar freelancer a un job
 */
export const AssignFreelancerDTO = z.object({
  freelancerId: z.string().min(1, 'El ID del freelancer es requerido'),
});

export type AssignFreelancerInput = z.infer<typeof AssignFreelancerDTO>;
