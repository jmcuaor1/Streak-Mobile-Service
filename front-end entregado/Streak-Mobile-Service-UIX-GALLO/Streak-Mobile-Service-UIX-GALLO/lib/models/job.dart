import 'company_profile.dart';

class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String postedAgo;
  final String salaryLabel;
  final String description;
  final List<String> requirements;
  final String address;
  final Map<String, String> info;
  final List<String> benefits;
  final String? logoUrl;

  final CompanyProfile? companyProfile;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.postedAgo,
    required this.salaryLabel,
    required this.description,
    required this.requirements,
    required this.address,
    required this.info,
    required this.benefits,
    this.logoUrl,
    this.companyProfile,
  });
}
