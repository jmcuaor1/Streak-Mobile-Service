import 'package:flutter/foundation.dart';
import 'package:gemini_project/models/job_model.dart';

class JobProvider with ChangeNotifier {
  bool _isLoading = true;
  final List<Job> _jobs = [];
  List<Job> _filteredJobs = [];

  bool get isLoading => _isLoading;
  List<Job> get filteredJobs => _filteredJobs;

  JobProvider() {
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    // Simula una llamada de red de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // Datos de ejemplo que se cargarán después del delay
    final List<Job> fetchedJobs = [
      Job(
        position: 'Diseñador UI/UX Senior',
        company: 'Tech Solutions',
        location: 'Remoto',
        jobType: 'Tiempo completo',
        description: 'Buscamos un diseñador UI/UX con experiencia para unirse a nuestro equipo...',
        minSalary: '5000',
        maxSalary: '7000',
      ),
      Job(
        position: 'Desarrollador Flutter',
        company: 'Mobile Innovations',
        location: 'Medellín, Colombia',
        jobType: 'Contrato',
        description: 'Desarrollador con experiencia en Flutter para crear aplicaciones móviles de alto rendimiento.',
        minSalary: '4500',
      ),
    ];

    _jobs.addAll(fetchedJobs);
    _filteredJobs = _jobs;
    _isLoading = false;
    notifyListeners();
  }

  void filterJobs(String query) {
    final lowerCaseQuery = query.toLowerCase();
    _filteredJobs = _jobs.where((job) => job.position.toLowerCase().contains(lowerCaseQuery)).toList();
    notifyListeners();
  }
}