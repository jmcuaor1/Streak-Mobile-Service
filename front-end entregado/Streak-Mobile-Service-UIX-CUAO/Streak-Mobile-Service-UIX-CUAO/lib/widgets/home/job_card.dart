import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.salary,
    required this.tags,
  });

  final String title;
  final String company;
  final String salary;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 18, backgroundColor: cs.surfaceVariant, child: const Icon(Icons.apple, color: Colors.black)),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
        ]),
        const SizedBox(height: 4),
        Text(company, style: TextStyle(color: Colors.black.withOpacity(0.6))),
        const SizedBox(height: 8),
        Text(salary, style: TextStyle(fontWeight: FontWeight.w700, color: cs.primary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: -4,
          children: [
            for (final t in tags)
              Chip(
                label: Text(t, style: const TextStyle(fontSize: 12)),
                side: BorderSide(color: cs.outlineVariant),
                backgroundColor: cs.surfaceVariant.withOpacity(0.4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            FilledButton.tonal(
              onPressed: () {},
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), visualDensity: VisualDensity.compact),
              child: const Text('Aplicar'),
            ),
          ],
        ),
      ]),
    );
  }
}
