import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export class PostService {
  async getPosts(query: any) {
    const { page = 1, limit = 10, userId, type, search } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (userId) {
      where.authorId = userId;
    }

    if (type) {
      where.type = type;
    }

    if (search) {
      where.content = { contains: search, mode: 'insensitive' };
    }

    const [posts, total] = await Promise.all([
      prisma.post.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
        include: {
          author: {
            select: {
              id: true,
              email: true,
              profile: true,
            },
          },
          likes: {
            select: {
              id: true,
              userId: true,
            },
          },
          comments: {
            include: {
              author: {
                select: {
                  id: true,
                  email: true,
                  profile: true,
                },
              },
            },
            orderBy: { createdAt: 'desc' },
          },
        },
      }),
      prisma.post.count({ where }),
    ]);

    return {
      posts,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async getPostById(id: string) {
    return await prisma.post.findUnique({
      where: { id },
      include: {
        author: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
        likes: {
          select: {
            id: true,
            userId: true,
          },
        },
        comments: {
          include: {
            author: {
              select: {
                id: true,
                email: true,
                profile: true,
              },
            },
          },
          orderBy: { createdAt: 'desc' },
        },
      },
    });
  }

  async createPost(data: any) {
    return await prisma.post.create({
      data: {
        content: data.content,
        type: data.type,
        authorId: data.authorId,
        imageUrl: data.imageUrl,
        tags: data.tags,
      },
      include: {
        author: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
      },
    });
  }

  async updatePost(id: string, data: any) {
    return await prisma.post.update({
      where: { id },
      data: {
        ...data,
        updatedAt: new Date(),
      },
      include: {
        author: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
      },
    });
  }

  async deletePost(id: string) {
    try {
      await prisma.post.delete({
        where: { id },
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  async likePost(postId: string, userId: string) {
    return await prisma.postLike.create({
      data: {
        postId,
        userId,
      },
    });
  }

  async unlikePost(postId: string, userId: string) {
    try {
      await prisma.postLike.deleteMany({
        where: {
          postId,
          userId,
        },
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  async commentPost(postId: string, data: any) {
    return await prisma.postComment.create({
      data: {
        content: data.content,
        postId,
        authorId: data.authorId,
      },
      include: {
        author: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
      },
    });
  }
}

export const postService = new PostService();
