import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/job_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_toast.dart';

/// Pantalla de creación de trabajos
class CreateJobScreen extends ConsumerStatefulWidget {
  const CreateJobScreen({super.key});

  @override
  ConsumerState<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends ConsumerState<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _hourlyMinController = TextEditingController();
  final _hourlyMaxController = TextEditingController();
  final _durationController = TextEditingController();

  String _selectedCategory = 'Desarrollo Web';
  String _selectedSubcategory = '';
  String _selectedJobType = 'fixed_price';
  String _selectedExperienceLevel = 'intermediate';
  final List<String> _selectedSkills = [];
  bool _isUrgent = false;
  bool _isLoading = false;

  final List<String> _categories = [
    'Desarrollo Web',
    'Desarrollo Móvil',
    'Diseño Gráfico',
    'Marketing Digital',
    'Escritura y Traducción',
    'Datos y Análisis',
    'Consultoría',
    'Otros',
  ];

  final Map<String, List<String>> _subcategories = {
    'Desarrollo Web': ['Frontend', 'Backend', 'Full Stack', 'WordPress', 'E-commerce'],
    'Desarrollo Móvil': ['iOS', 'Android', 'React Native', 'Flutter', 'Híbrido'],
    'Diseño Gráfico': ['Logo', 'Branding', 'UI/UX', 'Ilustración', 'Fotografía'],
    'Marketing Digital': ['SEO', 'SEM', 'Redes Sociales', 'Email Marketing', 'Analytics'],
    'Escritura y Traducción': ['Artículos', 'Copywriting', 'Traducción', 'Edición', 'Blogs'],
    'Datos y Análisis': ['Análisis de Datos', 'Machine Learning', 'Business Intelligence', 'Estadística'],
    'Consultoría': ['Estrategia', 'Tecnología', 'Negocios', 'Finanzas', 'Recursos Humanos'],
    'Otros': ['Soporte Técnico', 'Administración', 'Ventas', 'Otros'],
  };

