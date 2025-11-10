import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/company_model.dart';

class CompanyNotifier extends Notifier<List<CompanyModel>> {
  @override
  List<CompanyModel> build() {
    return _loadMockCompanies();
  }

  List<CompanyModel> _loadMockCompanies() {
    return [
      CompanyModel(
        id: '1',
        name: 'TechCorp Solutions',
        tagline: 'Innovación tecnológica para el futuro',
        description: 'Somos una empresa líder en desarrollo de software y soluciones tecnológicas. Con más de 10 años de experiencia, ayudamos a empresas a digitalizar sus procesos y mejorar su eficiencia.',
        website: 'https://techcorp.com',
        industry: 'Tecnología',
        size: '50-200 empleados',
        location: 'Bogotá, Colombia',
        founded: '2013',
        isVerified: true,
        followersCount: 1250,
        jobsCount: 45,
        rating: 4.8,
        reviewsCount: 89,
        benefits: [
          'Seguro médico completo',
          'Horario flexible',
          'Trabajo remoto',
          'Bonos por rendimiento',
          'Capacitación continua',
        ],
        technologies: [
          'Flutter',
          'React',
          'Node.js',
          'Python',
          'AWS',
          'Docker',
        ],
        locations: [
          'Bogotá, Colombia',
          'Medellín, Colombia',
          'Remoto',
        ],
        recentJobs: [
          CompanyJob(
            id: '1',
            title: 'Desarrollador Full Stack Senior',
            type: 'full_time',
            location: 'Bogotá, Colombia',
            salary: '\$3.000.000 - \$4.500.000',
            posted: '2 días',
            isUrgent: false,
            skills: ['Flutter', 'React', 'Node.js'],
          ),
          CompanyJob(
            id: '2',
            title: 'Product Manager',
            type: 'full_time',
            location: 'Remoto',
            salary: '\$4.000.000 - \$6.000.000',
            posted: '5 días',
            isUrgent: true,
            skills: ['Product Management', 'Agile', 'Analytics'],
          ),
          CompanyJob(
            id: '3',
            title: 'UX/UI Designer',
            type: 'full_time',
            location: 'Medellín, Colombia',
            salary: '\$2.500.000 - \$3.500.000',
            posted: '1 semana',
            isUrgent: false,
            skills: ['Figma', 'Adobe XD', 'Prototyping'],
          ),
        ],
        reviews: [
          CompanyReview(
            id: '1',
            authorName: 'María González',
            authorRole: 'Desarrolladora Senior',
            authorAvatar: '',
            rating: 5.0,
            title: 'Excelente ambiente de trabajo',
            content: 'TechCorp ofrece un ambiente de trabajo increíble con oportunidades de crecimiento constantes.',
            date: DateTime.now().subtract(const Duration(days: 30)),
            pros: ['Ambiente colaborativo', 'Tecnologías modernas', 'Flexibilidad'],
            cons: ['Algunas veces hay mucha carga de trabajo'],
            isVerified: true,
          ),
          CompanyReview(
            id: '2',
            authorName: 'Carlos Rodríguez',
            authorRole: 'Product Manager',
            authorAvatar: '',
            rating: 4.5,
            title: 'Buena empresa para crecer',
            content: 'Una empresa sólida con buenas oportunidades de desarrollo profesional.',
            date: DateTime.now().subtract(const Duration(days: 45)),
            pros: ['Oportunidades de crecimiento', 'Salario competitivo'],
            cons: ['Procesos internos complejos'],
            isVerified: true,
          ),
        ],
        gallery: [
          CompanyGallery(
            id: '1',
            imageUrl: '/images/office1.jpg',
            caption: 'Oficina principal en Bogotá',
            type: 'office',
            uploadedAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
          CompanyGallery(
            id: '2',
            imageUrl: '/images/team1.jpg',
            caption: 'Equipo de desarrollo',
            type: 'team',
            uploadedAt: DateTime.now().subtract(const Duration(days: 15)),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      CompanyModel(
        id: '2',
        name: 'InnovateLab',
        tagline: 'Transformando ideas en realidad',
        description: 'Startup enfocada en desarrollo de aplicaciones móviles y web. Buscamos talentos creativos y apasionados por la tecnología.',
        website: 'https://innovatelab.co',
        industry: 'Tecnología',
        size: '1-10 empleados',
        location: 'Medellín, Colombia',
        founded: '2020',
        isVerified: false,
        followersCount: 320,
        jobsCount: 8,
        rating: 4.2,
        reviewsCount: 12,
        benefits: [
          'Equidad en la empresa',
          'Horario flexible',
          'Ambiente startup',
          'Tecnologías de vanguardia',
        ],
        technologies: [
          'Flutter',
          'React Native',
          'Firebase',
          'GraphQL',
        ],
        locations: [
          'Medellín, Colombia',
          'Remoto',
        ],
        recentJobs: [
          CompanyJob(
            id: '4',
            title: 'Desarrollador Flutter',
            type: 'full_time',
            location: 'Medellín, Colombia',
            salary: '\$2.000.000 - \$3.000.000',
            posted: '3 días',
            isUrgent: false,
            skills: ['Flutter', 'Dart', 'Firebase'],
          ),
          CompanyJob(
            id: '5',
            title: 'Diseñador UX/UI',
            type: 'part_time',
            location: 'Remoto',
            salary: '\$1.500.000 - \$2.500.000',
            posted: '1 semana',
            isUrgent: false,
            skills: ['Figma', 'Adobe Creative Suite', 'Prototyping'],
          ),
        ],
        reviews: [
          CompanyReview(
            id: '3',
            authorName: 'Ana Martínez',
            authorRole: 'Desarrolladora',
            authorAvatar: '',
            rating: 4.0,
            title: 'Ambiente dinámico',
            content: 'Una startup con mucho potencial y ambiente dinámico.',
            date: DateTime.now().subtract(const Duration(days: 60)),
            pros: ['Ambiente dinámico', 'Tecnologías modernas'],
            cons: ['Salario inicial bajo'],
            isVerified: true,
          ),
        ],
        gallery: [
          CompanyGallery(
            id: '3',
            imageUrl: '/images/startup1.jpg',
            caption: 'Oficina startup',
            type: 'office',
            uploadedAt: DateTime.now().subtract(const Duration(days: 20)),
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  CompanyModel? getCompanyById(String id) {
    try {
      return state.firstWhere((company) => company.id == id);
    } catch (e) {
      return null;
    }
  }

  List<CompanyModel> getVerifiedCompanies() {
    return state.where((company) => company.isVerified).toList();
  }

  List<CompanyModel> getCompaniesByIndustry(String industry) {
    return state.where((company) => company.industry == industry).toList();
  }

  List<CompanyModel> getCompaniesByLocation(String location) {
    return state.where((company) => company.location.contains(location)).toList();
  }

  List<CompanyModel> searchCompanies(String query) {
    if (query.isEmpty) return state;
    
    return state.where((company) {
      return company.name.toLowerCase().contains(query.toLowerCase()) ||
             company.tagline.toLowerCase().contains(query.toLowerCase()) ||
             company.description.toLowerCase().contains(query.toLowerCase()) ||
             company.industry.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void addCompany(CompanyModel company) {
    state = [company, ...state];
  }

  void updateCompany(String id, CompanyModel updatedCompany) {
    state = state.map((company) => company.id == id ? updatedCompany : company).toList();
  }

  void deleteCompany(String id) {
    state = state.where((company) => company.id != id).toList();
  }

  void followCompany(String id) {
    state = state.map((company) {
      if (company.id == id) {
        return company.copyWith(followersCount: company.followersCount + 1);
      }
      return company;
    }).toList();
  }

  void unfollowCompany(String id) {
    state = state.map((company) {
      if (company.id == id) {
        return company.copyWith(followersCount: company.followersCount - 1);
      }
      return company;
    }).toList();
  }
}

final companyProvider = NotifierProvider<CompanyNotifier, List<CompanyModel>>(() {
  return CompanyNotifier();
});

final companyByIdProvider = Provider.family<CompanyModel?, String>((ref, id) {
  return ref.watch(companyProvider.notifier).getCompanyById(id);
});

final verifiedCompaniesProvider = Provider<List<CompanyModel>>((ref) {
  return ref.watch(companyProvider.notifier).getVerifiedCompanies();
});

final companiesByIndustryProvider = Provider.family<List<CompanyModel>, String>((ref, industry) {
  return ref.watch(companyProvider.notifier).getCompaniesByIndustry(industry);
});

final companiesByLocationProvider = Provider.family<List<CompanyModel>, String>((ref, location) {
  return ref.watch(companyProvider.notifier).getCompaniesByLocation(location);
});

final companySearchProvider = Provider.family<List<CompanyModel>, String>((ref, query) {
  return ref.watch(companyProvider.notifier).searchCompanies(query);
});
