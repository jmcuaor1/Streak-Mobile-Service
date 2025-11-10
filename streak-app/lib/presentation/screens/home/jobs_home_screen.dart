import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../../data/models/job_model.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/gamification_card.dart';
import '../../widgets/job/job_card.dart';
import '../job/job_detail_screen.dart';
import '../gamification/gamification_screen.dart';

/// Pantalla principal de Jobs (Home)
class JobsHomeScreen extends ConsumerStatefulWidget {
  const JobsHomeScreen({super.key});

  @override
  ConsumerState<JobsHomeScreen> createState() => _JobsHomeScreenState();
}

class _JobsHomeScreenState extends ConsumerState<JobsHomeScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedLocationType;
  String? _selectedJobType; // full-time / part-time / contract
  String? _selectedSort; // 'recent' | 'salary_desc' | 'salary_asc'
  String? _selectedExperienceLevel; // entry / intermediate / expert
  
  String? _tempCategory; // para el modal
  String? _tempLocationType;
  String? _tempJobType;
  String? _tempExperienceLevel;
  String? _tempSort; // para el modal

  @override
  void initState() {
    super.initState();
    
    // Cargar trabajos al iniciar
    Future.microtask(() {
      ref.read(jobProvider.notifier).getJobs();
    });

    // Listener para paginación infinita
    _scrollController.addListener(_onScroll);
    
    // Listener para actualizar UI cuando cambie el texto de búsqueda
    _searchController.addListener(() {
      setState(() {}); // Reconstruir para mostrar/ocultar botón de limpiar
    });
  }

  Widget _buildTypeChip(String label, String value) {
    final selected = _selectedJobType == value;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setState(() {
          _selectedJobType = v ? value : null;
        });
        ref.read(jobProvider.notifier).filterJobs(
              category: _selectedCategory,
              locationType: _selectedLocationType,
              jobType: _selectedJobType,
            );
      },
    );
  }

  Widget _buildCategoryChip(String label) {
    final selected = _selectedCategory == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setState(() {
          _selectedCategory = v ? label : null;
        });
        ref.read(jobProvider.notifier).filterJobs(
              category: _selectedCategory,
              locationType: _selectedLocationType,
              jobType: _selectedJobType,
            );
      },
    );
  }

  void _openFilterSheet() {
    _tempCategory = _selectedCategory;
    _tempLocationType = _selectedLocationType;
    _tempJobType = _selectedJobType;
    _tempExperienceLevel = _selectedExperienceLevel;
    _tempSort = _selectedSort;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Filtros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _tempCategory = null;
                            _tempLocationType = null;
                            _tempJobType = null;
                            _tempExperienceLevel = null;
                            _tempSort = null;
                          });
                        },
                        child: const Text('Limpiar'),
                      )
                    ],
                  ),

                  const SizedBox(height: 8),
                  const Text('Tipo de trabajo', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildModalTypeChip('Proyecto fijo', 'fixed_price', setModalState),
                      _buildModalTypeChip('Por hora', 'hourly', setModalState),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Ordenar por', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildModalSortChip('Más recientes', 'recent', setModalState),
                      _buildModalSortChip('Salario ↑', 'salary_asc', setModalState),
                      _buildModalSortChip('Salario ↓', 'salary_desc', setModalState),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Nivel de experiencia', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildModalExperienceChip('Principiante', 'entry', setModalState),
                      _buildModalExperienceChip('Intermedio', 'intermediate', setModalState),
                      _buildModalExperienceChip('Experto', 'expert', setModalState),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Categoría', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildModalCategoryChip('Software', setModalState),
                      _buildModalCategoryChip('Diseño', setModalState),
                      _buildModalCategoryChip('Marketing', setModalState),
                      _buildModalCategoryChip('Ventas', setModalState),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategory = _tempCategory;
                              _selectedLocationType = _tempLocationType;
                              _selectedJobType = _tempJobType;
                              _selectedExperienceLevel = _tempExperienceLevel;
                              _selectedSort = _tempSort;
                            });
                            ref.read(jobProvider.notifier).refresh(
                                  search: _searchController.text.isEmpty ? null : _searchController.text,
                                  category: _selectedCategory,
                                  locationType: _selectedLocationType,
                                  jobType: _selectedJobType,
                                  experienceLevel: _selectedExperienceLevel,
                                  sort: _selectedSort,
                                );
                            Navigator.pop(context);
                          },
                          child: const Text('Aplicar'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildModalTypeChip(String label, String value, void Function(void Function()) setModalState) {
    final selected = _tempJobType == value;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setModalState(() {
          _tempJobType = v ? value : null;
        });
      },
    );
  }

  Widget _buildModalLocationChip(String label, String value, void Function(void Function()) setModalState) {
    final selected = _tempLocationType == value;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setModalState(() {
          _tempLocationType = v ? value : null;
        });
      },
    );
  }

  Widget _buildModalExperienceChip(String label, String value, void Function(void Function()) setModalState) {
    final selected = _tempExperienceLevel == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setModalState(() {
          _tempExperienceLevel = v ? value : null;
        });
      },
    );
  }

  Widget _buildModalCategoryChip(String label, void Function(void Function()) setModalState) {
    final selected = _tempCategory == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setModalState(() {
          _tempCategory = v ? label : null;
        });
      },
    );
  }

  Widget _buildModalSortChip(String label, String value, void Function(void Function()) setModalState) {
    final selected = _tempSort == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setModalState(() {
          if (v) {
            _tempSort = value;
          } else if (_tempSort == value) {
            _tempSort = null;
          }
        });
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Cargar más cuando esté cerca del final
      ref.read(jobProvider.notifier).loadMore(
            search: _searchController.text.isEmpty ? null : _searchController.text,
            category: _selectedCategory,
            locationType: _selectedLocationType,
            jobType: _selectedJobType,
            experienceLevel: _selectedExperienceLevel,
            sort: _selectedSort,
          );
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(jobProvider.notifier).refresh(
          search: _searchController.text.isEmpty ? null : _searchController.text,
          category: _selectedCategory,
          locationType: _selectedLocationType,
          jobType: _selectedJobType,
          experienceLevel: _selectedExperienceLevel,
          sort: _selectedSort,
        );
  }

  void _onSearch(String query) {
    ref.read(jobProvider.notifier).getJobs(
          page: 1,
          search: query,
          category: _selectedCategory,
          locationType: _selectedLocationType,
          jobType: _selectedJobType,
          experienceLevel: _selectedExperienceLevel,
          sort: _selectedSort,
          refresh: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final jobState = ref.watch(jobProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.secondary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Saludo y Avatar
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '¡Hola!',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  user?.profile.firstName ?? 'Usuario',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            backgroundImage: user?.profile.avatar != null
                                ? NetworkImage(user!.profile.avatar!)
                                : null,
                            child: user?.profile.avatar == null
                                ? Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  )
                                : null,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Barra de búsqueda con filtros integrados
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Buscar trabajos...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Botón de filtros integrado
                              IconButton(
                                icon: const Icon(Icons.tune),
                                onPressed: _openFilterSheet,
                                tooltip: 'Filtros',
                              ),
                              // Botón de limpiar (si hay texto)
                              if (_searchController.text.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    _onSearch('');
                                  },
                                ),
                            ],
                          ),
                        ),
                        onSubmitted: _onSearch,
                        textInputAction: TextInputAction.search,
                      ),
                      
                      const SizedBox(height: 20),

                      // Recuadro de gamificación
                      const GamificationCard(),
                      
                      const SizedBox(height: 20),
                      
                      // Estadísticas del usuario
                      _buildUserStatsCard(),
                      
                      const SizedBox(height: 20),
                      
                      // Título de sección
                      Text(
                        'Encuentra tu empleo',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Stat Cards
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              label: 'Remoto',
                              value: '${jobState.jobs.where((j) => j.type == 'fixed_price').length}',
                              icon: Icons.laptop_mac,
                              color: AppColors.primaryLight.withOpacity(0.1),
                              onTap: () {
                                setState(() {
                                  _selectedLocationType = _selectedLocationType == 'remote' ? null : 'remote';
                                });
                                ref.read(jobProvider.notifier).filterJobs(
                                      locationType: _selectedLocationType,
                                    );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              label: 'Tiempo\nCompleto',
                              value: '${jobState.jobs.where((j) => j.type == 'hourly').length}',
                              icon: Icons.business,
                              color: AppColors.secondaryLight.withOpacity(0.1),
                              onTap: () {
                                setState(() {
                                  _selectedJobType = _selectedJobType == 'full-time' ? null : 'full-time';
                                });
                                ref.read(jobProvider.notifier).filterJobs(
                                      jobType: _selectedJobType,
                                    );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              label: 'Híbrido',
                              value: '${jobState.jobs.where((j) => j.experienceLevel == 'expert').length}',
                              icon: Icons.home_work,
                              color: AppColors.tertiaryLight.withOpacity(0.1),
                              onTap: () {
                                setState(() {
                                  _selectedLocationType = _selectedLocationType == 'hybrid' ? null : 'hybrid';
                                });
                                ref.read(jobProvider.notifier).filterJobs(
                                      locationType: _selectedLocationType,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Título de lista
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Empleos recientes',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (_selectedCategory != null || _selectedLocationType != null)
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _selectedCategory = null;
                                  _selectedLocationType = null;
                                  _selectedJobType = null;
                                });
                                ref.read(jobProvider.notifier).refresh();
                              },
                              icon: const Icon(Icons.clear_all, size: 18),
                              label: const Text('Limpiar filtros'),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              
              // Lista de trabajos
              if (jobState.isLoading && jobState.jobs.isEmpty)
                SliverFillRemaining(
                  child: LoadingIndicator(message: 'Cargando trabajos...'),
                )
              else if (jobState.error != null && jobState.jobs.isEmpty)
                SliverFillRemaining(
                  child: AppErrorWidget(
                    message: jobState.error!,
                    onRetry: () {
                      ref.read(jobProvider.notifier).clearError();
                      ref.read(jobProvider.notifier).getJobs();
                    },
                  ),
                )
              else if (jobState.jobs.isEmpty)
                const SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.work_outline,
                    title: 'No hay trabajos',
                    message: 'No encontramos trabajos disponibles.\nIntenta con otros filtros.',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= jobState.jobs.length) {
                          // Mostrar loading al final si hay más
                          return jobState.isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox.shrink();
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
                              print('🎯 Navegando a detalles del trabajo: ${job.id}');
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
                      childCount: jobState.jobs.length + (jobState.isLoading ? 1 : 0),
                    ),
                  ),
                ),
              
              // Espacio final
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construir tarjeta de estadísticas del usuario
  Widget _buildUserStatsCard() {
    final user = ref.watch(currentUserProvider);
    final gamificationState = ref.watch(gamificationProvider);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Contenido de texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título
                Text(
                  'Tu progreso\ndiario',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Estadísticas
                Text(
                  '${gamificationState.currentStreak} días de racha',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                Text(
                  'Nivel ${gamificationState.level} • ${gamificationState.totalPoints} puntos',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Botón CTA
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GamificationScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ver progreso',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.trending_up,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Icono de gamificación
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.local_fire_department,
              size: 40,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