  final List<String> _skills = [
    'JavaScript', 'Python', 'React', 'Node.js', 'Flutter', 'Dart',
    'TypeScript', 'Vue.js', 'Angular', 'PHP', 'Laravel', 'Django',
    'MongoDB', 'PostgreSQL', 'MySQL', 'Redis', 'AWS', 'Docker',
    'Figma', 'Adobe XD', 'Sketch', 'Photoshop', 'Illustrator',
    'SEO', 'Google Analytics', 'Facebook Ads', 'Google Ads',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _hourlyMinController.dispose();
    _hourlyMaxController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Trabajo'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveDraft,
            child: Text(
              'Guardar Borrador',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información básica
              _buildSectionHeader('Información Básica'),
              const SizedBox(height: 16),
              
              // Título del trabajo
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título del Trabajo *',
                  hintText: 'Ej: Desarrollador Flutter para app móvil',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.work_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es requerido';
                  }
                  if (value.length < 10) {
                    return 'El título debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Descripción
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Descripción del Trabajo *',
                  hintText: 'Describe detalladamente qué necesitas...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La descripción es requerida';
                  }
                  if (value.length < 50) {
                    return 'La descripción debe tener al menos 50 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Categoría y tipo
              _buildSectionHeader('Categoría y Tipo'),
              const SizedBox(height: 16),

              // Categoría
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Categoría *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                    _selectedSubcategory = '';
                  });
                },
              ),
              const SizedBox(height: 16),

              // Subcategoría
              if (_subcategories[_selectedCategory] != null)
                DropdownButtonFormField<String>(
                  initialValue: _selectedSubcategory.isEmpty ? null : _selectedSubcategory,
                  decoration: InputDecoration(
                    labelText: 'Subcategoría',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.subdirectory_arrow_right),
                  ),
                  items: _subcategories[_selectedCategory]!.map((subcategory) {
                    return DropdownMenuItem(
                      value: subcategory,
                      child: Text(subcategory),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubcategory = value ?? '';
                    });
                  },
                ),
              const SizedBox(height: 16),

              // Tipo de trabajo
              _buildJobTypeSelector(),
              const SizedBox(height: 24),

              // Presupuesto
              _buildSectionHeader('Presupuesto'),
              const SizedBox(height: 16),

              if (_selectedJobType == 'fixed_price') ...[
                TextFormField(
                  controller: _budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Presupuesto Total (USD) *',
                    hintText: 'Ej: 5000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.attach_money),
                    suffixText: 'USD',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El presupuesto es requerido';
                    }
                    final budget = double.tryParse(value);
                    if (budget == null || budget <= 0) {
                      return 'Ingresa un presupuesto válido';
                    }
                    return null;
                  },
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _hourlyMinController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tarifa Mínima (USD/h)',
                          hintText: '25',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.trending_down),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final rate = double.tryParse(value);
                            if (rate == null || rate <= 0) {
                              return 'Tarifa inválida';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _hourlyMaxController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tarifa Máxima (USD/h)',
                          hintText: '50',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.trending_up),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final rate = double.tryParse(value);
                            if (rate == null || rate <= 0) {
                              return 'Tarifa inválida';
                            }
                            final minRate = double.tryParse(_hourlyMinController.text);
                            if (minRate != null && rate < minRate) {
                              return 'Debe ser mayor a la mínima';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),

              // Detalles del proyecto
              _buildSectionHeader('Detalles del Proyecto'),
              const SizedBox(height: 16),

              // Nivel de experiencia
              DropdownButtonFormField<String>(
                initialValue: _selectedExperienceLevel,
                decoration: InputDecoration(
                  labelText: 'Nivel de Experiencia Requerido',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.star_outline),
                ),
                items: const [
                  DropdownMenuItem(value: 'entry', child: Text('Principiante')),
                  DropdownMenuItem(value: 'intermediate', child: Text('Intermedio')),
                  DropdownMenuItem(value: 'expert', child: Text('Experto')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedExperienceLevel = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Duración estimada
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duración Estimada',
                  hintText: 'Ej: 2-4 semanas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.schedule),
                ),
              ),
              const SizedBox(height: 16),

              // Habilidades requeridas
              _buildSkillsSelector(),
              const SizedBox(height: 24),

              // Opciones adicionales
              _buildSectionHeader('Opciones Adicionales'),
              const SizedBox(height: 16),

              // Trabajo urgente
              SwitchListTile(
                title: const Text('Trabajo Urgente'),
                subtitle: const Text('Marcar como urgente para mayor visibilidad'),
                value: _isUrgent,
                onChanged: (value) {
                  setState(() {
                    _isUrgent = value;
                  });
                },
                activeThumbColor: AppColors.warning,
              ),
              const SizedBox(height: 32),

              // Botón de crear trabajo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createJob,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Crear Trabajo',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildJobTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de Trabajo *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Proyecto Fijo'),
                subtitle: const Text('Presupuesto total'),
                value: 'fixed_price',
                groupValue: _selectedJobType,
                onChanged: (value) {
                  setState(() {
                    _selectedJobType = value!;
                  });
                },
                activeColor: AppColors.primary,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Por Hora'),
                subtitle: const Text('Tarifa por hora'),
                value: 'hourly',
                groupValue: _selectedJobType,
                onChanged: (value) {
                  setState(() {
                    _selectedJobType = value!;
                  });
                },
                activeColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades Requeridas *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _skills.map((skill) {
            final isSelected = _selectedSkills.contains(skill);
            return FilterChip(
              label: Text(skill),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSkills.add(skill);
                  } else {
                    _selectedSkills.remove(skill);
                  }
                });
              },
              selectedColor: AppColors.primary.withOpacity(0.2),
              checkmarkColor: AppColors.primary,
            );
          }).toList(),
        ),
        if (_selectedSkills.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Selecciona al menos una habilidad',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _saveDraft() async {
    // TODO: Implementar guardado de borrador
    AppToast.showInfo(context, 'Funcionalidad de borrador próximamente');
  }

  Future<void> _createJob() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedSkills.isEmpty) {
      AppToast.showError(context, 'Selecciona al menos una habilidad');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        AppToast.showError(context, 'Usuario no autenticado');
        return;
      }

      final jobData = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'category': _selectedCategory,
        'subcategory': _selectedSubcategory.isNotEmpty ? _selectedSubcategory : null,
        'type': _selectedJobType,
        'skillsRequired': _selectedSkills,
        'experienceLevel': _selectedExperienceLevel,
        'estimatedDuration': _durationController.text.trim().isNotEmpty ? _durationController.text.trim() : null,
        'isUrgent': _isUrgent,
        'status': 'open',
      };

      // Agregar presupuesto según el tipo
      if (_selectedJobType == 'fixed_price') {
        final budget = double.parse(_budgetController.text);
        jobData['budget'] = budget;
      } else {
        final minRate = _hourlyMinController.text.isNotEmpty ? double.parse(_hourlyMinController.text) : null;
        final maxRate = _hourlyMaxController.text.isNotEmpty ? double.parse(_hourlyMaxController.text) : null;
        
        if (minRate != null || maxRate != null) {
          jobData['hourlyRate'] = {
            'min': minRate ?? 0,
            'max': maxRate ?? minRate ?? 0,
          };
        }
      }

      // Crear trabajo usando el provider
      final success = await ref.read(jobProvider.notifier).createJob(jobData);
      
      if (success) {
        if (mounted) {
          AppToast.showSuccess(context, 'Trabajo creado exitosamente');
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          final error = ref.read(jobProvider).error;
          AppToast.showError(context, error ?? 'Error al crear el trabajo');
        }
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al crear el trabajo: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
