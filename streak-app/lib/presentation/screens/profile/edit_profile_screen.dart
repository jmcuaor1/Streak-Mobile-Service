import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/skill_model.dart';
import '../../../data/models/work_experience_model.dart';
import '../../../data/models/education_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/profile/skill_card.dart';
import '../../widgets/profile/work_experience_card.dart';
import '../../widgets/profile/education_card.dart';
import 'add_skill_screen.dart';
import 'add_work_experience_screen.dart';
import 'add_education_screen.dart';

/// Pantalla de edición de perfil
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  bool _isLoading = false;
  
  // Mock data - en una app real esto vendría del backend
  List<Skill> _skills = [];
  List<WorkExperience> _workExperiences = [];
  List<Education> _educations = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadMockData();
  }

  void _loadUserData() {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      _firstNameController.text = user.profile.firstName;
      _lastNameController.text = user.profile.lastName;
      _phoneController.text = user.profile.phone ?? '';
      _bioController.text = user.profile.bio ?? '';
      
      if (user.profile.address != null) {
        _cityController.text = user.profile.address!.city ?? '';
        _stateController.text = user.profile.address!.state ?? '';
        _countryController.text = user.profile.address!.country ?? '';
      }
    }
  }

  void _loadMockData() {
    // Mock skills
    _skills = [
      const Skill(
        id: '1',
        name: 'JavaScript',
        category: SkillCategory.technical,
        level: SkillLevel.advanced,
        description: 'Desarrollo frontend y backend con JavaScript',
      ),
      const Skill(
        id: '2',
        name: 'React',
        category: SkillCategory.technical,
        level: SkillLevel.intermediate,
        description: 'Desarrollo de aplicaciones web con React',
      ),
      const Skill(
        id: '3',
        name: 'Comunicación',
        category: SkillCategory.soft,
        level: SkillLevel.advanced,
        description: 'Habilidades de comunicación verbal y escrita',
      ),
    ];

    // Mock work experiences
    _workExperiences = [
      WorkExperience(
        id: '1',
        companyName: 'TechCorp Solutions',
        position: 'Desarrollador Frontend Senior',
        description: 'Desarrollo de aplicaciones web modernas usando React, TypeScript y Node.js. Lideré un equipo de 3 desarrolladores.',
        startDate: DateTime(2022, 1),
        endDate: DateTime(2024, 6),
        location: 'Bogotá, Colombia',
        achievements: ['Mejoré el rendimiento en 40%', 'Implementé nuevas funcionalidades'],
      ),
      WorkExperience(
        id: '2',
        companyName: 'StartupXYZ',
        position: 'Desarrollador Full Stack',
        description: 'Desarrollo completo de aplicaciones web desde el diseño hasta la implementación.',
        startDate: DateTime(2020, 3),
        endDate: DateTime(2021, 12),
        location: 'Medellín, Colombia',
        achievements: ['Desarrollé 5 aplicaciones web', 'Mentor de nuevos desarrolladores'],
      ),
    ];

    // Mock educations
    _educations = [
      Education(
        id: '1',
        institutionName: 'Universidad Nacional de Colombia',
        fieldOfStudy: 'Ingeniería de Sistemas',
        level: EducationLevel.bachelor,
        startDate: DateTime(2016, 1),
        endDate: DateTime(2020, 12),
        location: 'Bogotá, Colombia',
        gpa: 4.2,
        description: 'Enfoque en desarrollo de software y arquitectura de sistemas',
      ),
      Education(
        id: '2',
        institutionName: 'Platzi',
        fieldOfStudy: 'Desarrollo Web',
        level: EducationLevel.certificate,
        startDate: DateTime(2019, 6),
        endDate: DateTime(2019, 12),
        description: 'Certificación en desarrollo web moderno',
      ),
    ];
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: Text(
              'Guardar',
              style: TextStyle(
                color: _isLoading ? AppColors.textSecondary : AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('Usuario no encontrado'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sección de información personal
                    _buildSectionHeader(context, 'Información Personal'),
                    const SizedBox(height: 16),
                    
                    // Avatar
                    _buildAvatarSection(context, user),
                    const SizedBox(height: 24),
                    
                    // Campos de texto
                    _buildTextField(
                      controller: _firstNameController,
                      label: 'Nombre',
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Apellido',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El apellido es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Teléfono',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _bioController,
                      label: 'Biografía',
                      icon: Icons.info,
                      maxLines: 3,
                      hintText: 'Cuéntanos sobre ti...',
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de ubicación
                    _buildSectionHeader(context, 'Ubicación'),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _cityController,
                      label: 'Ciudad',
                      icon: Icons.location_city,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _stateController,
                      label: 'Estado/Departamento',
                      icon: Icons.map,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _countryController,
                      label: 'País',
                      icon: Icons.public,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de habilidades
                    _buildSectionHeader(context, 'Habilidades'),
                    const SizedBox(height: 16),
                    
                    _buildSkillsSection(context),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de experiencia laboral
                    _buildSectionHeader(context, 'Experiencia Laboral'),
                    const SizedBox(height: 16),
                    
                    _buildWorkExperienceSection(context),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de educación
                    _buildSectionHeader(context, 'Educación'),
                    const SizedBox(height: 16),
                    
                    _buildEducationSection(context),
                    
                    const SizedBox(height: 32),
                    
                    // Botón de guardar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
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
                                'Guardar Cambios',
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context, user) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: user.profile.avatar != null && user.profile.avatar!.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          user.profile.avatar!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primary,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primary,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      AppToast.showInfo(context, 'Función de cambio de avatar próximamente');
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              AppToast.showInfo(context, 'Función de cambio de avatar próximamente');
            },
            child: const Text('Cambiar Foto'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        filled: true,
        fillColor: AppColors.cardBackground,
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Column(
      children: [
        // Lista de habilidades existentes
        ..._skills.map((skill) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SkillCard(
            skill: skill,
            onEdit: () => _editSkill(skill),
            onDelete: () => _deleteSkill(skill),
          ),
        )),
        
        // Botón para agregar nueva habilidad
        AddSkillCard(
          onTap: () => _addSkill(),
        ),
      ],
    );
  }

  Widget _buildWorkExperienceSection(BuildContext context) {
    return Column(
      children: [
        // Lista de experiencias existentes
        ..._workExperiences.map((experience) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: WorkExperienceCard(
            experience: experience,
            onEdit: () => _editWorkExperience(experience),
            onDelete: () => _deleteWorkExperience(experience),
          ),
        )),
        
        // Botón para agregar nueva experiencia
        AddWorkExperienceCard(
          onTap: () => _addWorkExperience(),
        ),
      ],
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return Column(
      children: [
        // Lista de educaciones existentes
        ..._educations.map((education) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: EducationCard(
            education: education,
            onEdit: () => _editEducation(education),
            onDelete: () => _deleteEducation(education),
          ),
        )),
        
        // Botón para agregar nueva educación
        AddEducationCard(
          onTap: () => _addEducation(),
        ),
      ],
    );
  }

  // Métodos para manejar habilidades
  void _addSkill() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddSkillScreen(),
      ),
    ).then((result) {
      if (result != null && result is Skill) {
        setState(() {
          _skills.add(result);
        });
        AppToast.showSuccess(context, 'Habilidad agregada exitosamente');
      }
    });
  }

  void _editSkill(Skill skill) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddSkillScreen(),
      ),
    ).then((result) {
      if (result != null && result is Skill) {
        setState(() {
          final index = _skills.indexWhere((s) => s.id == skill.id);
          if (index != -1) {
            _skills[index] = result;
          }
        });
        AppToast.showSuccess(context, 'Habilidad actualizada exitosamente');
      }
    });
  }

  void _deleteSkill(Skill skill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Habilidad'),
        content: Text('¿Estás seguro de que quieres eliminar "${skill.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _skills.removeWhere((s) => s.id == skill.id);
              });
              Navigator.pop(context);
              AppToast.showSuccess(context, 'Habilidad eliminada exitosamente');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Métodos para manejar experiencia laboral
  void _addWorkExperience() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddWorkExperienceScreen(),
      ),
    ).then((result) {
      if (result != null && result is WorkExperience) {
        setState(() {
          _workExperiences.add(result);
        });
        AppToast.showSuccess(context, 'Experiencia agregada exitosamente');
      }
    });
  }

  void _editWorkExperience(WorkExperience experience) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddWorkExperienceScreen(),
      ),
    ).then((result) {
      if (result != null && result is WorkExperience) {
        setState(() {
          final index = _workExperiences.indexWhere((e) => e.id == experience.id);
          if (index != -1) {
            _workExperiences[index] = result;
          }
        });
        AppToast.showSuccess(context, 'Experiencia actualizada exitosamente');
      }
    });
  }

  void _deleteWorkExperience(WorkExperience experience) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Experiencia'),
        content: Text('¿Estás seguro de que quieres eliminar "${experience.position}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _workExperiences.removeWhere((e) => e.id == experience.id);
              });
              Navigator.pop(context);
              AppToast.showSuccess(context, 'Experiencia eliminada exitosamente');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Métodos para manejar educación
  void _addEducation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddEducationScreen(),
      ),
    ).then((result) {
      if (result != null && result is Education) {
        setState(() {
          _educations.add(result);
        });
        AppToast.showSuccess(context, 'Educación agregada exitosamente');
      }
    });
  }

  void _editEducation(Education education) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddEducationScreen(),
      ),
    ).then((result) {
      if (result != null && result is Education) {
        setState(() {
          final index = _educations.indexWhere((e) => e.id == education.id);
          if (index != -1) {
            _educations[index] = result;
          }
        });
        AppToast.showSuccess(context, 'Educación actualizada exitosamente');
      }
    });
  }

  void _deleteEducation(Education education) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Educación'),
        content: Text('¿Estás seguro de que quieres eliminar "${education.fieldOfStudy}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _educations.removeWhere((e) => e.id == education.id);
              });
              Navigator.pop(context);
              AppToast.showSuccess(context, 'Educación eliminada exitosamente');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular guardado (en desarrollo con bypassAuth)
      await Future.delayed(const Duration(seconds: 1));
      
      AppToast.showSuccess(context, 'Perfil actualizado exitosamente');
      
      // En una implementación real, aquí llamarías al API
      // final success = await ref.read(authProvider.notifier).updateProfile({
      //   'firstName': _firstNameController.text,
      //   'lastName': _lastNameController.text,
      //   'phone': _phoneController.text,
      //   'bio': _bioController.text,
      //   'address': {
      //     'city': _cityController.text,
      //     'state': _stateController.text,
      //     'country': _countryController.text,
      //   },
      // });
      
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      AppToast.showError(context, 'Error al actualizar el perfil');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
