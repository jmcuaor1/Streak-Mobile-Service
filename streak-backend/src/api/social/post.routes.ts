import { Router } from 'express';
import { postController } from './post.controller';
import { validateRequest } from '../../core/middlewares/validateRequest';
import { authenticate, authorizeOwnerOrAdmin } from '../../core/middlewares/auth.middleware';
import {
  CreatePostDTO,
  UpdatePostDTO,
  GetPostsQueryDTO,
  LikePostDTO,
  CommentPostDTO,
} from './post.dto';

const router = Router();

/**
 * @route   GET /api/posts
 * @desc    Obtener posts con filtros y paginación
 * @access  Public
 */
router.get(
  '/',
  authenticate,
  validateRequest(GetPostsQueryDTO, 'query'),
  postController.getPosts.bind(postController)
);

/**
 * @route   POST /api/posts
 * @desc    Crear nuevo post
 * @access  Private
 */
router.post(
  '/',
  authenticate,
  validateRequest(CreatePostDTO),
  postController.createPost.bind(postController)
);

/**
 * @route   GET /api/posts/:id
 * @desc    Obtener post por ID
 * @access  Public
 */
router.get('/:id', authenticate, postController.getPostById.bind(postController));

/**
 * @route   PUT /api/posts/:id
 * @desc    Actualizar post
 * @access  Private (Owner)
 */
router.put(
  '/:id',
  authenticate,
  authorizeOwnerOrAdmin('authorId'),
  validateRequest(UpdatePostDTO),
  postController.updatePost.bind(postController)
);

/**
 * @route   DELETE /api/posts/:id
 * @desc    Eliminar post
 * @access  Private (Owner)
 */
router.delete(
  '/:id',
  authenticate,
  authorizeOwnerOrAdmin('authorId'),
  postController.deletePost.bind(postController)
);

/**
 * @route   POST /api/posts/:id/like
 * @desc    Dar like a un post
 * @access  Private
 */
router.post(
  '/:id/like',
  authenticate,
  validateRequest(LikePostDTO),
  postController.likePost.bind(postController)
);

/**
 * @route   DELETE /api/posts/:id/like
 * @desc    Quitar like de un post
 * @access  Private
 */
router.delete('/:id/like', authenticate, postController.unlikePost.bind(postController));

/**
 * @route   POST /api/posts/:id/comment
 * @desc    Comentar en un post
 * @access  Private
 */
router.post(
  '/:id/comment',
  authenticate,
  validateRequest(CommentPostDTO),
  postController.commentPost.bind(postController)
);

/**
 * @route   GET /api/posts/:id/comments
 * @desc    Obtener comentarios de un post
 * @access  Public
 */
// router.get('/:id/comments', authenticate, postController.getPostComments.bind(postController));

/**
 * @route   DELETE /api/posts/:id/comments/:commentId
 * @desc    Eliminar comentario
 * @access  Private (Owner)
 */
// router.delete(
//   '/:id/comments/:commentId',
//   authenticate,
//   authorizeOwnerOrAdmin('authorId'),
//   postController.deleteComment.bind(postController)
// );

/**
 * @route   POST /api/posts/:id/share
 * @desc    Compartir post
 * @access  Private
 */
// router.post('/:id/share', authenticate, postController.sharePost.bind(postController));

export default router;
