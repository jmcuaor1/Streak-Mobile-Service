import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/job_creation_model.dart';
import '../../providers/job_creation_provider.dart';
import '../../providers/job_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../services/notification_service.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/job_creation/job_creation_widgets.dart';

/// Pantalla mejorada de creación de trabajos
class CreateJobScreen extends ConsumerStatefulWidget {
  const CreateJobScreen({super.key});

  @override
  ConsumerState<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends ConsumerState<CreateJobScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Diferir la inicialización para evitar el error de Riverpod
    Future.microtask(() {
      ref.read(jobCreationProvider.notifier).initializeJobCreation();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobCreation = ref.watch(jobCreationProvider);
    final jobCreationNotifier = ref.read(jobCreationProvider.notifier);
    final steps = ref.watch(jobCreationStepsProvider);
    final progress = ref.watch(jobCreationProgressProvider);

    if (jobCreation == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Trabajo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveDraft,
            child: Text(
              'Guardar Borrador',
              style: TextStyle(
                color: _isLoading ? AppColors.grey400 : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Indicador de progreso
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                JobCreationStepIndicator(
                  steps: steps,
                  currentStep: _currentStep,
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.grey200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ],
            ),
          ),
          
          // Contenido de los pasos
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildBasicInfoStep(jobCreation, jobCreationNotifier),
                _buildJobDetailsStep(jobCreation, jobCreationNotifier),
                _buildBudgetStep(jobCreation, jobCreationNotifier),
                _buildLocationStep(jobCreation, jobCreationNotifier),
                _buildReviewStep(jobCreation, jobCreationNotifier),
              ],
            ),
          ),
          
          // Navegación
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep(JobCreationModel job, JobCreationNotifier notifier) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          TextFormField(
            initialValue: job.title,
            decoration: const InputDecoration(
              labelText: 'Título del Trabajo *',
              hintText: 'Ej: Desarrollador Flutter para app móvil',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work_outline),
            ),
            onChanged: notifier.updateTitle,
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
          
          const SizedBox(height: 20),
          
