import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/gigs_provider.dart';
import '../../../data/models/job_model.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/job/job_card.dart';
import '../job/job_detail_screen.dart';

/// Pantalla de Gigs (Freelance)
class GigsHomeScreen extends ConsumerStatefulWidget {
  const GigsHomeScreen({super.key});

  @override
  ConsumerState<GigsHomeScreen> createState() => _GigsHomeScreenState();
}

class _GigsHomeScreenState extends ConsumerState<GigsHomeScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedExperienceLevel;
  String? _selectedSort;
  
  String? _tempCategory;
  String? _tempExperienceLevel;
  String? _tempSort;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(gigsProvider.notifier).getGigs();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(gigsProvider.notifier).loadMore(
            search: _searchController.text.isEmpty ? null : _searchController.text,
            category: _selectedCategory,
            experienceLevel: _selectedExperienceLevel,
            sort: _selectedSort,
          );
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(gigsProvider.notifier).refresh(
          search: _searchController.text.isEmpty ? null : _searchController.text,
          category: _selectedCategory,
          experienceLevel: _selectedExperienceLevel,
          sort: _selectedSort,
        );
  }

  void _onSearch(String query) {
    ref.read(gigsProvider.notifier).getGigs(
          page: 1,
          search: query,
          category: _selectedCategory,
          experienceLevel: _selectedExperienceLevel,
          sort: _selectedSort,
          refresh: true,
        );
  }

  void _openFilterSheet() {
    _tempCategory = _selectedCategory;
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
                            _tempExperienceLevel = null;
                            _tempSort = null;
                          });
                        },
                        child: const Text('Limpiar'),
                      )
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
                  const Text('Ordenar por', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildModalSortChip('Más recientes', 'recent', setModalState, _tempSort),
                      _buildModalSortChip('Presupuesto ↑', 'budget_asc', setModalState, _tempSort),
                      _buildModalSortChip('Presupuesto ↓', 'budget_desc', setModalState, _tempSort),
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
                              _selectedExperienceLevel = _tempExperienceLevel;
                              _selectedSort = _tempSort;
                            });
                            ref.read(gigsProvider.notifier).refresh(
                                  search: _searchController.text.isEmpty ? null : _searchController.text,
                                  category: _selectedCategory,
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

  Widget _buildModalSortChip(String label, String value, void Function(void Function()) setModalState, String? current) {
    final selected = current == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setModalState(() {
          if (v) {
            current = value;
          } else if (current == value) {
            current = null;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gigsState = ref.watch(gigsProvider);
    final savedGigs = ref.watch(savedGigsProvider);
    final appliedGigs = ref.watch(appliedGigsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gigs / Freelance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _openFilterSheet,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Búsqueda
                    TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Buscar gigs (ej. diseño, backend, UX...)',
                        prefixIcon: Icon(Icons.search),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: _onSearch,
                    ),

                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: _openFilterSheet,
                        icon: const Icon(Icons.tune),
                        label: const Text('Filtros'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (gigsState.isLoading && gigsState.gigs.isEmpty)
              const SliverFillRemaining(
                child: LoadingIndicator(message: 'Cargando gigs...'),
              )
            else if (gigsState.error != null && gigsState.gigs.isEmpty)
              SliverFillRemaining(
                child: AppErrorWidget(
                  message: gigsState.error!,
                  onRetry: () {
                    ref.read(gigsProvider.notifier).clearError();
                    ref.read(gigsProvider.notifier).getGigs();
                  },
                ),
              )
            else if (gigsState.gigs.isEmpty)
              const SliverFillRemaining(
                child: EmptyState(
                  icon: Icons.flash_on,
                  title: 'Sin gigs disponibles',
                  message: 'Prueba cambiando los filtros o el término de búsqueda.',
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= gigsState.gigs.length) {
                        return gigsState.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(20),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox.shrink();
                      }

                      final gig = gigsState.gigs[index];
                      
                      // Manejo seguro del salaryRange
                      String salaryText;
                      try {
                        salaryText = gig.salaryRange;
                      } catch (e) {
                        // Fallback si hay error con el getter
                        if (gig.type == 'fixed_price' && gig.budget != null) {
                          salaryText = '\$${gig.budget!.toStringAsFixed(0)} (Proyecto fijo)';
                        } else if (gig.type == 'hourly' && gig.hourlyRate != null) {
                          salaryText = '\$${gig.hourlyRate!.min.toStringAsFixed(0)} - \$${gig.hourlyRate!.max.toStringAsFixed(0)} / hora';
                        } else {
                          salaryText = 'No especificado';
                        }
                      }
                      
                      // Manejo seguro del experienceLevelText
                      String experienceText;
                      try {
                        experienceText = gig.experienceLevelText;
                      } catch (e) {
                        // Fallback si hay error con el getter
                        switch (gig.experienceLevel) {
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
                          jobId: gig.id,
                          title: gig.title,
                          company: gig.client?.profile.firstName ?? 'Cliente',
                          salary: salaryText,
                          location: gig.category,
                          tags: [
                            gig.type == 'fixed_price' ? 'Proyecto fijo' : 'Por hora',
                            experienceText,
                            if (gig.isUrgent) 'Urgente',
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => JobDetailScreen(jobId: gig.id),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    childCount: gigsState.gigs.length + (gigsState.isLoading ? 1 : 0),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _searchController.clear();
          ref.read(gigsProvider.notifier).refresh();
        },
        label: const Text('Actualizar'),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}


