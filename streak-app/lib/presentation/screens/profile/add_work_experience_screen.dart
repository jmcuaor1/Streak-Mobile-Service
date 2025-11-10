import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla para agregar/editar experiencia laboral
/// Basada en el diseño de Add work experience.jpg
class AddWorkExperienceScreen extends ConsumerStatefulWidget {
  const AddWorkExperienceScreen({super.key});

  @override
  ConsumerState<AddWorkExperienceScreen> createState() => _AddWorkExperienceScreenState();
}

class _AddWorkExperienceScreenState extends ConsumerState<AddWorkExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentJob = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
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

  Future<void> _saveExperience() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_startDate == null) {
      AppToast.showError(context, 'La fecha de inicio es requerida');
      return;
    }

    if (!_isCurrentJob && _endDate == null) {
      AppToast.showError(context, 'La fecha de finalización es requerida');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular guardado de experiencia
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        AppToast.showSuccess(context, 'Experiencia laboral guardada exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al guardar la experiencia: ${e.toString()}');
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
        title: const Text('Agregar Experiencia Laboral'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveExperience,
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
                    controller: _companyController,
                    label: 'Nombre de la empresa',
                    hint: 'Ej: Google, Microsoft, StartupXYZ',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre de la empresa es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _positionController,
                    label: 'Posición/Cargo',
                    hint: 'Ej: Desarrollador Full Stack, Product Manager',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La posición es requerida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _locationController,
                    label: 'Ubicación',
                    hint: 'Ej: Bogotá, Colombia / Remoto',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La ubicación es requerida';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Fechas
              _buildSection(
                'Período de Trabajo',
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
                          onTap: _isCurrentJob ? null : () => _selectDate(context, false),
                          enabled: !_isCurrentJob,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Trabajo actual'),
                    subtitle: const Text('Marco si actualmente trabajo aquí'),
                    value: _isCurrentJob,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentJob = value;
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

              // Descripción
              _buildSection(
                'Descripción del Trabajo',
                [
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Descripción de responsabilidades',
                    hint: 'Describe tus principales responsabilidades y logros en este trabajo...',
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La descripción es requerida';
                      }
                      if (value.trim().length < 50) {
                        return 'La descripción debe tener al menos 50 caracteres';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveExperience,
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
                          'Guardar Experiencia',
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
}
