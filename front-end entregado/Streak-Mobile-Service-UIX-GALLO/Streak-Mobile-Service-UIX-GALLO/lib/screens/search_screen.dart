import 'package:flutter/material.dart';
import 'package:streak/models/job.dart';
import 'package:streak/screens/job_detail_screen.dart';
import 'package:streak/screens/filter_screen.dart'; // <- aquí está tu filtro avanzado
import 'package:streak/widgets/search/filter_chip_bar.dart';
import 'package:streak/widgets/search/search_empty_state.dart';
import 'package:streak/widgets/search/search_result_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _keyword = TextEditingController(text: 'Diseño');
  final _location = TextEditingController(text: 'California, USA');

  final List<String> _filters = ['Diseñador senior', 'Diseñador', 'Tiempo completo'];
  final Set<String> _active = {'Diseñador senior'};

  // Mock
  late final List<Job> allJobs = [
    Job(
      id: 'job_g_1',
      title: 'Diseñador UI/UX',
      company: 'Google Inc',
      location: 'California, USA',
      postedAgo: 'Hace 25 minutos',
      salaryLabel: '\$15K/Mensual',
      description: 'Diseño de experiencia end-to-end en productos de alto impacto.',
      requirements: ['Figma', 'Design Systems', 'UX Research'],
      address: 'Mountain View, CA',
      info: {'Tipo de empleo': 'Tiempo completo', 'Posición': 'Diseñador senior'},
      benefits: ['Medicina', 'Comidas', 'Horario flexible'],
      logoUrl: null,
    ),
    Job(
      id: 'job_d_1',
      title: 'Lead Designer',
      company: 'Dribbble inc',
      location: 'Texas, USA',
      postedAgo: 'Hace 25 minutos',
      salaryLabel: '\$20K/Mensual',
      description: 'Lidera un equipo de diseño para lanzar features clave.',
      requirements: ['Leadership', 'Figma', 'Prototyping'],
      address: 'Remoto',
      info: {'Tipo de empleo': 'Tiempo completo', 'Posición': 'Diseñador'},
      benefits: ['Home office', 'Seguro', 'Bonos'],
      logoUrl: null,
    ),
  ];

  late List<Job> results = List<Job>.from(allJobs);

  @override
  void dispose() {
    _keyword.dispose();
    _location.dispose();
    super.dispose();
  }

  int _salaryK(String label) {
    // '\$15K/Mensual' -> 15
    final digits = RegExp(r'\d+').allMatches(label).map((m) => m.group(0)!).join();
    if (digits.isEmpty) return 0;
    return int.tryParse(digits) ?? 0;
  }

  void _onSearch() {
    final q = _keyword.text.trim().toLowerCase();
    final loc = _location.text.trim().toLowerCase();
    final active = _active.toSet();

    setState(() {
      results = allJobs.where((j) {
        final titleOk =
            j.title.toLowerCase().contains(q) || j.company.toLowerCase().contains(q);
        final locOk = loc.isEmpty ? true : j.location.toLowerCase().contains(loc);
        final chipsOk = active.isEmpty
            ? true
            : active.any((c) =>
                (j.info['Posición'] ?? '').toLowerCase().contains(c.toLowerCase()) ||
                (j.info['Tipo de empleo'] ?? '').toLowerCase().contains(c.toLowerCase()));
        return titleOk && locOk && chipsOk;
      }).toList();
    });
  }

  Future<void> _openFilters() async {
    final data = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const FilterScreen()),
    );
    if (data == null) return;

    // Claves esperadas del filtro avanzado:
    // recency, jobTypes(List<String>), levels(List<String>), cities(List<String>),
    // salaryMinK(int), salaryMaxK(int), experience(String)
    final cities = (data['cities'] as List?)?.cast<String>() ?? const [];
    final minK = (data['salaryMinK'] as int?) ?? 0;
    final maxK = (data['salaryMaxK'] as int?) ?? 999;
    final jobTypes = (data['jobTypes'] as List?)?.cast<String>() ?? const [];

    setState(() {
      // sincronzia chips con jobTypes si vienen
      if (jobTypes.isNotEmpty) {
        _active
          ..clear()
          ..addAll(jobTypes);
      }

      // aplica ciudad y salario sobre la base, luego deja que _onSearch refine por texto/ubicación
      results = allJobs.where((j) {
        final cityOk =
            cities.isEmpty ? true : cities.any((c) => j.location.toLowerCase().contains(c.toLowerCase()));
        final k = _salaryK(j.salaryLabel); // 15K -> 15
        final salaryOk = k >= minK && k <= maxK;
        return cityOk && salaryOk;
      }).toList();
    });

    _onSearch();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cs.primary, cs.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _SearchField(
                    controller: _keyword,
                    hint: 'Diseño',
                    icon: Icons.search,
                    onSubmitted: (_) => _onSearch(),
                  ),
                  const SizedBox(height: 10),
                  _SearchField(
                    controller: _location,
                    hint: 'California, USA',
                    icon: Icons.location_on_outlined,
                    onSubmitted: (_) => _onSearch(),
                  ),
                ],
              ),
            ),

            // Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilterChipBar(
                options: _filters,
                active: _active,
                onToggle: (label) {
                  setState(() {
                    _active.contains(label)
                        ? _active.remove(label)
                        : _active.add(label);
                  });
                  _onSearch();
                },
              ),
            ),

            const SizedBox(height: 12),

            // Resultados / vacío
            Expanded(
              child: results.isEmpty
                  ? const SearchEmptyState()
                  : ListView.separated(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final j = results[i];
                        return SearchResultCard(
                          title: j.title,
                          company: '${j.company} • ${j.location}',
                          posted: j.postedAgo,
                          salary: j.salaryLabel,
                          tags: const [
                            'Diseño',
                            'Tiempo completo',
                            'Diseñador senior'
                          ],
                          saved: false,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => JobDetailScreen(job: j)),
                          ),
                          onToggleSave: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openFilters,
        child: const Icon(Icons.tune),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.onSubmitted,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
