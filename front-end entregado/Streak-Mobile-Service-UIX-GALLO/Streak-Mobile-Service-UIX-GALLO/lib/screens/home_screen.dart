import 'package:flutter/material.dart';
import 'package:streak/models/job.dart';
import 'package:streak/models/company_profile.dart';
import 'package:streak/screens/job_detail_screen.dart';
import 'package:streak/widgets/home/job_card.dart';
import 'package:streak/widgets/home/promo_card.dart';
import 'package:streak/widgets/home/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final jobs = <Job>[
      const Job(
        id: 'job_1',
        title: 'Diseñador de productos',
        company: 'Google Inc',
        location: 'California, USA',
        postedAgo: 'Hace 1 día',
        salaryLabel: '\$15K/Mensual',
        description:
            'Rol de diseño de producto con foco en experiencia de usuario y trabajo con equipos multidisciplinarios.',
        requirements: [
          '5+ años de experiencia en diseño de producto',
          'Manejo de Figma y libraries de diseño',
          'Trabajo en equipo y comunicación efectiva',
        ],
        address: 'Overlook Avenue, Berkeley, PA, USA',
        info: {
          'Posición': 'Diseñador Senior',
          'Titulación': 'Licenciatura',
          'Experiencia': '5 años',
          'Tipo de empleo': 'Tiempo completo',
          'Especialización': 'Diseño',
        },
        benefits: [
          'Medicina',
          'Dental',
          'Contribución técnica',
          'Comidas',
          'Subsidio de transporte',
          'Horario flexible',
          'Lunes a viernes',
        ],
        companyProfile: CompanyProfile(
          website: 'https://www.google.com',
          sector: 'Productos de Internet',
          headcount: '132.121 Empleados',
          hq: 'Mountain View, California, EEUU',
          type: 'Empresa multinacional',
          founded: '1998',
          specialty: 'Búsqueda, IA, Ads',
        ),
      ),
      const Job(
        id: 'job_2',
        title: 'Flutter Developer',
        company: 'Meta',
        location: 'Remoto',
        postedAgo: 'Hace 1 día',
        salaryLabel: '\$9K/Mensual',
        description:
            'Desarrollo de apps móviles con Flutter. Trabajo remoto con squads ágiles.',
        requirements: [
          '2+ años con Flutter/Dart',
          'Consumo de APIs REST',
          'Buenas prácticas y patrones de diseño',
        ],
        address: 'Remoto',
        info: {
          'Posición': 'Mid-level',
          'Titulación': 'Tecnólogo o superior',
          'Experiencia': '2+ años',
          'Tipo de empleo': 'Tiempo completo',
          'Especialización': 'Mobile',
        },
        benefits: ['Medicina', 'Home office', 'Horario flexible'],
        companyProfile: CompanyProfile(
          website: 'https://about.meta.com',
          sector: 'Redes sociales',
          headcount: '86.482 Empleados',
          hq: 'Menlo Park, California, EEUU',
          type: 'Empresa multinacional',
          founded: '2004',
          specialty: 'Metaverso, Ads, Conectividad',
        ),
      ),
    ];

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
                        Text(
                          '¡Hola!',
                          style: tt.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w700, color: cs.onSurface),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userName,
                          style: tt.bodyLarge!.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(radius: 18),
                ],
              ),

              const SizedBox(height: 16),
              const PromoCard(),

              const SizedBox(height: 16),
              Text('Encuentra tu empleo',
                  style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),

              // NO usar const porque depende de cs.*
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      label: 'Trabajo remoto',
                      value: '44.5k',
                      color: cs.primaryContainer,
                      icon: Icons.laptop_mac,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      label: 'Tiempo completo',
                      value: '66.8k',
                      color: cs.secondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      label: 'Media jornada',
                      value: '38.9k',
                      color: cs.tertiaryContainer,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text('Lista de empleos recientes',
                  style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),

              for (final job in jobs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => JobDetailScreen(job: job),
                        ),
                      );
                    },
                    child: JobCard(
                      jobId: job.id,
                      title: job.title,
                      company: '${job.company} • ${job.location}',
                      salary: job.salaryLabel,
                      tags: [
                        job.info['Posición'] ?? '',
                        job.info['Tipo de empleo'] ?? '',
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}

