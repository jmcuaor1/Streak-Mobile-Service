import { z } from 'zod';

/**
 * DTO: Crear empresa
 */
export const CreateCompanyDTO = z.object({
  name: z.string().min(2).max(100),
  tagline: z.string().min(5).max(200).optional(),
  description: z.string().min(10).max(1000).optional(),
  website: z.string().url().optional().or(z.literal('')),
  industry: z.string().min(2).max(50).optional(),
  size: z.string().min(2).max(50).optional(),
  location: z.string().min(2).max(100).optional(),
  founded: z.string().optional(),
  logo: z.string().url().optional().or(z.literal('')),
  coverImage: z.string().url().optional().or(z.literal('')),
  isVerified: z.boolean().optional(),
});

export type CreateCompanyInput = z.infer<typeof CreateCompanyDTO>;

/**
 * DTO: Actualizar empresa
 */
export const UpdateCompanyDTO = z.object({
  name: z.string().min(2).max(100).optional(),
  tagline: z.string().min(5).max(200).optional(),
  description: z.string().min(10).max(1000).optional(),
  website: z.string().url().optional().or(z.literal('')),
  industry: z.string().min(2).max(50).optional(),
  size: z.string().min(2).max(50).optional(),
  location: z.string().min(2).max(100).optional(),
  founded: z.string().optional(),
  logo: z.string().url().optional().or(z.literal('')),
  coverImage: z.string().url().optional().or(z.literal('')),
  isVerified: z.boolean().optional(),
});

export type UpdateCompanyInput = z.infer<typeof UpdateCompanyDTO>;

/**
 * DTO: Query parameters para listar empresas
 */
export const GetCompaniesQueryDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  search: z.string().optional(),
  industry: z.string().optional(),
  size: z.string().optional(),
  location: z.string().optional(),
  sortBy: z.string().optional().default('createdAt'),
  sortOrder: z.enum(['asc', 'desc']).optional().default('desc'),
});

export type GetCompaniesQueryInput = z.infer<typeof GetCompaniesQueryDTO>;

/**
 * DTO: Seguir empresa
 */
export const FollowCompanyDTO = z.object({
  userId: z.string().min(1),
});

export type FollowCompanyInput = z.infer<typeof FollowCompanyDTO>;

/**
 * DTO: Dejar de seguir empresa
 */
export const UnfollowCompanyDTO = z.object({
  userId: z.string().min(1),
});

export type UnfollowCompanyInput = z.infer<typeof UnfollowCompanyDTO>;

/**
 * DTO: Buscar empresas
 */
export const SearchCompaniesDTO = z.object({
  query: z.string().min(1),
  filters: z
    .object({
      industry: z.string().optional(),
      size: z.string().optional(),
      location: z.string().optional(),
    })
    .optional(),
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
});

export type SearchCompaniesInput = z.infer<typeof SearchCompaniesDTO>;
