import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ApplicationStatus { enRevision, aprobada, rechazada }


class Application {
  final String company;
  final String position;
  final String location;
  final ApplicationStatus status;
  final IconData icon;

  const Application({
    required this.company,
    required this.position,
    required this.location,
    required this.status,
    required this.icon,
  });
}

class YourApplicationPage extends StatefulWidget {
  const YourApplicationPage({super.key});

  @override
  State<YourApplicationPage> createState() => _YourApplicationPageState();
}

class _YourApplicationPageState extends State<YourApplicationPage> {
  // Lista original de aplicaciones (simulando datos de una API/DB)
  final List<Application> _allApplications = const [
    Application(company: 'Google', position: 'Desarrollador Flutter', location: 'Remoto', status: ApplicationStatus.enRevision, icon: FontAwesomeIcons.google),
    Application(company: 'Amazon', position: 'Ingeniero de Software', location: 'Híbrido - Medellín', status: ApplicationStatus.aprobada, icon: FontAwesomeIcons.amazon),
    Application(company: 'Netflix', position: 'UI/UX Designer', location: 'Presencial - Bogotá', status: ApplicationStatus.rechazada, icon: FontAwesomeIcons.n),
    Application(company: 'Spotify', position: 'Product Manager', location: 'Remoto', status: ApplicationStatus.enRevision, icon: FontAwesomeIcons.spotify),
  ];

  // Lista que se mostrará en la UI, puede ser filtrada.
  late List<Application> _filteredApplications;
  ApplicationStatus? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _filteredApplications = _allApplications;
  }

  void _filterApplications(ApplicationStatus? status) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedFilter = status;
      if (status == null) {
        _filteredApplications = _allApplications;
      } else {
        _filteredApplications = _allApplications.where((app) => app.status == status).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tus Aplicaciones',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildFilterChips(),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredApplications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: _filteredApplications.length,
                      itemBuilder: (context, index) {
                        return _buildApplicationCard(_filteredApplications[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Filtros para mejorar la UX
  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildChip("Todas", null),
          _buildChip("En revisión", ApplicationStatus.enRevision),
          _buildChip("Aprobada", ApplicationStatus.aprobada),
          _buildChip("Rechazada", ApplicationStatus.rechazada),
        ],
      ),
    );
  }

  Widget _buildChip(String label, ApplicationStatus? status) {
    final isSelected = _selectedFilter == status;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) => _filterApplications(status),
        backgroundColor: Colors.white,
        selectedColor: Colors.blueAccent,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: isSelected ? Colors.blueAccent : Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildApplicationCard(Application app) {
    final statusInfo = _getStatusInfo(app.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: () => _showApplicationDetail(context, app),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: statusInfo['color']!.withOpacity(0.1),
          child: FaIcon(app.icon, color: statusInfo['color']),
        ),
        title: Text(app.position, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("${app.company} • ${app.location}", style: const TextStyle(color: Colors.black54)),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusInfo['color']!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            statusInfo['text']!,
            style: TextStyle(color: statusInfo['color'], fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }

  // Un estado para cuando no hay resultados.
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            "No se encontraron aplicaciones",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          const Text(
            "Prueba a seleccionar otro filtro.",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper para obtener el color y texto del estado.
  Map<String, dynamic> _getStatusInfo(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.enRevision:
        return {'text': 'En revisión', 'color': const Color(0xFFFFC107)};
      case ApplicationStatus.aprobada:
        return {'text': 'Aprobada', 'color': const Color(0xFF4CAF50)};
      case ApplicationStatus.rechazada:
        return {'text': 'Rechazada', 'color': const Color(0xFFE53935)};
    }
  }

  // Modal rediseñado
  void _showApplicationDetail(BuildContext context, Application application) {
    final statusInfo = _getStatusInfo(application.status);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(application.icon, color: statusInfo['color'], size: 40),
              const SizedBox(height: 12),
              Text(
                application.position,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(application.company, style: const TextStyle(color: Colors.black54, fontSize: 16)),
              const SizedBox(height: 24),
              _buildStatusTimeline(application.status),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Un timeline visual para el estado de la aplicación.
  Widget _buildStatusTimeline(ApplicationStatus currentStatus) {
    return Column(
      children: [
        _buildTimelineStep('Aplicación Enviada', true),
        _buildTimelineStep('En Revisión', currentStatus == ApplicationStatus.enRevision || currentStatus == ApplicationStatus.aprobada),
        _buildTimelineStep('Entrevista', currentStatus == ApplicationStatus.aprobada),
        _buildTimelineStep('Oferta Recibida', currentStatus == ApplicationStatus.aprobada, isLast: true),
      ],
    );
  }

  Widget _buildTimelineStep(String title, bool isCompleted, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey.shade400,
              size: 24,
            ),
            if (!isLast)
              Container(
                height: 30,
                width: 2,
                color: isCompleted ? Colors.green : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
              color: isCompleted ? Colors.black87 : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
