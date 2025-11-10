import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export class ConnectionService {
  async getConnections(query: any) {
    const { page = 1, limit = 10, userId, status } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (userId) {
      where.OR = [{ requesterId: userId }, { receiverId: userId }];
    }

    if (status) {
      where.status = status;
    }

    const [connections, total] = await Promise.all([
      prisma.connection.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
        include: {
          requester: {
            select: {
              id: true,
              email: true,
              profile: true,
            },
          },
          receiver: {
            select: {
              id: true,
              email: true,
              profile: true,
            },
          },
        },
      }),
      prisma.connection.count({ where }),
    ]);

    return {
      connections,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async getConnectionById(id: string) {
    return await prisma.connection.findUnique({
      where: { id },
      include: {
        requester: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
        receiver: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
      },
    });
  }

  async sendConnectionRequest(data: any) {
    return await prisma.connection.create({
      data: {
        requesterId: data.requesterId,
        receiverId: data.targetUserId,
        status: 'pending',
        message: data.message,
      },
      include: {
        requester: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
        receiver: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
      },
    });
  }

  async acceptConnection(id: string) {
    return await prisma.connection.update({
      where: { id },
      data: {
        status: 'accepted',
        updatedAt: new Date(),
      },
      include: {
        requester: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
        receiver: {
          select: {
            id: true,
            email: true,
            profile: true,
          },
        },
      },
    });
  }

  async rejectConnection(id: string) {
    try {
      await prisma.connection.delete({
        where: { id },
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  async removeConnection(id: string) {
    try {
      await prisma.connection.delete({
        where: { id },
      });
      return true;
    } catch (error) {
      return false;
    }
  }
}

export const connectionService = new ConnectionService();
