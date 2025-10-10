import 'package:flutter/material.dart';
import 'package:streak/models/job.dart';
import 'package:streak/screens/upload_cv_screen.dart';
import 'package:streak/widgets/job/company_info_tab.dart';
import 'package:streak/state/app_state.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      color: cs.onSurface,
                    ),
                    const Spacer(),
                    ValueListenableBuilder<Set<String>>(
                      valueListenable: AppState.I.savedJobs,
                      builder: (context, savedJobs, child) {
                        final isSaved = savedJobs.contains(job.id);
                        return IconButton(
                          onPressed: () => AppState.I.toggleSave(job.id),
                          icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                          color: cs.onSurface,
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.ios_share_outlined),
                      color: cs.onSurface,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Job title
              if (job.logoUrl != null) ...[
                Center(child: Image.network(job.logoUrl!, height: 60)),
                const SizedBox(height: 12),
              ],
              Center(
                child: Text(
                  job.title,
                  textAlign: TextAlign.center,
                  style: tt.titleLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${job.company} • ${job.location}',
                  textAlign: TextAlign.center,
                  style: tt.bodyMedium!.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  job.postedAgo,
                  textAlign: TextAlign.center,
                  style: tt.bodySmall!.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.salaryLabel,
                    style: tt.labelMedium!.copyWith(
                      color: cs.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              const TabBar(
                tabs: [
                  Tab(text: 'Descripción'),
                  Tab(text: 'Empresa'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _DescriptionTab(job: job),
                    if (job.companyProfile != null)
                      CompanyInfoTab(info: job.companyProfile!, about: job.description),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder:(_) => const UploadCVScreen()),
                );
              },
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('APLICAR AHORA'),
            ),
          ),
        ),
      ),
    );
  }
}

class _DescriptionTab extends StatelessWidget {
  const _DescriptionTab({required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text('Descripción del empleo', style: tt.titleMedium),
          const SizedBox(height: 8),
          Text(job.description, style: tt.bodyMedium),

          const SizedBox(height: 24),
          // Requirements
          Text('Requisitos', style: tt.titleMedium),
          const SizedBox(height: 8),
          for (final req in job.requirements)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(req, style: tt.bodyMedium)),
                ],
              ),
            ),

          const SizedBox(height: 24),
          // Location
          Text('Ubicación', style: tt.titleMedium),
          const SizedBox(height: 8),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Map placeholder for\n${job.address}',
                textAlign: TextAlign.center,
                style: tt.bodySmall,
              ),
            ),
          ),

          const SizedBox(height: 24),
          // Information
          Text('Información', style: tt.titleMedium),
          const SizedBox(height: 8),
          for (final entry in job.info.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(entry.key, style: tt.bodyMedium!.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(entry.value, style: tt.bodyMedium),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 24),
          // Benefits
          Text('Beneficios', style: tt.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final benefit in job.benefits)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    benefit,
                    style: tt.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

