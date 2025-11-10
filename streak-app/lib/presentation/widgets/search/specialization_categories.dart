import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Widget para mostrar categorías de especialización
/// Basado en el diseño de Specialization.jpg
class SpecializationCategories extends StatelessWidget {
  const SpecializationCategories({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
  });

  final List<SpecializationCategory> categories;
  final String? selectedCategory;
  final ValueChanged<String>? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Especializaciones',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        
        // Grid de categorías simplificado
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category.id;
              
              return GestureDetector(
                onTap: () => onCategorySelected?.call(category.id),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? AppColors.primary
                          : AppColors.grey200,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ícono de la categoría
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.primary
                                : AppColors.grey100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            category.icon,
                            color: isSelected 
                                ? Colors.white
                                : AppColors.grey600,
                            size: 24,
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Nombre de la categoría
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected 
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Contador de trabajos
                        if (category.jobCount != null)
                          Text(
                            '${category.jobCount} trabajos',
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected 
                                  ? AppColors.primary.withOpacity(0.7)
                                  : AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        
                        const SizedBox(height: 8),
                        
                        // Indicador de selección
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Modelo para categorías de especialización
class SpecializationCategory {
  final String id;
  final String name;
  final IconData icon;
  final int? jobCount;
  final String? description;

  const SpecializationCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.jobCount,
    this.description,
  });
}

/// Lista predefinida de categorías de especialización
class SpecializationCategoriesData {
  static const List<SpecializationCategory> categories = [
    SpecializationCategory(
      id: 'web_development',
      name: 'Desarrollo Web',
      icon: Icons.web,
      jobCount: 245,
    ),
    SpecializationCategory(
      id: 'mobile_development',
      name: 'Desarrollo Móvil',
      icon: Icons.phone_android,
      jobCount: 189,
    ),
    SpecializationCategory(
      id: 'ui_ux_design',
      name: 'UI/UX Design',
      icon: Icons.design_services,
      jobCount: 156,
    ),
    SpecializationCategory(
      id: 'graphic_design',
      name: 'Diseño Gráfico',
      icon: Icons.palette,
      jobCount: 134,
    ),
    SpecializationCategory(
      id: 'digital_marketing',
      name: 'Marketing Digital',
      icon: Icons.trending_up,
      jobCount: 298,
    ),
    SpecializationCategory(
      id: 'content_writing',
      name: 'Escritura de Contenido',
      icon: Icons.edit,
      jobCount: 167,
    ),
    SpecializationCategory(
      id: 'data_analysis',
      name: 'Análisis de Datos',
      icon: Icons.analytics,
      jobCount: 89,
    ),
    SpecializationCategory(
      id: 'photography',
      name: 'Fotografía',
      icon: Icons.camera_alt,
      jobCount: 76,
    ),
    SpecializationCategory(
      id: 'video_editing',
      name: 'Edición de Video',
      icon: Icons.videocam,
      jobCount: 54,
    ),
    SpecializationCategory(
      id: 'translation',
      name: 'Traducción',
      icon: Icons.translate,
      jobCount: 43,
    ),
    SpecializationCategory(
      id: 'virtual_assistant',
      name: 'Asistente Virtual',
      icon: Icons.support_agent,
      jobCount: 98,
    ),
    SpecializationCategory(
      id: 'customer_service',
      name: 'Atención al Cliente',
      icon: Icons.headset_mic,
      jobCount: 67,
    ),
    SpecializationCategory(
      id: 'sales',
      name: 'Ventas',
      icon: Icons.sell,
      jobCount: 123,
    ),
    SpecializationCategory(
      id: 'accounting',
      name: 'Contabilidad',
      icon: Icons.calculate,
      jobCount: 45,
    ),
    SpecializationCategory(
      id: 'legal',
      name: 'Servicios Legales',
      icon: Icons.gavel,
      jobCount: 32,
    ),
    SpecializationCategory(
      id: 'consulting',
      name: 'Consultoría',
      icon: Icons.business_center,
      jobCount: 78,
    ),
  ];
}