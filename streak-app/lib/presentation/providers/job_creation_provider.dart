import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/job_creation_model.dart';

class JobCreationNotifier extends Notifier<JobCreationModel?> {
  @override
  JobCreationModel? build() {
    return null;
  }

  void initializeJobCreation() {
    state = const JobCreationModel(
      title: '',
      description: '',
      category: 'Desarrollo Web',
      type: JobType.fixedPrice,
      skillsRequired: [],
      experienceLevel: ExperienceLevel.intermediate,
    );
  }

  void updateTitle(String title) {
    if (state != null) {
      state = state!.copyWith(title: title);
    }
  }

  void updateDescription(String description) {
    if (state != null) {
      state = state!.copyWith(description: description);
    }
  }

  void updateCategory(String category) {
    if (state != null) {
      state = state!.copyWith(category: category);
    }
  }

  void updateSubcategory(String? subcategory) {
    if (state != null) {
      state = state!.copyWith(subcategory: subcategory);
    }
  }

  void updateJobType(JobType type) {
    if (state != null) {
      state = state!.copyWith(type: type);
    }
  }

  void updateExperienceLevel(ExperienceLevel level) {
    if (state != null) {
      state = state!.copyWith(experienceLevel: level);
    }
  }

  void addSkill(String skill) {
    if (state != null) {
      final skills = List<String>.from(state!.skillsRequired);
      if (!skills.contains(skill)) {
        skills.add(skill);
        state = state!.copyWith(skillsRequired: skills);
      }
    }
  }

  void removeSkill(String skill) {
    if (state != null) {
      final skills = List<String>.from(state!.skillsRequired);
      skills.remove(skill);
      state = state!.copyWith(skillsRequired: skills);
    }
  }

  void updateSkills(List<String> skills) {
    if (state != null) {
      state = state!.copyWith(skillsRequired: skills);
    }
  }

  void updateBudget(BudgetInfo? budget) {
    if (state != null) {
      state = state!.copyWith(budget: budget);
    }
  }

  void updateHourlyRate(HourlyRateInfo? hourlyRate) {
    if (state != null) {
      state = state!.copyWith(hourlyRate: hourlyRate);
    }
  }

  void updateLocation(String? location) {
    if (state != null) {
      state = state!.copyWith(location: location);
    }
  }

  void updateIsRemote(bool isRemote) {
    if (state != null) {
      state = state!.copyWith(isRemote: isRemote);
    }
  }

  void updateIsUrgent(bool isUrgent) {
    if (state != null) {
      state = state!.copyWith(isUrgent: isUrgent);
    }
  }

  void updateEstimatedDuration(String? duration) {
    if (state != null) {
      state = state!.copyWith(estimatedDuration: duration);
    }
  }

  void updateDeadline(DateTime? deadline) {
    if (state != null) {
      state = state!.copyWith(deadline: deadline);
    }
  }

  void updateAdditionalRequirements(String? requirements) {
    if (state != null) {
      state = state!.copyWith(additionalRequirements: requirements);
    }
  }

  void addTag(String tag) {
    if (state != null) {
      final tags = List<String>.from(state!.tags);
      if (!tags.contains(tag)) {
        tags.add(tag);
        state = state!.copyWith(tags: tags);
      }
    }
  }

  void removeTag(String tag) {
    if (state != null) {
      final tags = List<String>.from(state!.tags);
      tags.remove(tag);
      state = state!.copyWith(tags: tags);
    }
  }

  void updateTags(List<String> tags) {
    if (state != null) {
      state = state!.copyWith(tags: tags);
    }
  }

  void addAttachment(String attachment) {
    if (state != null) {
      final attachments = List<String>.from(state!.attachments);
      if (!attachments.contains(attachment)) {
        attachments.add(attachment);
        state = state!.copyWith(attachments: attachments);
      }
    }
  }

  void removeAttachment(String attachment) {
    if (state != null) {
      final attachments = List<String>.from(state!.attachments);
      attachments.remove(attachment);
      state = state!.copyWith(attachments: attachments);
    }
  }

  void clearJobCreation() {
    state = null;
  }

  bool get isJobValid {
    if (state == null) return false;
    
    return state!.title.isNotEmpty &&
           state!.description.isNotEmpty &&
           state!.skillsRequired.isNotEmpty &&
           (state!.budget != null || state!.hourlyRate != null);
  }

