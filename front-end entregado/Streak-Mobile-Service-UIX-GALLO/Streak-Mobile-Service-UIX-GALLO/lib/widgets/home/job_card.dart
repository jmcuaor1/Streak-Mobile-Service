import 'package:flutter/material.dart';
import '../../state/app_state.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.jobId,
    required this.title,
    required this.company,
    required this.salary,
    required this.tags,
    this.onTap,
  });

  final String jobId;
  final String title;
  final String company;
  final String salary;
  final List<String> tags;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<Set<String>>(
      valueListenable: AppState.I.savedJobs,
      builder: (_, savedSet, __) {
        final saved = savedSet.contains(jobId);
        return ValueListenableBuilder<Set<String>>(
          valueListenable: AppState.I.appliedJobs,
          builder: (_, appliedSet, __) {
            final applied = appliedSet.contains(jobId);

            final tt = Theme.of(context).textTheme;

            final card = Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: const Offset(0, 6))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  CircleAvatar(radius: 18, backgroundColor: cs.surfaceContainerHighest, child: const Icon(Icons.work, color: Colors.black)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(title, style: tt.titleMedium)),
                  IconButton(
                    onPressed: () => AppState.I.toggleSave(jobId),
                    icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
                  ),
                ]),
                const SizedBox(height: 4),
                Text(company, style: tt.bodyMedium!.copyWith(color: cs.onSurfaceVariant)),
                const SizedBox(height: 8),
                Text(salary, style: tt.titleSmall!.copyWith(color: cs.primary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: -4,
                  children: [
                    for (final t in tags)
                      Chip(
                        label: Text(t, style: tt.labelSmall),
                        side: BorderSide(color: cs.outlineVariant),
                        backgroundColor: cs.surfaceContainerHighest.withOpacity(0.4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    FilledButton.tonal(
                      onPressed: applied ? null : () => AppState.I.toggleApply(jobId),
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), visualDensity: VisualDensity.compact),
                      child: Text(applied ? 'Aplicado' : 'Aplicar'),
                    ),
                  ],
                ),
              ]),
            );

            return InkWell(onTap: onTap, child: card);
          },
        );
      },
    );
  }
}
