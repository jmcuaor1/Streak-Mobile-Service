import { z } from 'zod';

/**
 * DTO: Crear post
 */
export const CreatePostDTO = z.object({
  content: z.string().min(1).max(2000),
  type: z.enum(['text', 'image', 'video']).optional().default('text'),
  imageUrl: z.string().url().optional().or(z.literal('')),
  tags: z.array(z.string()).optional().default([]),
  authorId: z.string().min(1),
});

export type CreatePostInput = z.infer<typeof CreatePostDTO>;

/**
 * DTO: Actualizar post
 */
export const UpdatePostDTO = z.object({
  content: z.string().min(1).max(2000).optional(),
  type: z.enum(['text', 'image', 'video']).optional(),
  imageUrl: z.string().url().optional().or(z.literal('')),
  tags: z.array(z.string()).optional(),
});

export type UpdatePostInput = z.infer<typeof UpdatePostDTO>;

/**
 * DTO: Dar like a post
 */
export const LikePostDTO = z.object({
  userId: z.string().min(1),
});

export type LikePostInput = z.infer<typeof LikePostDTO>;

/**
 * DTO: Quitar like de post
 */
export const UnlikePostDTO = z.object({
  userId: z.string().min(1),
});

export type UnlikePostInput = z.infer<typeof UnlikePostDTO>;

/**
 * DTO: Comentar post
 */
export const CommentPostDTO = z.object({
  content: z.string().min(1).max(500),
  authorId: z.string().min(1),
});

export type CommentPostInput = z.infer<typeof CommentPostDTO>;

/**
 * DTO: Query parameters para listar posts
 */
export const GetPostsQueryDTO = z.object({
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
  userId: z.string().optional(),
  type: z.enum(['text', 'image', 'video']).optional(),
  search: z.string().optional(),
  sortBy: z.string().optional().default('createdAt'),
  sortOrder: z.enum(['asc', 'desc']).optional().default('desc'),
});

export type GetPostsQueryInput = z.infer<typeof GetPostsQueryDTO>;

/**
 * DTO: Obtener comentarios de post
 */
export const GetPostCommentsDTO = z.object({
  postId: z.string().min(1),
  page: z.string().optional().default('1').transform(Number),
  limit: z.string().optional().default('10').transform(Number),
});

export type GetPostCommentsInput = z.infer<typeof GetPostCommentsDTO>;

/**
 * DTO: Eliminar comentario
 */
export const DeleteCommentDTO = z.object({
  commentId: z.string().min(1),
});

export type DeleteCommentInput = z.infer<typeof DeleteCommentDTO>;

/**
 * DTO: Compartir post
 */
export const SharePostDTO = z.object({
  postId: z.string().min(1),
  userId: z.string().min(1),
  message: z.string().max(500).optional(),
});

export type SharePostInput = z.infer<typeof SharePostDTO>;
