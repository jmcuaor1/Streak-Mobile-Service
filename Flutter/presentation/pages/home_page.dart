import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:gemini_project/presentation/pages/job_details_page.dart';
import 'package:gemini_project/presentation/pages/add_job_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gemini_project/presentation/pages/user_profile_page.dart';
import 'package:gemini_project/presentation/pages/add_a_job.dart';

// Nota: El nombre del archivo es 'create_job.dart' pero la clase es 'HomePage'.
// Para mayor consistencia, considera renombrar el archivo a 'home_page.dart'.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  final List<Job> _recentJobs = [];
  List<Job> _filteredJobs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchJobs();
    _searchController.addListener(_filterJobs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchJobs() async {
    // Simula una llamada de red de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // Datos de ejemplo que se cargarán después del delay
    final List<Job> jobs = [
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

    if (mounted) {
      setState(() {
        _recentJobs.addAll(jobs);
        _filteredJobs = _recentJobs;
        _isLoading = false;
      });
    }
  }

  void _filterJobs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredJobs = _recentJobs.where((job) {
        return job.position.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Un fondo ligeramente grisáceo
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 25),
              _buildRecentJobsSection(),
              const SizedBox(height: 15),
              _buildRecentJobsList(_filteredJobs),
              const SizedBox(height: 30),
              _buildActionCard(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3E1BFF), Color(0xFF6E57E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Hola, {{Usuario}}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserProfilePage()),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 25,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Encuentra aquí el trabajo de tus sueños",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Buscar...",
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // ¡PLUS!: Muestra un botón para limpiar si hay texto, si no, muestra el filtro.
          _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                  },
                  splashRadius: 20,
                )
              : const Icon(Icons.filter_list_rounded, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildRecentJobsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Trabajos Recientes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          Text(
            "Ver todos",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentJobsList(List<Job> jobs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        // Muestra 3 placeholders mientras carga, o la lista real
        itemCount: _isLoading ? 3 : jobs.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (_isLoading) {
            return _buildJobCardPlaceholder();
          } else {
            return _buildJobCard(context, jobs[index]);
          }
        },
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, Job job) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetailsPage(job: job)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFE8ECFF),
              child: Icon(Icons.business_center_outlined, color: Colors.blueAccent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.position,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${job.company} • ${job.location}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCardPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 14.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "¿Qué te gustaría hacer?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Publica tus consejos, experiencias o crea un nuevo puesto de trabajo para la comunidad.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddJobPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text("CREAR UN PUESTO DE TRABAJO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPostPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              minimumSize: const Size(double.infinity, 55),
              side: const BorderSide(color: Colors.blueAccent, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("PUBLICAR UN CONSEJO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
