import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String id,
    required String name,
    required String tagline,
    required String description,
    required String website,
    required String industry,
    required String size,
    required String location,
    required String founded,
    String? logo,
    String? coverImage,
    @Default(false) bool isVerified,
    @Default(0) int followersCount,
    @Default(0) int jobsCount,
    @Default(0.0) double rating,
    @Default(0) int reviewsCount,
    @Default([]) List<String> benefits,
    @Default([]) List<String> technologies,
    @Default([]) List<String> locations,
    @Default([]) List<CompanyJob> recentJobs,
    @Default([]) List<CompanyReview> reviews,
    @Default([]) List<CompanyGallery> gallery,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);
}

@freezed
class CompanyJob with _$CompanyJob {
  const factory CompanyJob({
    required String id,
    required String title,
    required String type,
    required String location,
    required String salary,
    required String posted,
    @Default(false) bool isUrgent,
    @Default([]) List<String> skills,
  }) = _CompanyJob;

  factory CompanyJob.fromJson(Map<String, dynamic> json) => _$CompanyJobFromJson(json);
}

@freezed
class CompanyReview with _$CompanyReview {
  const factory CompanyReview({
    required String id,
    required String authorName,
    required String authorRole,
    required String authorAvatar,
    required double rating,
    required String title,
    required String content,
    required DateTime date,
    @Default([]) List<String> pros,
    @Default([]) List<String> cons,
    @Default(false) bool isVerified,
  }) = _CompanyReview;

  factory CompanyReview.fromJson(Map<String, dynamic> json) => _$CompanyReviewFromJson(json);
}

@freezed
class CompanyGallery with _$CompanyGallery {
  const factory CompanyGallery({
    required String id,
    required String imageUrl,
    required String caption,
    required String type, // office, team, event, etc.
    DateTime? uploadedAt,
  }) = _CompanyGallery;

  factory CompanyGallery.fromJson(Map<String, dynamic> json) => _$CompanyGalleryFromJson(json);
}

enum CompanySize {
  startup('1-10', 'Startup'),
  small('11-50', 'Pequeña'),
  medium('51-200', 'Mediana'),
  large('201-1000', 'Grande'),
  enterprise('1000+', 'Empresa');

  const CompanySize(this.range, this.displayName);
  
  final String range;
  final String displayName;

  static CompanySize? fromRange(String range) {
    for (final size in CompanySize.values) {
      if (size.range == range) {
        return size;
      }
    }
    return null;
  }
}

enum CompanyIndustry {
  technology('Tecnología'),
  healthcare('Salud'),
  finance('Finanzas'),
  education('Educación'),
  retail('Retail'),
  manufacturing('Manufactura'),
  consulting('Consultoría'),
  media('Medios'),
  realEstate('Bienes Raíces'),
  other('Otro');

  const CompanyIndustry(this.displayName);
  
  final String displayName;

  static CompanyIndustry? fromDisplayName(String displayName) {
    for (final industry in CompanyIndustry.values) {
      if (industry.displayName == displayName) {
        return industry;
      }
    }
    return null;
  }
}
