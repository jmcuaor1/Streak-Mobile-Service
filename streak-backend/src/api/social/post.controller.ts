import { Request, Response } from 'express';
import { postService } from './post.service';

export class PostController {
  async getPosts(req: Request, res: Response) {
    try {
      const posts = await postService.getPosts(req.query);
      res.json({
        success: true,
        data: posts,
        message: 'Posts retrieved successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving posts',
          details: { stack: error },
        },
      });
    }
  }

  async getPostById(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const post = await postService.getPostById(id);

      if (!post) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Post not found',
          },
        });
      }

      return res.json({
        success: true,
        data: post,
        message: 'Post retrieved successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving post',
          details: { stack: error },
        },
      });
    }
  }

  async createPost(req: Request, res: Response) {
    try {
      const postData = req.body;
      const post = await postService.createPost(postData);

      res.status(201).json({
        success: true,
        data: post,
        message: 'Post created successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error creating post',
          details: { stack: error },
        },
      });
    }
  }

  async updatePost(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const updateData = req.body;
      const post = await postService.updatePost(id, updateData);

      if (!post) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Post not found',
          },
        });
      }

      return res.json({
        success: true,
        data: post,
        message: 'Post updated successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error updating post',
          details: { stack: error },
        },
      });
    }
  }

  async deletePost(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const deleted = await postService.deletePost(id);

      if (!deleted) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Post not found',
          },
        });
      }

      return res.json({
        success: true,
        message: 'Post deleted successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error deleting post',
          details: { stack: error },
        },
      });
    }
  }

  async likePost(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const { userId } = req.body;
      const result = await postService.likePost(id, userId);

      res.json({
        success: true,
        data: result,
        message: 'Post liked successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error liking post',
          details: { stack: error },
        },
      });
    }
  }

  async unlikePost(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const { userId } = req.body;
      const result = await postService.unlikePost(id, userId);

      res.json({
        success: true,
        data: result,
        message: 'Post unliked successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error unliking post',
          details: { stack: error },
        },
      });
    }
  }

  async commentPost(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const commentData = req.body;
      const comment = await postService.commentPost(id, commentData);

      res.json({
        success: true,
        data: comment,
        message: 'Comment added successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error adding comment',
          details: { stack: error },
        },
      });
    }
  }
}

export const postController = new PostController();
