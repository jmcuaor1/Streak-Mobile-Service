import 'package:flutter/material.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key, this.query});
  final String? query;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ilustración (usa tu asset si lo tienes)
            // Image.asset('assets/empty_search.png', height: 140),
            Icon(Icons.search_off_rounded, size: 120, color: cs.primary.withOpacity(0.25)),
            const SizedBox(height: 16),

            Text('No se encontraron resultados',
                textAlign: TextAlign.center,
                style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface)),
            const SizedBox(height: 8),

            Text(
              query == null || query!.isEmpty
                  ? 'No se ha encontrado la búsqueda. Intenta con otra palabra.'
                  : 'No se encontró “$query”. Revisa la ortografía o prueba con otra palabra.',
              textAlign: TextAlign.center,
              style: tt.bodyMedium!.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 20),

            FilledButton.tonal(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
