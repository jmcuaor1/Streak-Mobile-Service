import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:gemini_project/models/job_notification_model.dart';

class SavedJobProvider with ChangeNotifier {
  // --- STATE ---

  final List<Job> _savedJobs = [
    Job(position: 'Desarrollador Flutter', company: 'Google', location: 'Remoto', jobType: 'Tiempo completo', description: '', minSalary: '4000', maxSalary: '5500'),
    Job(position: 'Diseñador UI/UX', company: 'Netflix', location: 'Híbrido - Bogotá', jobType: 'Tiempo completo', description: '', minSalary: '3800', maxSalary: '5000'),
    Job(position: 'Data Analyst', company: 'Amazon', location: 'Presencial - Medellín', jobType: 'Tiempo completo', description: '', minSalary: '4500', maxSalary: '6000'),
  ];

  final List<JobNotification> _notifications = [];
  late List<Job> _filteredJobs;
  final listKey = GlobalKey<AnimatedListState>();

  // --- GETTERS ---

  List<Job> get filteredJobs => _filteredJobs;
  List<JobNotification> get notifications => _notifications;

  // --- CONSTRUCTOR ---

  SavedJobProvider() {
    _filteredJobs = _savedJobs;
    _populateNotifications();
  }

  // --- METHODS ---

  void _populateNotifications() {
    if (_savedJobs.isNotEmpty) {
      _notifications.clear();
      _notifications.addAll([
        JobNotification(title: 'Postulación por cerrar', subtitle: 'La postulación para ${_savedJobs[0].position} cierra en 3 días.', timestamp: DateTime.now().subtract(const Duration(hours: 2)), icon: Icons.timer_outlined, relatedJob: _savedJobs[0]),
        JobNotification(title: 'Nuevo empleo similar', subtitle: 'Hemos encontrado un empleo similar a ${_savedJobs[1].position}.', timestamp: DateTime.now().subtract(const Duration(days: 1)), icon: Icons.new_releases_outlined, relatedJob: _savedJobs[1], isRead: true),
        JobNotification(title: 'Actualización de estado', subtitle: 'Tu postulación para ${_savedJobs[2].position} ha sido vista.', timestamp: DateTime.now().subtract(const Duration(days: 2)), icon: Icons.visibility_outlined, relatedJob: _savedJobs[2]),
      ]);
    }
  }

  void filterJobs(String query) {
    final lowerCaseQuery = query.toLowerCase();
    _filteredJobs = _savedJobs.where((job) {
      final title = job.position.toLowerCase();
      final company = job.company.toLowerCase();
      return title.contains(lowerCaseQuery) || company.contains(lowerCaseQuery);
    }).toList();
    notifyListeners();
  }

  void removeJob(int index, Job job, BuildContext context) {
    _savedJobs.remove(job);
    final removedItem = _filteredJobs.removeAt(index);

    listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(removedItem, animation),
      duration: const Duration(milliseconds: 300),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${job.position} eliminado.'),
        action: SnackBarAction(
          label: 'DESHACER',
          onPressed: () => undoRemove(index, job),
        ),
      ),
    );
    notifyListeners();
  }

  void undoRemove(int index, Job job) {
    _savedJobs.insert(index, job);
    _filteredJobs.insert(index, job);
    listKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 300));
    notifyListeners();
  }

  void markNotificationAsRead(JobNotification notification) {
    notification.isRead = true;
    notifyListeners();
  }

  void markAllNotificationsAsRead() {
    for (var notif in _notifications) {
      notif.isRead = true;
    }
    notifyListeners();
  }

  // Helper para la animación, necesita acceso a _buildJobCard
  Widget _buildRemovedItem(Job job, Animation<double> animation) {
    // Este es un truco para poder llamar a un widget que está en la UI desde el provider.
    // Lo ideal sería que el widget de la tarjeta estuviera en un archivo separado.
    // Por ahora, devolvemos un contenedor vacío, la animación de `SizeTransition` se encargará.
    return SizeTransition(sizeFactor: animation, child: const SizedBox.shrink());
  }
}