          // Descripción
          TextFormField(
            initialValue: job.description,
            decoration: const InputDecoration(
              labelText: 'Descripción del Trabajo *',
              hintText: 'Describe detalladamente el trabajo que necesitas...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description_outlined),
            ),
            maxLines: 6,
            onChanged: notifier.updateDescription,
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
          
          const SizedBox(height: 20),
          
          // Categoría
          DropdownButtonFormField<String>(
            initialValue: job.category,
            decoration: const InputDecoration(
              labelText: 'Categoría *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.category_outlined),
            ),
            items: JobCategory.categories.map((category) {
              return DropdownMenuItem(
                value: category.name,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                notifier.updateCategory(value);
                notifier.updateSubcategory(null);
              }
            },
          ),
          
          const SizedBox(height: 20),
          
          // Subcategoría
          if (JobCategory.getByName(job.category)?.subcategories.isNotEmpty == true)
            DropdownButtonFormField<String>(
              initialValue: job.subcategory,
              decoration: const InputDecoration(
                labelText: 'Subcategoría',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.subdirectory_arrow_right),
              ),
              items: JobCategory.getByName(job.category)?.subcategories.map((subcategory) {
                return DropdownMenuItem(
                  value: subcategory,
                  child: Text(subcategory),
                );
              }).toList(),
              onChanged: (value) {
                notifier.updateSubcategory(value);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildJobDetailsStep(JobCreationModel job, JobCreationNotifier notifier) {
    final category = JobCategory.getByName(job.category);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tipo de trabajo
          JobTypeSelector(
            selectedType: job.type,
            onChanged: notifier.updateJobType,
          ),
          
          const SizedBox(height: 24),
          
          // Nivel de experiencia
          ExperienceLevelSelector(
            selectedLevel: job.experienceLevel,
            onChanged: notifier.updateExperienceLevel,
          ),
          
          const SizedBox(height: 24),
          
          // Habilidades
          SkillsSelector(
            selectedSkills: job.skillsRequired,
            onChanged: notifier.updateSkills,
            availableSkills: category?.commonSkills ?? [],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetStep(JobCreationModel job, JobCreationNotifier notifier) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (job.type == JobType.fixedPrice) ...[
            BudgetInput(
              budget: job.budget,
              onChanged: notifier.updateBudget,
            ),
          ] else if (job.type == JobType.hourly) ...[
            HourlyRateInput(
              hourlyRate: job.hourlyRate,
              onChanged: notifier.updateHourlyRate,
            ),
          ] else ...[
            const Text(
              'Este tipo de trabajo no requiere presupuesto específico',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          
          const SizedBox(height: 24),
          
          // Duración estimada
          TextFormField(
            initialValue: job.estimatedDuration,
            decoration: const InputDecoration(
              labelText: 'Duración Estimada',
              hintText: 'Ej: 2 semanas, 1 mes, 3 meses',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.schedule),
            ),
            onChanged: notifier.updateEstimatedDuration,
          ),
          
          const SizedBox(height: 20),
          
          // Trabajo urgente
          CheckboxListTile(
            title: const Text('Trabajo Urgente'),
            subtitle: const Text('Marcar como trabajo urgente'),
            value: job.isUrgent,
            onChanged: (value) {
              notifier.updateIsUrgent(value ?? false);
            },
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep(JobCreationModel job, JobCreationNotifier notifier) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trabajo remoto
          CheckboxListTile(
            title: const Text('Trabajo Remoto'),
            subtitle: const Text('Este trabajo se puede realizar de forma remota'),
            value: job.isRemote,
            onChanged: (value) {
              notifier.updateIsRemote(value ?? false);
            },
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          
          const SizedBox(height: 20),
          
          // Ubicación (si no es remoto)
          if (!job.isRemote)
            TextFormField(
              initialValue: job.location,
              decoration: const InputDecoration(
                labelText: 'Ubicación *',
                hintText: 'Ciudad, País',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              onChanged: notifier.updateLocation,
            ),
          
          const SizedBox(height: 20),
          
          // Fecha límite
          InkWell(
            onTap: () => _selectDeadline(notifier),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Fecha Límite',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.event),
              ),
              child: Text(
                job.deadline != null
                    ? '${job.deadline!.day}/${job.deadline!.month}/${job.deadline!.year}'
                    : 'Seleccionar fecha',
                style: TextStyle(
                  color: job.deadline != null
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Requisitos adicionales
          TextFormField(
            initialValue: job.additionalRequirements,
            decoration: const InputDecoration(
              labelText: 'Requisitos Adicionales',
              hintText: 'Cualquier requisito adicional...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.note_add),
            ),
            maxLines: 3,
            onChanged: notifier.updateAdditionalRequirements,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep(JobCreationModel job, JobCreationNotifier notifier) {
    final errors = notifier.validationErrors;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resumen del trabajo
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Detalles
                  _buildReviewItem('Categoría', job.category),
                  if (job.subcategory != null)
                    _buildReviewItem('Subcategoría', job.subcategory!),
                  _buildReviewItem('Tipo', job.type.displayName),
                  _buildReviewItem('Experiencia', job.experienceLevel.displayName),
                  _buildReviewItem('Habilidades', job.skillsRequired.join(', ')),
                  
                  if (job.budget != null)
                    _buildReviewItem('Presupuesto', '\$${job.budget!.amount.toStringAsFixed(0)} ${job.budget!.currency}'),
                  
                  if (job.hourlyRate != null)
                    _buildReviewItem('Tarifa por Hora', '\$${job.hourlyRate!.minRate.toStringAsFixed(0)} - \$${job.hourlyRate!.maxRate.toStringAsFixed(0)} ${job.hourlyRate!.currency}/hora'),
                  
                  _buildReviewItem('Ubicación', job.isRemote ? 'Remoto' : job.location ?? 'No especificada'),
                  
                  if (job.estimatedDuration != null)
                    _buildReviewItem('Duración', job.estimatedDuration!),
                  
                  if (job.deadline != null)
                    _buildReviewItem('Fecha Límite', '${job.deadline!.day}/${job.deadline!.month}/${job.deadline!.year}'),
                  
                  if (job.isUrgent)
                    _buildReviewItem('Estado', 'Urgente'),
                ],
              ),
            ),
          ),
          
          // Errores de validación
          if (errors.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              color: AppColors.error.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Errores de Validación',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...errors.map((error) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $error',
                          style: const TextStyle(color: AppColors.error),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.grey200),
        ),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Anterior'),
              ),
            ),
          
          if (_currentStep > 0) const SizedBox(width: 16),
          
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(_currentStep == 4 ? 'Publicar Trabajo' : 'Siguiente'),
            ),
          ),
        ],
      ),
    );
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextStep() {
    if (_currentStep < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _createJob();
    }
  }

  Future<void> _selectDeadline(JobCreationNotifier notifier) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      notifier.updateDeadline(date);
    }
  }

  Future<void> _saveDraft() async {
    AppToast.showInfo(context, 'Funcionalidad de borrador próximamente');
  }

  Future<void> _createJob() async {
    final jobCreationNotifier = ref.read(jobCreationProvider.notifier);
    final errors = jobCreationNotifier.validationErrors;
    
    if (errors.isNotEmpty) {
      AppToast.showError(context, 'Por favor corrige los errores antes de continuar');
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

      final jobData = jobCreationNotifier.toJobData();
      jobData['clientId'] = user.id;

      // Crear trabajo usando el provider
      final success = await ref.read(jobProvider.notifier).createJob(jobData);
      
      if (success) {
        if (mounted) {
          // Mostrar notificación de éxito
          NotificationService.showSuccess(
            context,
            '¡Trabajo publicado exitosamente!',
          );
          
          // Incrementar racha por publicar trabajo
          ref.read(gamificationProvider.notifier).incrementStreak(
            activityType: 'job_posted',
          );
          
          // Mostrar notificación de racha después de un breve delay
          Future.delayed(const Duration(milliseconds: 500), () {
            NotificationService.showStreakNotification(
              context,
              ref.read(gamificationProvider.notifier).getStreakMessage(),
            );
          });
          
          jobCreationNotifier.clearJobCreation();
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
