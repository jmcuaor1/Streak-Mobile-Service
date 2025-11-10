class Job {
  final String position;
  final String company;
  final String location;
  final String jobType;
  final String description;
  final String? minSalary;
  final String? maxSalary;

  Job({
    required this.position,
    required this.company,
    required this.location,
    required this.jobType,
    required this.description,
    this.minSalary,
    this.maxSalary,
  });
}