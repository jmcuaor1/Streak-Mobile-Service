import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla para agregar/editar currículum
/// Basada en el diseño de Add Resume.jpg y Add Resume V2.jpg
class AddResumeScreen extends ConsumerStatefulWidget {
  const AddResumeScreen({super.key});

  @override
  ConsumerState<AddResumeScreen> createState() => _AddResumeScreenState();
}

class _AddResumeScreenState extends ConsumerState<AddResumeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  
  String _selectedResumeType = 'professional';
  bool _isDefault = false;
  bool _isPublic = true;
  bool _isLoading = false;

  final List<String> _resumeTypes = [
    'professional',
    'creative',
    'academic',
    'technical',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  Future<void> _saveResume() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular guardado de currículum
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        AppToast.showSuccess(context, 'Currículum guardado exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al guardar el currículum: ${e.toString()}');
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Currículum'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveResume,
            child: Text(
              'Guardar',
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
              // Información básica
              _buildSection(
                'Información Básica',
                [
                  _buildTextField(
                    controller: _titleController,
                    label: 'Título del Currículum',
                    hint: 'Ej: Currículum Profesional - Desarrollador Full Stack',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El título es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _summaryController,
                    label: 'Resumen Profesional',
                    hint: 'Describe brevemente tu experiencia y habilidades principales...',
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El resumen es requerido';
                      }
                      if (value.trim().length < 50) {
                        return 'El resumen debe tener al menos 50 caracteres';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Tipo de currículum
              _buildSection(
                'Tipo de Currículum',
                [
                  _buildDropdownField(
                    value: _selectedResumeType,
                    label: 'Selecciona el tipo',
                    items: _resumeTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_getResumeTypeText(type)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedResumeType = value ?? 'professional';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Configuración
              _buildSection(
                'Configuración',
                [
                  _buildSwitchTile(
                    title: 'Currículum por defecto',
                    subtitle: 'Usar este currículum como principal',
                    value: _isDefault,
                    onChanged: (value) {
                      setState(() {
                        _isDefault = value;
                      });
                    },
                  ),
                  _buildSwitchTile(
                    title: 'Perfil público',
                    subtitle: 'Permitir que otros usuarios vean tu currículum',
                    value: _isPublic,
                    onChanged: (value) {
                      setState(() {
                        _isPublic = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Secciones del currículum
              _buildSection(
                'Secciones del Currículum',
                [
                  _buildResumeSectionCard(
                    icon: Icons.work_outline,
                    title: 'Experiencia Laboral',
                    subtitle: 'Agrega tu experiencia profesional',
                    onTap: () {
                      Navigator.pushNamed(context, '/add-work-experience');
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildResumeSectionCard(
                    icon: Icons.school_outlined,
                    title: 'Educación',
                    subtitle: 'Agrega tu formación académica',
                    onTap: () {
                      Navigator.pushNamed(context, '/add-education');
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildResumeSectionCard(
                    icon: Icons.star_outline,
                    title: 'Habilidades',
                    subtitle: 'Agrega tus habilidades técnicas y blandas',
                    onTap: () {
                      Navigator.pushNamed(context, '/add-skill');
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildResumeSectionCard(
                    icon: Icons.language_outlined,
                    title: 'Idiomas',
                    subtitle: 'Agrega los idiomas que dominas',
                    onTap: () {
                      Navigator.pushNamed(context, '/add-language');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveResume,
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
                          'Guardar Currículum',
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
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.textSecondary,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildResumeSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  String _getResumeTypeText(String type) {
    switch (type) {
      case 'professional':
        return 'Profesional';
      case 'creative':
        return 'Creativo';
      case 'academic':
        return 'Académico';
      case 'technical':
        return 'Técnico';
      default:
        return type;
    }
  }
}
