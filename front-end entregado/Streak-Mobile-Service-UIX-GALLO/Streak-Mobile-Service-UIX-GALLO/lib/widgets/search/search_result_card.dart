import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.title,
    required this.company,
    required this.posted,
    required this.salary,
    required this.tags,
    required this.saved,
    required this.onTap,
    required this.onToggleSave,
  });

  final String title;
  final String company;
  final String posted;
  final String salary;
  final List<String> tags;
  final bool saved;
  final VoidCallback onTap;
  final VoidCallback onToggleSave;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 6))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 18, backgroundColor: cs.surfaceVariant, child: const Icon(Icons.work, color: Colors.black)),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
            IconButton(onPressed: onToggleSave, icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border)),
          ]),
          const SizedBox(height: 4),
          Text(company, style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: Wrap(
                spacing: 8, runSpacing: -4,
                children: [
                  for (final t in tags)
                    Chip(
                      label: Text(t, style: const TextStyle(fontSize: 12)),
                      side: BorderSide(color: cs.outlineVariant),
                      backgroundColor: cs.surfaceVariant.withOpacity(0.4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(posted, style: TextStyle(color: cs.onSurfaceVariant)),
              const SizedBox(height: 4),
              Text(salary, style: TextStyle(color: cs.primary, fontWeight: FontWeight.w700)),
            ]),
          ]),
        ]),
      ),
    );
  }
}
