import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/job_creation_model.dart';

class JobCreationStepIndicator extends StatelessWidget {
  final List<JobCreationStep> steps;
  final int currentStep;
  final VoidCallback? onStepTap;

  const JobCreationStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.onStepTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        children: [
          Row(
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isActive = index == currentStep;
              final isCompleted = index < currentStep;
              final isLast = index == steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    // Círculo del paso
                    GestureDetector(
                      onTap: onStepTap,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppColors.success
                              : isActive
                                  ? AppColors.primary
                                  : AppColors.grey300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted
                              ? Icons.check
                              : isActive
                                  ? Icons.edit
                                  : Icons.circle,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    
                    // Línea conectora
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted
                              ? AppColors.success
                              : AppColors.grey300,
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 12),
          
          // Información del paso actual
          if (currentStep < steps.length)
            Text(
              steps[currentStep].title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          if (currentStep < steps.length)
            Text(
              steps[currentStep].description,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}

class JobTypeSelector extends StatelessWidget {
  final JobType selectedType;
  final ValueChanged<JobType> onChanged;

  const JobTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: JobType.values.map((type) {
            final isSelected = selectedType == type;
            return GestureDetector(
              onTap: () => onChanged(type),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.grey300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ExperienceLevelSelector extends StatelessWidget {
  final ExperienceLevel selectedLevel;
  final ValueChanged<ExperienceLevel> onChanged;

  const ExperienceLevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nivel de Experiencia *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...ExperienceLevel.values.map((level) {
          final isSelected = selectedLevel == level;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RadioListTile<ExperienceLevel>(
              value: level,
              groupValue: selectedLevel,
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
              title: Text(
                level.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                level.description,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            ),
          );
        }),
      ],
    );
  }
}

class SkillsSelector extends StatelessWidget {
  final List<String> selectedSkills;
  final ValueChanged<List<String>> onChanged;
  final List<String> availableSkills;

  const SkillsSelector({
    super.key,
    required this.selectedSkills,
    required this.onChanged,
    required this.availableSkills,
  });

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 12),
        
        // Habilidades seleccionadas
        if (selectedSkills.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedSkills.map((skill) {
              return Chip(
                label: Text(skill),
                onDeleted: () {
                  final newSkills = List<String>.from(selectedSkills);
                  newSkills.remove(skill);
                  onChanged(newSkills);
                },
                deleteIcon: const Icon(Icons.close, size: 16),
                backgroundColor: AppColors.primary.withOpacity(0.1),
                labelStyle: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
        
        // Habilidades disponibles
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableSkills.where((skill) => !selectedSkills.contains(skill)).map((skill) {
            return FilterChip(
              label: Text(skill),
              selected: false,
              onSelected: (selected) {
                if (selected) {
                  final newSkills = List<String>.from(selectedSkills);
                  newSkills.add(skill);
                  onChanged(newSkills);
                }
              },
              selectedColor: AppColors.primary.withOpacity(0.2),
              checkmarkColor: AppColors.primary,
            );
          }).toList(),
        ),
        
        if (selectedSkills.isEmpty)
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
}

class BudgetInput extends StatelessWidget {
  final BudgetInfo? budget;
  final ValueChanged<BudgetInfo?> onChanged;

  const BudgetInput({
    super.key,
    required this.budget,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Presupuesto *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: budget?.amount.toString(),
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  hintText: '0',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final amount = double.tryParse(value);
                  if (amount != null) {
                    onChanged(BudgetInfo(
                      amount: amount,
                      currency: 'COP',
                      isNegotiable: budget?.isNegotiable ?? false,
                    ));
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: budget?.currency ?? 'COP',
                decoration: const InputDecoration(
                  labelText: 'Moneda',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'COP', child: Text('COP')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                ],
                onChanged: (value) {
                  if (value != null && budget != null) {
                    onChanged(budget!.copyWith(currency: value));
                  }
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        CheckboxListTile(
          title: const Text('Presupuesto negociable'),
          subtitle: const Text('Permitir negociación del presupuesto'),
          value: budget?.isNegotiable ?? false,
          onChanged: (value) {
            if (budget != null) {
              onChanged(budget!.copyWith(isNegotiable: value ?? false));
            }
          },
          activeColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class HourlyRateInput extends StatelessWidget {
  final HourlyRateInfo? hourlyRate;
  final ValueChanged<HourlyRateInfo?> onChanged;

  const HourlyRateInput({
    super.key,
    required this.hourlyRate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tarifa por Hora *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: hourlyRate?.minRate.toString(),
                decoration: const InputDecoration(
                  labelText: 'Tarifa Mínima',
                  hintText: '0',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final minRate = double.tryParse(value);
                  if (minRate != null) {
                    onChanged(HourlyRateInfo(
                      minRate: minRate,
                      maxRate: hourlyRate?.maxRate ?? minRate,
                      currency: hourlyRate?.currency ?? 'COP',
                      isNegotiable: hourlyRate?.isNegotiable ?? false,
                    ));
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                initialValue: hourlyRate?.maxRate.toString(),
                decoration: const InputDecoration(
                  labelText: 'Tarifa Máxima',
                  hintText: '0',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final maxRate = double.tryParse(value);
                  if (maxRate != null && hourlyRate != null) {
                    onChanged(hourlyRate!.copyWith(maxRate: maxRate));
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: hourlyRate?.currency ?? 'COP',
                decoration: const InputDecoration(
                  labelText: 'Moneda',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'COP', child: Text('COP')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                ],
                onChanged: (value) {
                  if (value != null && hourlyRate != null) {
                    onChanged(hourlyRate!.copyWith(currency: value));
                  }
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        CheckboxListTile(
          title: const Text('Tarifa negociable'),
          subtitle: const Text('Permitir negociación de la tarifa'),
          value: hourlyRate?.isNegotiable ?? false,
          onChanged: (value) {
            if (hourlyRate != null) {
              onChanged(hourlyRate!.copyWith(isNegotiable: value ?? false));
            }
          },
          activeColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
