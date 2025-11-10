import { z } from 'zod';

/**
 * DTO: Enviar solicitud de conexión
 */
export const SendConnectionRequestDTO = z.object({
  targetUserId: z.string().min(1),
  message: z.string().max(500).optional(),
});

export type SendConnectionRequestInput = z.infer<typeof SendConnectionRequestDTO>;

/**
 * DTO: Aceptar conexión
 */
export const AcceptConnectionDTO = z.object({
  connectionId: z.string().min(1),
});

export type AcceptConnectionInput = z.infer<typeof AcceptConnectionDTO>;

/**
 * DTO: Rechazar conexión
 */
export const RejectConnectionDTO = z.object({
  connectionId: z.string().min(1),
});

export type RejectConnectionInput = z.infer<typeof RejectConnectionDTO>;

/**
 * DTO: Eliminar conexión
 */
export const RemoveConnectionDTO = z.object({
  connectionId: z.string().min(1),
});

export type RemoveConnectionInput = z.infer<typeof RemoveConnectionDTO>;

/**
 * DTO: Query parameters para listar conexiones
 */
export const GetConnectionsQueryDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  userId: z.string().optional(),
  status: z.enum(['pending', 'accepted', 'rejected']).optional(),
  sortBy: z.string().optional().default('createdAt'),
  sortOrder: z.enum(['asc', 'desc']).optional().default('desc'),
});

export type GetConnectionsQueryInput = z.infer<typeof GetConnectionsQueryDTO>;

/**
 * DTO: Obtener solicitudes de conexión
 */
export const GetConnectionRequestsDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  userId: z.string().min(1),
});

export type GetConnectionRequestsInput = z.infer<typeof GetConnectionRequestsDTO>;

/**
 * DTO: Sugerencias de conexión
 */
export const GetConnectionSuggestionsDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  userId: z.string().min(1),
});

export type GetConnectionSuggestionsInput = z.infer<typeof GetConnectionSuggestionsDTO>;

/**
 * DTO: Conexiones mutuas
 */
export const GetMutualConnectionsDTO = z.object({
  userId1: z.string().min(1),
  userId2: z.string().min(1),
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
});

export type GetMutualConnectionsInput = z.infer<typeof GetMutualConnectionsDTO>;
