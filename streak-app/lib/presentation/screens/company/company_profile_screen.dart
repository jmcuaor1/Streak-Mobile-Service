import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/company_model.dart';
import '../../providers/company_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/company/company_widgets.dart';

/// Pantalla mejorada de perfil de empresa
class CompanyProfileScreen extends ConsumerStatefulWidget {
  final String companyId;
  
  const CompanyProfileScreen({
    super.key,
    required this.companyId,
  });

  @override
  ConsumerState<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends ConsumerState<CompanyProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final company = ref.watch(companyByIdProvider(widget.companyId));
    final companyNotifier = ref.read(companyProvider.notifier);

    if (company == null) {
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
          // AppBar personalizado con imagen de portada
          SliverAppBar(
            expandedHeight: 250,
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
                    // Imagen de portada
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
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.grey200, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: company.logo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  company.logo!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.business,
                                      color: AppColors.primary,
                                      size: 40,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.business,
                                color: AppColors.primary,
                                size: 40,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => _shareCompany(company),
                icon: const Icon(Icons.share, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _toggleFollow(company, companyNotifier),
                icon: Icon(
                  _isFollowing ? Icons.favorite : Icons.favorite_border,
                  color: _isFollowing ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          
          // Información básica de la empresa
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40), // Espacio para el logo
                  
                  // Nombre y verificación
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          company.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      if (company.isVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'VERIFICADA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    company.tagline,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Estadísticas principales
                  Row(
                    children: [
                      _buildStatCard(
                        icon: Icons.work,
                        value: '${company.jobsCount}',
                        label: 'Trabajos',
                      ),
                      const SizedBox(width: 16),
                      _buildStatCard(
                        icon: Icons.people,
                        value: '${company.followersCount}',
                        label: 'Seguidores',
                      ),
                      const SizedBox(width: 16),
                      _buildStatCard(
                        icon: Icons.star,
                        value: company.rating.toStringAsFixed(1),
                        label: 'Rating',
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Información adicional
                  _buildInfoRow(Icons.location_on, 'Ubicación', company.location),
                  _buildInfoRow(Icons.business, 'Industria', company.industry),
                  _buildInfoRow(Icons.people, 'Tamaño', company.size),
                  _buildInfoRow(Icons.calendar_today, 'Fundada', company.founded),
                  _buildInfoRow(Icons.language, 'Sitio web', company.website),
                ],
              ),
            ),
          ),
          
          // TabBar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Sobre'),
                  Tab(text: 'Trabajos'),
                  Tab(text: 'Reseñas'),
                  Tab(text: 'Galería'),
                ],
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
              ),
            ),
          ),
          
          // Contenido de las pestañas
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(company),
                _buildJobsTab(company),
                _buildReviewsTab(company),
                _buildGalleryTab(company),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(CompanyModel company) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Descripción
          Text(
            'Descripción',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            company.description,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Beneficios
          if (company.benefits.isNotEmpty) ...[
            Text(
              'Beneficios',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            ...company.benefits.map((benefit) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      benefit,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
          
          const SizedBox(height: 24),
          
          // Tecnologías
          if (company.technologies.isNotEmpty) ...[
            Text(
              'Tecnologías',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: company.technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildJobsTab(CompanyModel company) {
    if (company.recentJobs.isEmpty) {
      return const Center(
        child: Text('No hay trabajos disponibles'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: company.recentJobs.length,
      itemBuilder: (context, index) {
        final job = company.recentJobs[index];
        return CompanyJobCard(
          job: job,
          onTap: () => _viewJob(job),
        );
      },
    );
  }

  Widget _buildReviewsTab(CompanyModel company) {
    if (company.reviews.isEmpty) {
      return const Center(
        child: Text('No hay reseñas disponibles'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: company.reviews.length,
      itemBuilder: (context, index) {
        final review = company.reviews[index];
        return CompanyReviewCard(review: review);
      },
    );
  }

  Widget _buildGalleryTab(CompanyModel company) {
    if (company.gallery.isEmpty) {
      return const Center(
        child: Text('No hay imágenes disponibles'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: company.gallery.length,
      itemBuilder: (context, index) {
        final galleryItem = company.gallery[index];
        return Card(
          elevation: 0,
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.grey200),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.grey100,
                  child: Icon(
                    Icons.image,
                    color: AppColors.grey400,
                    size: 40,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Text(
                      galleryItem.caption,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _shareCompany(CompanyModel company) {
    AppToast.showInfo(context, 'Compartir ${company.name} próximamente');
  }

  void _toggleFollow(CompanyModel company, CompanyNotifier companyNotifier) {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    if (_isFollowing) {
      companyNotifier.followCompany(company.id);
      AppToast.showSuccess(context, 'Ahora sigues a ${company.name}');
    } else {
      companyNotifier.unfollowCompany(company.id);
      AppToast.showInfo(context, 'Dejaste de seguir a ${company.name}');
    }
  }

  void _viewJob(CompanyJob job) {
    AppToast.showInfo(context, 'Ver trabajo: ${job.title}');
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.cardBackground,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