  List<String> get validationErrors {
    if (state == null) return ['No hay datos de trabajo'];
    
    final errors = <String>[];
    
    if (state!.title.isEmpty) {
      errors.add('El título es requerido');
    } else if (state!.title.length < 10) {
      errors.add('El título debe tener al menos 10 caracteres');
    }
    
    if (state!.description.isEmpty) {
      errors.add('La descripción es requerida');
    } else if (state!.description.length < 50) {
      errors.add('La descripción debe tener al menos 50 caracteres');
    }
    
    if (state!.skillsRequired.isEmpty) {
      errors.add('Se requiere al menos una habilidad');
    }
    
    if (state!.type == JobType.fixedPrice && state!.budget == null) {
      errors.add('El presupuesto es requerido para trabajos de precio fijo');
    }
    
    if (state!.type == JobType.hourly && state!.hourlyRate == null) {
      errors.add('La tarifa por hora es requerida para trabajos por hora');
    }
    
    if (!state!.isRemote && state!.location == null) {
      errors.add('La ubicación es requerida para trabajos presenciales');
    }
    
    return errors;
  }

  Map<String, dynamic> toJobData() {
    if (state == null) return {};
    
    final jobData = <String, dynamic>{
      'title': state!.title,
      'description': state!.description,
      'category': state!.category,
      'subcategory': state!.subcategory,
      'type': state!.type.value,
      'skillsRequired': state!.skillsRequired,
      'experienceLevel': state!.experienceLevel.value,
      'isUrgent': state!.isUrgent,
      'isRemote': state!.isRemote,
      'location': state!.location,
      'estimatedDuration': state!.estimatedDuration,
      'deadline': state!.deadline?.toIso8601String(),
      'additionalRequirements': state!.additionalRequirements,
      'tags': state!.tags,
      'attachments': state!.attachments,
      'status': state!.status,
    };
    
    if (state!.budget != null) {
      jobData['budget'] = {
        'amount': state!.budget!.amount,
        'currency': state!.budget!.currency,
        'isNegotiable': state!.budget!.isNegotiable,
      };
    }
    
    if (state!.hourlyRate != null) {
      jobData['hourlyRate'] = {
        'minRate': state!.hourlyRate!.minRate,
        'maxRate': state!.hourlyRate!.maxRate,
        'currency': state!.hourlyRate!.currency,
        'isNegotiable': state!.hourlyRate!.isNegotiable,
      };
    }
    
    return jobData;
  }
}

final jobCreationProvider = NotifierProvider<JobCreationNotifier, JobCreationModel?>(() {
  return JobCreationNotifier();
});

final jobCreationStepsProvider = Provider<List<JobCreationStep>>((ref) {
  return [
    const JobCreationStep(
      title: 'Información Básica',
      description: 'Título, descripción y categoría',
    ),
    const JobCreationStep(
      title: 'Detalles del Trabajo',
      description: 'Tipo, experiencia y habilidades',
    ),
    const JobCreationStep(
      title: 'Presupuesto',
      description: 'Precio fijo o tarifa por hora',
    ),
    const JobCreationStep(
      title: 'Ubicación y Duración',
      description: 'Ubicación, duración y fechas',
    ),
    const JobCreationStep(
      title: 'Revisión',
      description: 'Revisar y publicar trabajo',
    ),
  ];
});

final jobCreationProgressProvider = Provider<double>((ref) {
  final job = ref.watch(jobCreationProvider);
  if (job == null) return 0.0;
  
  int completedSteps = 0;
  
  // Paso 1: Información básica
  if (job.title.isNotEmpty && job.description.isNotEmpty && job.category.isNotEmpty) {
    completedSteps++;
  }
  
  // Paso 2: Detalles del trabajo
  if (job.skillsRequired.isNotEmpty) {
    completedSteps++;
  }
  
  // Paso 3: Presupuesto
  if (job.budget != null || job.hourlyRate != null) {
    completedSteps++;
  }
  
  // Paso 4: Ubicación y duración
  if (job.isRemote || job.location != null) {
    completedSteps++;
  }
  
  // Paso 5: Revisión (siempre disponible)
  completedSteps++;
  
  return completedSteps / 5.0;
});
