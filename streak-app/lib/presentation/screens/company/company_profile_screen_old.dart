import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla de perfil de empresa
/// Basada en el diseño de Company.jpg, Company-1.jpg y Company-2.jpg
class CompanyProfileScreen extends ConsumerStatefulWidget {
  final String companyId;
  
  const CompanyProfileScreen({
    super.key,
    required this.companyId,
  });

  @override
  ConsumerState<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends ConsumerState<CompanyProfileScreen> {
  bool _isLoading = true;
  bool _isFollowing = false;
  
  // Mock data - en una app real esto vendría del backend
  Map<String, dynamic>? _companyData;

  @override
  void initState() {
    super.initState();
    _loadCompanyData();
  }

  Future<void> _loadCompanyData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simular carga de datos de empresa
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      _companyData = {
        'id': widget.companyId,
        'name': 'TechCorp Solutions',
        'tagline': 'Innovación tecnológica para el futuro',
        'description': 'Somos una empresa líder en desarrollo de software y soluciones tecnológicas. Con más de 10 años de experiencia, ayudamos a empresas a digitalizar sus procesos y mejorar su eficiencia.',
        'website': 'https://techcorp.com',
        'industry': 'Tecnología',
        'size': '50-200 empleados',
        'location': 'Bogotá, Colombia',
        'founded': '2013',
        'logo': null,
        'coverImage': null,
        'isVerified': true,
        'followersCount': 1250,
        'jobsCount': 45,
        'rating': 4.8,
        'reviewsCount': 89,
        'benefits': [
          'Seguro médico completo',
          'Horario flexible',
          'Trabajo remoto',
          'Bonos por rendimiento',
          'Capacitación continua',
        ],
        'recentJobs': [
          {
            'id': '1',
            'title': 'Desarrollador Full Stack Senior',
            'type': 'full_time',
            'location': 'Bogotá, Colombia',
            'salary': '\$3.000.000 - \$4.500.000',
            'posted': '2 días',
          },
          {
            'id': '2',
            'title': 'Product Manager',
            'type': 'full_time',
            'location': 'Remoto',
            'salary': '\$4.000.000 - \$6.000.000',
            'posted': '5 días',
          },
          {
            'id': '3',
            'title': 'UX/UI Designer',
            'type': 'full_time',
            'location': 'Medellín, Colombia',
            'salary': '\$2.500.000 - \$3.500.000',
            'posted': '1 semana',
          },
        ],
      };
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        AppToast.showError(context, 'Error al cargar la información de la empresa');
      }
    }
  }

  Future<void> _toggleFollow() async {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    try {
      // Simular toggle de seguimiento
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (mounted) {
        AppToast.showSuccess(
          context, 
          _isFollowing ? 'Ahora sigues a ${_companyData!['name']}' : 'Dejaste de seguir a ${_companyData!['name']}'
        );
      }
    } catch (e) {
      setState(() {
        _isFollowing = !_isFollowing;
      });
      if (mounted) {
        AppToast.showError(context, 'Error al actualizar el seguimiento');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Empresa'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_companyData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Empresa'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(
          child: Text('Empresa no encontrada'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar personalizado
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Imagen de portada (placeholder)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.primary.withOpacity(0.8),
                    ),
                    // Logo de la empresa
                    Positioned(
                      bottom: -40,
                      left: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.business,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  AppToast.showInfo(context, 'Función de compartir próximamente');
                },
              ),
            ],
          ),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50), // Espacio para el logo
                  
                  // Información básica
                  _buildCompanyHeader(),
                  
                  const SizedBox(height: 24),
                  
                  // Botones de acción
                  _buildActionButtons(),
                  
                  const SizedBox(height: 24),
                  
                  // Estadísticas
                  _buildStatsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Descripción
                  _buildDescriptionSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Beneficios
                  _buildBenefitsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Trabajos recientes
                  _buildRecentJobsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Reseñas
                  _buildReviewsSection(),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _companyData!['name'],
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (_companyData!['isVerified'])
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: AppColors.success,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Empresa verificada',
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _companyData!['tagline'],
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.business, 'Industria', _companyData!['industry']),
        _buildInfoRow(Icons.people, 'Tamaño', _companyData!['size']),
        _buildInfoRow(Icons.location_on, 'Ubicación', _companyData!['location']),
        _buildInfoRow(Icons.calendar_today, 'Fundada', _companyData!['founded']),
        if (_companyData!['website'] != null)
          _buildInfoRow(Icons.language, 'Sitio web', _companyData!['website']),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _toggleFollow,
            icon: Icon(_isFollowing ? Icons.person_remove : Icons.person_add),
            label: Text(_isFollowing ? 'Siguiendo' : 'Seguir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFollowing ? AppColors.grey300 : AppColors.primary,
              foregroundColor: _isFollowing ? AppColors.textPrimary : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              AppToast.showInfo(context, 'Función de contacto próximamente');
            },
            icon: const Icon(Icons.message),
            label: const Text('Contactar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Seguidores',
              '${_companyData!['followersCount']}',
              Icons.people,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.grey200,
          ),
          Expanded(
            child: _buildStatItem(
              'Trabajos',
              '${_companyData!['jobsCount']}',
              Icons.work,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.grey200,
          ),
          Expanded(
            child: _buildStatItem(
              'Calificación',
              '${_companyData!['rating']}',
              Icons.star,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acerca de nosotros',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _companyData!['description'],
          style: TextStyle(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beneficios',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...(_companyData!['benefits'] as List<String>).map((benefit) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    benefit,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRecentJobsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trabajos recientes',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                AppToast.showInfo(context, 'Ver todos los trabajos próximamente');
              },
              child: const Text('Ver todos'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...(_companyData!['recentJobs'] as List<Map<String, dynamic>>).map((job) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(
                job['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${job['location']} • ${job['type']}'),
                  Text(
                    job['salary'],
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                job['posted'],
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              onTap: () {
                AppToast.showInfo(context, 'Ver detalles del trabajo próximamente');
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reseñas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                AppToast.showInfo(context, 'Ver todas las reseñas próximamente');
              },
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.warning,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_companyData!['rating']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${_companyData!['reviewsCount']} reseñas)',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Excelente empresa para trabajar. Ambiente colaborativo y oportunidades de crecimiento.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
