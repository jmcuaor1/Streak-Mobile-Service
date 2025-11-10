import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla para agregar/editar educación
/// Basada en el diseño de Add Education.jpg
class AddEducationScreen extends ConsumerStatefulWidget {
  const AddEducationScreen({super.key});

  @override
  ConsumerState<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends ConsumerState<AddEducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _fieldOfStudyController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedLevel = 'bachelor';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentlyStudying = false;
  bool _isLoading = false;

  final List<String> _educationLevels = [
    'high_school',
    'associate',
    'bachelor',
    'master',
    'phd',
    'certificate',
    'diploma',
  ];

  @override
  void dispose() {
    _institutionController.dispose();
    _fieldOfStudyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(1990),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _saveEducation() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_startDate == null) {
      AppToast.showError(context, 'La fecha de inicio es requerida');
      return;
    }

    if (!_isCurrentlyStudying && _endDate == null) {
      AppToast.showError(context, 'La fecha de finalización es requerida');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular guardado de educación
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        AppToast.showSuccess(context, 'Educación guardada exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al guardar la educación: ${e.toString()}');
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
        title: const Text('Agregar Educación'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveEducation,
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
                'Información Académica',
                [
                  _buildTextField(
                    controller: _institutionController,
                    label: 'Nombre de la institución',
                    hint: 'Ej: Universidad Nacional, MIT, Harvard',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre de la institución es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _fieldOfStudyController,
                    label: 'Campo de estudio',
                    hint: 'Ej: Ingeniería de Sistemas, Administración de Empresas',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El campo de estudio es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    value: _selectedLevel,
                    label: 'Nivel de educación',
                    items: _educationLevels.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(_getEducationLevelText(level)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value ?? 'bachelor';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Fechas
              _buildSection(
                'Período de Estudios',
                [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          label: 'Fecha de inicio',
                          value: _startDate,
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateField(
                          label: 'Fecha de finalización',
                          value: _endDate,
                          onTap: _isCurrentlyStudying ? null : () => _selectDate(context, false),
                          enabled: !_isCurrentlyStudying,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Actualmente estudiando'),
                    subtitle: const Text('Marco si actualmente estoy estudiando aquí'),
                    value: _isCurrentlyStudying,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentlyStudying = value;
                        if (value) {
                          _endDate = null;
                        }
                      });
                    },
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Descripción adicional
              _buildSection(
                'Información Adicional',
                [
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Descripción adicional (opcional)',
                    hint: 'Menciona logros académicos, proyectos relevantes, GPA, etc.',
                    maxLines: 4,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveEducation,
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
                          'Guardar Educación',
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

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: enabled ? AppColors.cardBackground : AppColors.grey100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled ? AppColors.grey300 : AppColors.grey200,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: enabled ? AppColors.textSecondary : AppColors.grey400,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value != null 
                  ? '${value.day}/${value.month}/${value.year}'
                  : 'Seleccionar fecha',
              style: TextStyle(
                fontSize: 16,
                color: enabled 
                    ? (value != null ? AppColors.textPrimary : AppColors.grey400)
                    : AppColors.grey400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEducationLevelText(String level) {
    switch (level) {
      case 'high_school':
        return 'Bachillerato';
      case 'associate':
        return 'Técnico/Tecnólogo';
      case 'bachelor':
        return 'Pregrado';
      case 'master':
        return 'Maestría';
      case 'phd':
        return 'Doctorado';
      case 'certificate':
        return 'Certificado';
      case 'diploma':
        return 'Diplomado';
      default:
        return level;
    }
  }
}
