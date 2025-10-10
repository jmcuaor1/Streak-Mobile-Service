
import 'package:flutter/material.dart';
import 'package:streak/models/job.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({required this.job, super.key});
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
