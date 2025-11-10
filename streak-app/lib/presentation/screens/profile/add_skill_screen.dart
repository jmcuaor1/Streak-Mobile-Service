import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla para agregar/editar habilidades
/// Basada en el diseño de Add Skill.jpg y Add Skill-1.jpg
class AddSkillScreen extends ConsumerStatefulWidget {
  const AddSkillScreen({super.key});

  @override
  ConsumerState<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends ConsumerState<AddSkillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _skillController = TextEditingController();
  
  String _selectedCategory = 'technical';
  String _selectedLevel = 'intermediate';
  bool _isLoading = false;

  final List<String> _categories = [
    'technical',
    'soft',
    'language',
    'certification',
    'tool',
  ];

  final List<String> _levels = [
    'beginner',
    'intermediate',
    'advanced',
    'expert',
  ];

  final List<Map<String, dynamic>> _suggestedSkills = [
    {'name': 'JavaScript', 'category': 'technical'},
    {'name': 'Python', 'category': 'technical'},
    {'name': 'React', 'category': 'technical'},
    {'name': 'Node.js', 'category': 'technical'},
    {'name': 'Flutter', 'category': 'technical'},
    {'name': 'Dart', 'category': 'technical'},
    {'name': 'Comunicación', 'category': 'soft'},
    {'name': 'Liderazgo', 'category': 'soft'},
    {'name': 'Trabajo en equipo', 'category': 'soft'},
    {'name': 'Resolución de problemas', 'category': 'soft'},
    {'name': 'Inglés', 'category': 'language'},
    {'name': 'Español', 'category': 'language'},
    {'name': 'Francés', 'category': 'language'},
    {'name': 'Portugués', 'category': 'language'},
  ];

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  Future<void> _addSkill() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular agregado de habilidad
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        AppToast.showSuccess(context, 'Habilidad agregada exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al agregar la habilidad: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Habilidad'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _addSkill,
            child: Text(
              'Agregar',
              style: TextStyle(
                color: _isLoading ? AppColors.grey400 : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Formulario principal
              _buildSection(
                'Información de la Habilidad',
                [
                  _buildTextField(
                    controller: _skillController,
                    label: 'Nombre de la habilidad',
                    hint: 'Ej: JavaScript, Comunicación, Inglés',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre de la habilidad es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    value: _selectedCategory,
                    label: 'Categoría',
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(_getCategoryText(category)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value ?? 'technical';
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    value: _selectedLevel,
                    label: 'Nivel de competencia',
                    items: _levels.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(_getLevelText(level)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value ?? 'intermediate';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Habilidades sugeridas
              _buildSection(
                'Habilidades Sugeridas',
                [
                  Text(
                    'Toca una habilidad para agregarla rápidamente',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _suggestedSkills.map((skill) {
                      return _buildSuggestedSkillChip(skill);
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botón de agregar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _addSkill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
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
                          'Agregar Habilidad',
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
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String label,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _buildSuggestedSkillChip(Map<String, dynamic> skill) {
    return GestureDetector(
      onTap: () {
        _skillController.text = skill['name'];
        setState(() {
          _selectedCategory = skill['category'];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
          ),
        ),
        child: Text(
          skill['name'],
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  String _getCategoryText(String category) {
    switch (category) {
      case 'technical':
        return 'Técnica';
      case 'soft':
        return 'Blanda';
      case 'language':
        return 'Idioma';
      case 'certification':
        return 'Certificación';
      case 'tool':
        return 'Herramienta';
      default:
        return category;
    }
  }

  String _getLevelText(String level) {
    switch (level) {
      case 'beginner':
        return 'Principiante';
      case 'intermediate':
        return 'Intermedio';
      case 'advanced':
        return 'Avanzado';
      case 'expert':
        return 'Experto';
      default:
        return level;
    }
  }
}
