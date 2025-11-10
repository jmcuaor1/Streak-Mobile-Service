import 'package:flutter/material.dart';

class FilterChipBar extends StatelessWidget {
  const FilterChipBar({super.key, required this.options, required this.active, required this.onToggle});
  final List<String> options;
  final Set<String> active;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          if (i == 0) {
            return Container(
              height: 40, width: 40,
              decoration: BoxDecoration(color: cs.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.tune, color: cs.primary),
            );
          }
          final label = options[i - 1];
          final selected = active.contains(label);
          return ChoiceChip(
            label: Text(label),
            selected: selected,
            onSelected: (_) => onToggle(label),
            selectedColor: cs.primary.withOpacity(0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: cs.outlineVariant),
            ),
          );
        },
      ),
    );
  }
}
