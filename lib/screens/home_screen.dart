import 'package:flutter/material.dart';
import '../widgets/home/promo_card.dart';
import '../widgets/home/stat_card.dart';
import '../widgets/home/job_card.dart';
import '../widgets/common/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('¡Hola!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: cs.onSurface)),
                        const SizedBox(height: 2),
                        Text(userName, style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const CircleAvatar(radius: 18, backgroundImage: AssetImage('assets/avatar.png')),
                ],
              ),

              const SizedBox(height: 16),
              const PromoCard(),

              const SizedBox(height: 16),
              Text('Encuentra tu empleo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cs.onSurface)),
              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(child: StatCard(label: 'Trabajo remoto', value: '44.5k', bg: Color(0xFFDDF3FF), icon: Icons.laptop_mac)),
                  SizedBox(width: 12),
                  Expanded(child: StatCard(label: 'Tiempo completo', value: '66.8k', bg: Color(0xFFEDE7FF))),
                  SizedBox(width: 12),
                  Expanded(child: StatCard(label: 'Media jornada', value: '38.9k', bg: Color(0xFFFFE8CC))),
                ],
              ),

              const SizedBox(height: 20),
              Text('Lista de empleos recientes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cs.onSurface)),
              const SizedBox(height: 12),

              const JobCard(
                title: 'Diseñador de productos',
                company: 'Google Inc • California, USA',
                salary: '\$15K/Mensual',
                tags: ['Diseñador senior', 'Tiempo completo'],
              ),
              const SizedBox(height: 10),
              const JobCard(
                title: 'Flutter Developer',
                company: 'Meta • Remoto',
                salary: '\$9K/Mensual',
                tags: ['Mid-level', 'Remoto'],
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
