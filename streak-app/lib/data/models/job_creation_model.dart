import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_creation_model.freezed.dart';
part 'job_creation_model.g.dart';

@freezed
class JobCreationModel with _$JobCreationModel {
  const factory JobCreationModel({
    required String title,
    required String description,
    required String category,
    String? subcategory,
    required JobType type,
    required List<String> skillsRequired,
    required ExperienceLevel experienceLevel,
    String? estimatedDuration,
    @Default(false) bool isUrgent,
    @Default(false) bool isRemote,
    String? location,
    BudgetInfo? budget,
    HourlyRateInfo? hourlyRate,
    @Default([]) List<String> attachments,
    @Default([]) List<String> tags,
    @Default('open') String status,
    DateTime? deadline,
    String? additionalRequirements,
  }) = _JobCreationModel;

  factory JobCreationModel.fromJson(Map<String, dynamic> json) => _$JobCreationModelFromJson(json);
}

@freezed
class BudgetInfo with _$BudgetInfo {
  const factory BudgetInfo({
    required double amount,
    required String currency,
    @Default(false) bool isNegotiable,
  }) = _BudgetInfo;

  factory BudgetInfo.fromJson(Map<String, dynamic> json) => _$BudgetInfoFromJson(json);
}

@freezed
class HourlyRateInfo with _$HourlyRateInfo {
  const factory HourlyRateInfo({
    required double minRate,
    required double maxRate,
    required String currency,
    @Default(false) bool isNegotiable,
  }) = _HourlyRateInfo;

  factory HourlyRateInfo.fromJson(Map<String, dynamic> json) => _$HourlyRateInfoFromJson(json);
}

enum JobType {
  fixedPrice('fixed_price', 'Precio Fijo', 'Trabajo con presupuesto fijo'),
  hourly('hourly', 'Por Hora', 'Trabajo pagado por hora'),
  fullTime('full_time', 'Tiempo Completo', 'Empleo de tiempo completo'),
  partTime('part_time', 'Medio Tiempo', 'Empleo de medio tiempo'),
  contract('contract', 'Contrato', 'Trabajo por contrato'),
  internship('internship', 'Pasantía', 'Oportunidad de pasantía');

  const JobType(this.value, this.displayName, this.description);
  
  final String value;
  final String displayName;
  final String description;

  static JobType? fromValue(String value) {
    for (final type in JobType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null;
  }
}

enum ExperienceLevel {
  entry('entry', 'Principiante', '0-1 años de experiencia'),
  intermediate('intermediate', 'Intermedio', '2-5 años de experiencia'),
  senior('senior', 'Senior', '5+ años de experiencia'),
  expert('expert', 'Experto', '10+ años de experiencia');

  const ExperienceLevel(this.value, this.displayName, this.description);
  
  final String value;
  final String displayName;
  final String description;

  static ExperienceLevel? fromValue(String value) {
    for (final level in ExperienceLevel.values) {
      if (level.value == value) {
        return level;
      }
    }
    return null;
  }
}

class JobCategory {
  final String name;
  final String icon;
  final List<String> subcategories;
  final List<String> commonSkills;

  const JobCategory({
    required this.name,
    required this.icon,
    required this.subcategories,
    required this.commonSkills,
  });

  static const List<JobCategory> categories = [
    JobCategory(
      name: 'Desarrollo Web',
      icon: '🌐',
      subcategories: [
        'Frontend',
        'Backend',
        'Full Stack',
        'E-commerce',
        'CMS',
        'API Development',
      ],
      commonSkills: [
        'HTML',
        'CSS',
        'JavaScript',
        'React',
        'Vue.js',
        'Angular',
        'Node.js',
        'Python',
        'PHP',
        'Laravel',
        'Django',
        'Express.js',
      ],
    ),
    JobCategory(
      name: 'Desarrollo Móvil',
      icon: '📱',
      subcategories: [
        'iOS',
        'Android',
        'Cross-platform',
        'React Native',
        'Flutter',
        'Xamarin',
      ],
      commonSkills: [
        'Swift',
        'Kotlin',
        'Java',
        'Flutter',
        'Dart',
        'React Native',
        'Xamarin',
        'Ionic',
        'Cordova',
      ],
    ),
    JobCategory(
      name: 'Diseño Gráfico',
      icon: '🎨',
      subcategories: [
        'Logo Design',
        'Branding',
        'UI/UX Design',
        'Print Design',
        'Web Design',
        'Illustration',
      ],
      commonSkills: [
        'Adobe Photoshop',
        'Adobe Illustrator',
        'Adobe InDesign',
        'Figma',
        'Sketch',
        'Adobe XD',
        'Canva',
        'CorelDRAW',
      ],
    ),
    JobCategory(
      name: 'Marketing Digital',
      icon: '📈',
      subcategories: [
        'Social Media',
        'SEO',
        'SEM',
        'Content Marketing',
        'Email Marketing',
        'Analytics',
      ],
      commonSkills: [
        'Google Analytics',
        'Facebook Ads',
        'Google Ads',
        'SEO',
        'Content Writing',
        'Social Media',
        'Email Marketing',
        'HubSpot',
        'Mailchimp',
      ],
    ),
    JobCategory(
      name: 'Escritura y Traducción',
      icon: '✍️',
      subcategories: [
        'Content Writing',
        'Technical Writing',
        'Translation',
        'Copywriting',
        'Blog Writing',
        'Academic Writing',
      ],
      commonSkills: [
        'Content Writing',
        'SEO Writing',
        'Technical Writing',
        'Translation',
        'Copywriting',
        'Proofreading',
        'Research',
        'Grammar',
      ],
    ),
    JobCategory(
      name: 'Datos y Análisis',
      icon: '📊',
      subcategories: [
        'Data Analysis',
        'Data Science',
        'Machine Learning',
        'Business Intelligence',
        'Statistics',
        'Database',
      ],
      commonSkills: [
        'Python',
        'R',
        'SQL',
        'Excel',
        'Tableau',
        'Power BI',
        'Machine Learning',
        'Statistics',
        'Pandas',
        'NumPy',
      ],
    ),
    JobCategory(
      name: 'Consultoría',
      icon: '💼',
      subcategories: [
        'Business Consulting',
        'IT Consulting',
        'Management Consulting',
        'Strategy Consulting',
        'Financial Consulting',
        'HR Consulting',
      ],
      commonSkills: [
        'Business Analysis',
        'Project Management',
        'Strategy',
        'Process Improvement',
        'Change Management',
        'Financial Analysis',
        'Risk Management',
      ],
    ),
    JobCategory(
      name: 'Otros',
      icon: '🔧',
      subcategories: [
        'Customer Service',
        'Virtual Assistant',
        'Data Entry',
        'Administrative',
        'Sales',
        'Training',
      ],
      commonSkills: [
        'Communication',
        'Organization',
        'Time Management',
        'Problem Solving',
        'Customer Service',
        'Microsoft Office',
        'Google Workspace',
      ],
    ),
  ];

  static JobCategory? getByName(String name) {
    for (final category in categories) {
      if (category.name == name) {
        return category;
      }
    }
    return null;
  }
}

class JobCreationStep {
  final String title;
  final String description;
  final bool isCompleted;
  final bool isActive;

  const JobCreationStep({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isActive = false,
  });

  JobCreationStep copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    bool? isActive,
  }) {
    return JobCreationStep(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isActive: isActive ?? this.isActive,
    );
  }
}
