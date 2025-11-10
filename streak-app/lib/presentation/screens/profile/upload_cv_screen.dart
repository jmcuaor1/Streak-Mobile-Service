import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/cv_model.dart';
import '../../providers/cv_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/cv/cv_widgets.dart';

/// Pantalla para subir CV/currículum
/// Basada en el diseño de Upload CV.jpg y Upload CV-1.jpg
class UploadCVScreen extends ConsumerStatefulWidget {
  const UploadCVScreen({super.key});

  @override
  ConsumerState<UploadCVScreen> createState() => _UploadCVScreenState();
}

class _UploadCVScreenState extends ConsumerState<UploadCVScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fileNameController = TextEditingController();
  
  String? _selectedFile;
  String _selectedFileType = 'pdf';
  bool _isPublic = true;
  bool _isDefault = false;
  bool _isLoading = false;

  final List<String> _fileTypes = [
    'pdf',
    'doc',
    'docx',
  ];

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }

  Future<void> _selectFile() async {
    try {
      // Simular selección de archivo
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _selectedFile = 'mi_curriculum_2024.pdf';
        _fileNameController.text = 'Mi Currículum 2024';
      });
      
      AppToast.showSuccess(context, 'Archivo seleccionado exitosamente');
    } catch (e) {
      AppToast.showError(context, 'Error al seleccionar el archivo');
    }
  }

  Future<void> _uploadCV() async {
    if (_selectedFile == null) {
      AppToast.showError(context, 'Por favor selecciona un archivo');
      return;
    }

    if (_fileNameController.text.trim().isEmpty) {
      AppToast.showError(context, 'El nombre del archivo es requerido');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular subida de archivo
      await Future.delayed(const Duration(seconds: 3));
      
      if (mounted) {
        // Crear nuevo CV y agregarlo al provider
        final newCV = CVModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          fileName: _selectedFile!,
          originalName: _fileNameController.text.trim(),
          fileType: _selectedFileType,
          fileUrl: '/uploads/cv/${_selectedFile!}',
          fileSize: 2048576, // Simular 2MB
          isPublic: _isPublic,
          isDefault: _isDefault,
          uploadedAt: DateTime.now(),
          description: 'CV subido desde la aplicación',
          tags: ['subido', 'nuevo'],
        );

        ref.read(cvProvider.notifier).addCV(newCV);
        
        AppToast.showSuccess(context, 'CV subido exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al subir el CV: ${e.toString()}');
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
        title: const Text('Subir CV'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _uploadCV,
            child: Text(
              'Subir',
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
              // Instrucciones
              _buildInstructions(),
              
              const SizedBox(height: 24),
              
              // Selección de archivo
              _buildFileSelection(),
              
              const SizedBox(height: 24),
              
              // Información del archivo
              if (_selectedFile != null) ...[
                _buildFileInfo(),
                const SizedBox(height: 24),
              ],
              
              // Configuración
              _buildConfiguration(),
              
              const SizedBox(height: 24),
              
              // Requisitos del archivo
              _buildFileRequirements(),
              
              const SizedBox(height: 32),
              
              // Botón de subir
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _uploadCV,
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
                          'Subir CV',
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

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.info,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Instrucciones',
                style: TextStyle(
                  color: AppColors.info,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Sube tu CV en formato PDF, DOC o DOCX. Asegúrate de que esté actualizado y contenga toda la información relevante sobre tu experiencia profesional.',
            style: TextStyle(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seleccionar archivo',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _selectFile,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedFile != null ? AppColors.success : AppColors.grey300,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _selectedFile != null ? Icons.check_circle : Icons.cloud_upload,
                  size: 40,
                  color: _selectedFile != null ? AppColors.success : AppColors.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedFile != null ? 'Archivo seleccionado' : 'Toca para seleccionar archivo',
                  style: TextStyle(
                    color: _selectedFile != null ? AppColors.success : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PDF, DOC, DOCX (máx. 10MB)',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información del archivo',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _fileNameController,
          decoration: InputDecoration(
            labelText: 'Nombre del archivo',
            hintText: 'Ej: Mi Currículum 2024',
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
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'El nombre del archivo es requerido';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _selectedFileType,
          decoration: InputDecoration(
            labelText: 'Tipo de archivo',
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
          items: _fileTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedFileType = value ?? 'pdf';
            });
          },
        ),
      ],
    );
  }

  Widget _buildConfiguration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuración',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('CV público'),
          subtitle: const Text('Permitir que otros usuarios vean tu CV'),
          value: _isPublic,
          onChanged: (value) {
            setState(() {
              _isPublic = value;
            });
          },
          activeThumbColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile(
          title: const Text('CV por defecto'),
          subtitle: const Text('Usar este CV como principal'),
          value: _isDefault,
          onChanged: (value) {
            setState(() {
              _isDefault = value;
            });
          },
          activeThumbColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildFileRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requisitos del archivo',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _buildRequirementItem(
          Icons.check_circle,
          'Formato: PDF, DOC o DOCX',
          AppColors.success,
        ),
        _buildRequirementItem(
          Icons.check_circle,
          'Tamaño máximo: 10MB',
          AppColors.success,
        ),
        _buildRequirementItem(
          Icons.check_circle,
          'Información actualizada',
          AppColors.success,
        ),
        _buildRequirementItem(
          Icons.check_circle,
          'Sin contraseña de protección',
          AppColors.success,
        ),
      ],
    );
  }

  Widget _buildRequirementItem(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
