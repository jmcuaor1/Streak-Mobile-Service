import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/company_model.dart';
import '../../providers/company_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/company/company_widgets.dart';
import 'company_profile_screen_new.dart';

/// Pantalla de lista de empresas
class CompaniesScreen extends ConsumerStatefulWidget {
  const CompaniesScreen({super.key});

  @override
  ConsumerState<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends ConsumerState<CompaniesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedIndustry = 'Todas';
  String _selectedLocation = 'Todas';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final companies = ref.watch(companyProvider);
    final verifiedCompanies = ref.watch(verifiedCompaniesProvider);
    final companyNotifier = ref.read(companyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(),
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filtrar',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Todas'),
                  if (companies.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${companies.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Verificadas'),
                  if (verifiedCompanies.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${verifiedCompanies.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Tecnología'),
                  if (companyNotifier.getCompaniesByIndustry('Tecnología').isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.info,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${companyNotifier.getCompaniesByIndustry('Tecnología').length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar empresas...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          
          // Lista de empresas
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCompaniesList(companies),
                _buildCompaniesList(verifiedCompanies),
                _buildCompaniesList(companyNotifier.getCompaniesByIndustry('Tecnología')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompaniesList(List<CompanyModel> companies) {
    List<CompanyModel> filteredCompanies = companies;

    // Aplicar filtro de búsqueda
    if (_searchController.text.isNotEmpty) {
      filteredCompanies = companyNotifier.searchCompanies(_searchController.text)
          .where((company) => companies.contains(company))
          .toList();
    }

    if (filteredCompanies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.business_outlined,
                size: 80,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'No se encontraron empresas',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Intenta ajustar tus filtros de búsqueda o explorar otras categorías.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Simular refresh
        await Future.delayed(const Duration(seconds: 1));
        AppToast.showSuccess(context, 'Empresas actualizadas');
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredCompanies.length,
        itemBuilder: (context, index) {
          final company = filteredCompanies[index];
          return CompanyCard(
            company: company,
            onTap: () => _navigateToCompanyProfile(company),
            onFollow: () => _toggleFollow(company),
            isFollowing: false, // En una app real esto vendría del estado
          );
        },
      ),
    );
  }

  void _navigateToCompanyProfile(CompanyModel company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompanyProfileScreen(companyId: company.id),
      ),
    );
  }

  void _toggleFollow(CompanyModel company) {
    AppToast.showSuccess(context, 'Ahora sigues a ${company.name}');
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar Empresas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Filtro por industria
            DropdownButtonFormField<String>(
              initialValue: _selectedIndustry,
              decoration: const InputDecoration(
                labelText: 'Industria',
                border: OutlineInputBorder(),
              ),
              items: [
                'Todas',
                'Tecnología',
                'Salud',
                'Finanzas',
                'Educación',
                'Retail',
                'Manufactura',
                'Consultoría',
                'Medios',
                'Bienes Raíces',
                'Otro',
              ].map((industry) {
                return DropdownMenuItem(
                  value: industry,
                  child: Text(industry),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedIndustry = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Filtro por ubicación
            DropdownButtonFormField<String>(
              initialValue: _selectedLocation,
              decoration: const InputDecoration(
                labelText: 'Ubicación',
                border: OutlineInputBorder(),
              ),
              items: [
                'Todas',
                'Bogotá, Colombia',
                'Medellín, Colombia',
                'Cali, Colombia',
                'Barranquilla, Colombia',
                'Remoto',
              ].map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLocation = value!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              AppToast.showSuccess(context, 'Filtros aplicados');
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }
}
