import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export class CompanyService {
  async getCompanies(query: any) {
    const { page = 1, limit = 10, search, industry, size } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (search) {
      where.OR = [
        { name: { contains: search, mode: 'insensitive' } },
        { description: { contains: search, mode: 'insensitive' } },
      ];
    }

    if (industry) {
      where.industry = industry;
    }

    if (size) {
      where.size = size;
    }

    const [companies, total] = await Promise.all([
      prisma.company.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
      }),
      prisma.company.count({ where }),
    ]);

    return {
      companies,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async getCompanyById(id: string) {
    return await prisma.company.findUnique({
      where: { id },
    });
  }

  async createCompany(data: any) {
    return await prisma.company.create({
      data: {
        name: data.name,
        tagline: data.tagline,
        description: data.description,
        industry: data.industry,
        size: data.size,
        location: data.location,
        founded: data.founded,
        website: data.website,
        logo: data.logo,
      },
    });
  }

  async updateCompany(id: string, data: any) {
    return await prisma.company.update({
      where: { id },
      data: {
        ...data,
        updatedAt: new Date(),
      },
    });
  }

  async deleteCompany(id: string) {
    try {
      await prisma.company.delete({
        where: { id },
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  async followCompany(companyId: string, userId: string) {
    return await prisma.companyFollow.create({
      data: {
        companyId,
        userId,
      },
    });
  }

  async unfollowCompany(companyId: string, userId: string) {
    try {
      await prisma.companyFollow.deleteMany({
        where: {
          companyId,
          userId,
        },
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  async getCompanyFollowers(companyId: string, query: any) {
    const { page = 1, limit = 10 } = query;
    const skip = (page - 1) * limit;

    const [followers, total] = await Promise.all([
      prisma.companyFollow.findMany({
        where: { companyId },
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
        include: {
          company: {
            select: {
              id: true,
              name: true,
              logo: true,
            },
          },
        },
      }),
      prisma.companyFollow.count({ where: { companyId } }),
    ]);

    return {
      followers,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async getCompanyJobs(companyId: string, query: any) {
    const { page = 1, limit = 10 } = query;
    const skip = (page - 1) * limit;

    const [jobs, total] = await Promise.all([
      prisma.job.findMany({
        where: { clientId: companyId },
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
      }),
      prisma.job.count({ where: { clientId: companyId } }),
    ]);

    return {
      jobs,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async getCompanyReviews(_companyId: string, _query: any) {
    // Placeholder - implementar cuando se agregue el modelo de reviews
    return {
      reviews: [],
      pagination: {
        page: 1,
        limit: 10,
        total: 0,
        pages: 0,
      },
    };
  }

  async createCompanyReview(companyId: string, data: any) {
    // Placeholder - implementar cuando se agregue el modelo de reviews
    return {
      id: 'review-placeholder',
      companyId,
      ...data,
      createdAt: new Date(),
    };
  }

  async searchCompanies(searchData: any) {
    const { query, filters = {}, page = 1, limit = 10 } = searchData;
    const skip = (page - 1) * limit;

    const where: any = {
      OR: [
        { name: { contains: query, mode: 'insensitive' } },
        { description: { contains: query, mode: 'insensitive' } },
        { tagline: { contains: query, mode: 'insensitive' } },
      ],
    };

    if (filters.industry) {
      where.industry = filters.industry;
    }
    if (filters.size) {
      where.size = filters.size;
    }
    if (filters.location) {
      where.location = { contains: filters.location, mode: 'insensitive' };
    }

    const [companies, total] = await Promise.all([
      prisma.company.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
      }),
      prisma.company.count({ where }),
    ]);

    return {
      companies,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }
}

export const companyService = new CompanyService();
