import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/job_provider.dart';
import '../../widgets/job/job_card.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/search/specialization_categories.dart';
import '../job/job_detail_screen.dart';
import '../../../data/models/job_model.dart';

/// Pantalla de búsqueda avanzada
class AdvancedSearchScreen extends ConsumerStatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  ConsumerState<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends ConsumerState<AdvancedSearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  
  String _selectedCategory = '';
  String _selectedJobType = '';
  String _selectedLocation = '';
  String _selectedExperience = '';
  String _selectedSort = 'recent';
  String _selectedSpecialization = '';
  
  bool _isRemote = false;
  bool _isUrgent = false;
  
  final List<String> _categories = [
    'Todas las categorías',
    'Desarrollo de Software',
    'Diseño Gráfico',
    'Marketing Digital',
    'Escritura y Traducción',
    'Diseño Web',
    'Fotografía',
    'Video y Animación',
    'Música y Audio',
    'Programación',
    'Datos y Análisis',
    'Ingeniería',
    'Arquitectura',
    'Consultoría',
    'Recursos Humanos',
    'Ventas',
    'Atención al Cliente',
    'Educación',
    'Salud',
    'Finanzas',
  ];

  final List<String> _jobTypes = [
    'Todos los tipos',
    'full_time',
    'fixed_price',
    'hourly',
  ];

  final List<String> _locations = [
    'Todas las ubicaciones',
    'Remoto',
    'Presencial',
    'Híbrido',
    'Bogotá',
    'Medellín',
    'Cali',
    'Barranquilla',
    'Cartagena',
  ];

  final List<String> _experienceLevels = [
    'Todos los niveles',
    'entry',
    'mid',
    'senior',
    'expert',
  ];

  final List<String> _sortOptions = [
    'Más recientes',
    'Mayor salario',
    'Menor salario',
    'Más relevantes',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(jobProvider.notifier).loadMore();
    }
  }

  void _performSearch() {
    ref.read(jobProvider.notifier).getJobs(
      search: _searchController.text,
      category: _selectedSpecialization.isNotEmpty ? _selectedSpecialization : (_selectedCategory == 'Todas las categorías' ? null : _selectedCategory),
      jobType: _selectedJobType == 'Todos los tipos' ? null : _selectedJobType,
      locationType: _selectedLocation == 'Todas las ubicaciones' ? null : _selectedLocation,
      experienceLevel: _selectedExperience == 'Todos los niveles' ? null : _selectedExperience,
      sort: _selectedSort,
    );
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = '';
      _selectedJobType = '';
      _selectedLocation = '';
      _selectedExperience = '';
      _selectedSort = 'recent';
      _selectedSpecialization = '';
      _isRemote = false;
      _isUrgent = false;
    });
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final jobState = ref.watch(jobProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda Avanzada'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          // Barra de búsqueda
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar trabajos...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
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
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      _performSearch();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _performSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ),

          // Categorías de especialización
          SpecializationCategories(
            categories: SpecializationCategoriesData.categories,
            selectedCategory: _selectedSpecialization,
            onCategorySelected: (categoryId) {
              setState(() {
                _selectedSpecialization = _selectedSpecialization == categoryId ? '' : categoryId;
              });
              _performSearch();
            },
          ),

          // Filtros activos
          if (_hasActiveFilters())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (_selectedSpecialization.isNotEmpty)
                      _buildFilterChip('Especialización: ${_getSpecializationName(_selectedSpecialization)}', () {
                        setState(() {
                          _selectedSpecialization = '';
                        });
                        _performSearch();
                      }),
                    if (_selectedCategory.isNotEmpty && _selectedCategory != 'Todas las categorías')
                      _buildFilterChip('Categoría: $_selectedCategory', () {
                        setState(() {
                          _selectedCategory = '';
                        });
                        _performSearch();
                      }),
                    if (_selectedJobType.isNotEmpty && _selectedJobType != 'Todos los tipos')
                      _buildFilterChip('Tipo: ${_getJobTypeText(_selectedJobType)}', () {
                        setState(() {
                          _selectedJobType = '';
                        });
                        _performSearch();
                      }),
                    if (_selectedLocation.isNotEmpty && _selectedLocation != 'Todas las ubicaciones')
                      _buildFilterChip('Ubicación: $_selectedLocation', () {
                        setState(() {
                          _selectedLocation = '';
                        });
                        _performSearch();
                      }),
                    if (_selectedExperience.isNotEmpty && _selectedExperience != 'Todos los niveles')
                      _buildFilterChip('Experiencia: ${_getExperienceText(_selectedExperience)}', () {
                        setState(() {
                          _selectedExperience = '';
                        });
                        _performSearch();
                      }),
                    if (_isRemote)
                      _buildFilterChip('Remoto', () {
                        setState(() {
                          _isRemote = false;
                        });
                        _performSearch();
                      }),
                    if (_isUrgent)
                      _buildFilterChip('Urgente', () {
                        setState(() {
                          _isUrgent = false;
                        });
                        _performSearch();
                      }),
                    TextButton(
                      onPressed: _clearFilters,
                      child: const Text('Limpiar todo'),
                    ),
                  ],
                ),
              ),
            ),

          // Resultados - Solo mostrar si hay búsqueda activa o trabajos
          if (_shouldShowEmptyState() || jobState.jobs.isNotEmpty)
            SizedBox(
              height: 400, // Altura fija para evitar conflictos de layout
              child: jobState.isLoading && jobState.jobs.isEmpty
                  ? const LoadingIndicator(message: 'Buscando trabajos...')
                  : _shouldShowEmptyState()
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: () async {
                            _performSearch();
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: jobState.jobs.length + (jobState.isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= jobState.jobs.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final job = jobState.jobs[index];
                              // Manejo seguro del salaryRange
                              String salaryText;
                              try {
                                salaryText = job.salaryRange;
                              } catch (e) {
                                // Fallback si hay error con el getter
                                if (job.type == 'fixed_price' && job.budget != null) {
                                  salaryText = '\$${job.budget!.toStringAsFixed(0)} (Proyecto fijo)';
                                } else if (job.type == 'hourly' && job.hourlyRate != null) {
                                  salaryText = '\$${job.hourlyRate!.min.toStringAsFixed(0)} - \$${job.hourlyRate!.max.toStringAsFixed(0)} / hora';
                                } else {
                                  salaryText = 'No especificado';
                                }
                              }
                              
                              // Manejo seguro del experienceLevelText
                              String experienceText;
                              try {
                                experienceText = job.experienceLevelText;
                              } catch (e) {
                                // Fallback si hay error con el getter
                                switch (job.experienceLevel) {
                                  case 'entry':
                                    experienceText = 'Principiante';
                                    break;
                                  case 'intermediate':
                                    experienceText = 'Intermedio';
                                    break;
                                  case 'expert':
                                    experienceText = 'Experto';
                                    break;
                                  default:
                                    experienceText = 'Intermedio';
                                }
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: JobCard(
                                  jobId: job.id,
                                  title: job.title,
                                  company: '${job.client?.profile.firstName ?? 'Cliente'} • ${job.category}',
                                  salary: salaryText,
                                  location: job.category,
                                  tags: [
                                    job.type,
                                    experienceText,
                                    if (job.isUrgent) 'Urgente',
                                  ],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => JobDetailScreen(jobId: job.id),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
            ),
        ],
      ),
    ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDeleted) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: onDeleted,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        labelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: AppColors.grey400,
            ),
            const SizedBox(height: 24),
            Text(
              'No se encontraron trabajos',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta ajustar tus filtros de búsqueda o busca con términos diferentes.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.refresh),
              label: const Text('Limpiar Filtros'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filtros de Búsqueda',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _clearFilters();
                      },
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
              ),
              
              // Filters
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterSection('Categoría', _buildCategoryFilter()),
                      _buildFilterSection('Tipo de Trabajo', _buildJobTypeFilter()),
                      _buildFilterSection('Ubicación', _buildLocationFilter()),
                      _buildFilterSection('Nivel de Experiencia', _buildExperienceFilter()),
                      _buildFilterSection('Ordenar por', _buildSortFilter()),
                      _buildFilterSection('Opciones', _buildOptionsFilter()),
                      
                      const SizedBox(height: 32),
                      
                      // Apply button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _performSearch();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Aplicar Filtros',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _categories.map((category) {
        final isSelected = _selectedCategory == category;
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedCategory = selected ? category : '';
            });
          },
          backgroundColor: AppColors.grey100,
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        );
      }).toList(),
    );
  }

  Widget _buildJobTypeFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _jobTypes.map((type) {
        final isSelected = _selectedJobType == type;
        return FilterChip(
          label: Text(_getJobTypeText(type)),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedJobType = selected ? type : '';
            });
          },
          backgroundColor: AppColors.grey100,
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        );
      }).toList(),
    );
  }

  Widget _buildLocationFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _locations.map((location) {
        final isSelected = _selectedLocation == location;
        return FilterChip(
          label: Text(location),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedLocation = selected ? location : '';
            });
          },
          backgroundColor: AppColors.grey100,
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        );
      }).toList(),
    );
  }

  Widget _buildExperienceFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _experienceLevels.map((level) {
        final isSelected = _selectedExperience == level;
        return FilterChip(
          label: Text(_getExperienceText(level)),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedExperience = selected ? level : '';
            });
          },
          backgroundColor: AppColors.grey100,
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        );
      }).toList(),
    );
  }

  Widget _buildSortFilter() {
    return Column(
      children: _sortOptions.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final isSelected = _selectedSort == _getSortValue(index);
        
        return RadioListTile<String>(
          title: Text(option),
          value: _getSortValue(index),
          groupValue: _selectedSort,
          onChanged: (value) {
            setState(() {
              _selectedSort = value!;
            });
          },
          activeColor: AppColors.primary,
        );
      }).toList(),
    );
  }

  Widget _buildOptionsFilter() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Trabajo Remoto'),
          subtitle: const Text('Solo trabajos que se pueden hacer desde casa'),
          value: _isRemote,
          onChanged: (value) {
            setState(() {
              _isRemote = value;
            });
          },
          activeThumbColor: AppColors.primary,
        ),
        SwitchListTile(
          title: const Text('Trabajos Urgentes'),
          subtitle: const Text('Solo trabajos que requieren atención inmediata'),
          value: _isUrgent,
          onChanged: (value) {
            setState(() {
              _isUrgent = value;
            });
          },
          activeThumbColor: AppColors.primary,
        ),
      ],
    );
  }

  bool _hasActiveFilters() {
    return _selectedCategory.isNotEmpty ||
           _selectedJobType.isNotEmpty ||
           _selectedLocation.isNotEmpty ||
           _selectedExperience.isNotEmpty ||
           _selectedSpecialization.isNotEmpty ||
           _isRemote ||
           _isUrgent;
  }

  bool _shouldShowEmptyState() {
    // Solo mostrar estado vacío si se ha hecho una búsqueda real
    return _searchController.text.isNotEmpty ||
           _hasActiveFilters();
  }

  String _getJobTypeText(String type) {
    switch (type) {
      case 'full_time':
        return 'Tiempo Completo';
      case 'fixed_price':
        return 'Proyecto Fijo';
      case 'hourly':
        return 'Por Hora';
      default:
        return type;
    }
  }

  String _getExperienceText(String level) {
    switch (level) {
      case 'entry':
        return 'Principiante';
      case 'mid':
        return 'Intermedio';
      case 'senior':
        return 'Senior';
      case 'expert':
        return 'Experto';
      default:
        return level;
    }
  }

  String _getSortValue(int index) {
    switch (index) {
      case 0:
        return 'recent';
      case 1:
        return 'salary_desc';
      case 2:
        return 'salary_asc';
      case 3:
        return 'relevant';
      default:
        return 'recent';
    }
  }

  String _getSpecializationName(String specializationId) {
    final category = SpecializationCategoriesData.categories.firstWhere(
      (cat) => cat.id == specializationId,
      orElse: () => SpecializationCategory(
        id: specializationId,
        name: specializationId,
        icon: Icons.category,
      ),
    );
    return category.name;
  }
}
