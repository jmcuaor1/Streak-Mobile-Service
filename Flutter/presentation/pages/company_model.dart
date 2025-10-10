import 'package:gemini_project/models/job_model.dart';

class Company {
  final String name;
  final String industry;
  final String logoUrl;
  final String about;
  final List<Job> openJobs;
  final String? websiteUrl;
  final String? linkedinUrl;
  final String? instagramUrl;

  Company({
    required this.name,
    required this.industry,
    required this.logoUrl,
    required this.about,
    required this.openJobs,
    this.websiteUrl,
    this.linkedinUrl,
    this.instagramUrl,
  });
}