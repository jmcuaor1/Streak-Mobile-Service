import { Request, Response } from 'express';
import { companyService } from './company.service';

export class CompanyController {
  async getCompanies(req: Request, res: Response) {
    try {
      const companies = await companyService.getCompanies(req.query);
      res.json({
        success: true,
        data: companies,
        message: 'Companies retrieved successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving companies',
          details: { stack: error },
        },
      });
    }
  }

  async getCompanyById(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const company = await companyService.getCompanyById(id);

      if (!company) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Company not found',
          },
        });
      }

      return res.json({
        success: true,
        data: company,
        message: 'Company retrieved successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving company',
          details: { stack: error },
        },
      });
    }
  }

  async createCompany(req: Request, res: Response) {
    try {
      const companyData = req.body;
      const company = await companyService.createCompany(companyData);

      res.status(201).json({
        success: true,
        data: company,
        message: 'Company created successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error creating company',
          details: { stack: error },
        },
      });
    }
  }

  async updateCompany(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const updateData = req.body;
      const company = await companyService.updateCompany(id, updateData);

      if (!company) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Company not found',
          },
        });
      }

      return res.json({
        success: true,
        data: company,
        message: 'Company updated successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error updating company',
          details: { stack: error },
        },
      });
    }
  }

  async deleteCompany(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const deleted = await companyService.deleteCompany(id);

      if (!deleted) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'NOT_FOUND',
            message: 'Company not found',
          },
        });
      }

      return res.json({
        success: true,
        message: 'Company deleted successfully',
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error deleting company',
          details: { stack: error },
        },
      });
    }
  }

  async followCompany(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const { userId } = req.body;
      const result = await companyService.followCompany(id, userId);

      res.json({
        success: true,
        data: result,
        message: 'Company followed successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error following company',
          details: { stack: error },
        },
      });
    }
  }

  async unfollowCompany(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const { userId } = req.body;
      const result = await companyService.unfollowCompany(id, userId);

      res.json({
        success: true,
        data: result,
        message: 'Company unfollowed successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error unfollowing company',
          details: { stack: error },
        },
      });
    }
  }

  async getCompanyFollowers(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const followers = await companyService.getCompanyFollowers(id, req.query);

      res.json({
        success: true,
        data: followers,
        message: 'Company followers retrieved successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving company followers',
          details: { stack: error },
        },
      });
    }
  }

  async getCompanyJobs(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const jobs = await companyService.getCompanyJobs(id, req.query);

      res.json({
        success: true,
        data: jobs,
        message: 'Company jobs retrieved successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving company jobs',
          details: { stack: error },
        },
      });
    }
  }

  async getCompanyReviews(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const reviews = await companyService.getCompanyReviews(id, req.query);

      res.json({
        success: true,
        data: reviews,
        message: 'Company reviews retrieved successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error retrieving company reviews',
          details: { stack: error },
        },
      });
    }
  }

  async createCompanyReview(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const reviewData = req.body;
      const review = await companyService.createCompanyReview(id, reviewData);

      res.status(201).json({
        success: true,
        data: review,
        message: 'Company review created successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error creating company review',
          details: { stack: error },
        },
      });
    }
  }

  async searchCompanies(req: Request, res: Response) {
    try {
      const searchData = req.body;
      const results = await companyService.searchCompanies(searchData);

      res.json({
        success: true,
        data: results,
        message: 'Companies search completed successfully',
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: {
          code: 'INTERNAL_ERROR',
          message: 'Error searching companies',
          details: { stack: error },
        },
      });
    }
  }
}

export const companyController = new CompanyController();
