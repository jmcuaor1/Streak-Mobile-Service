import 'package:flutter/material.dart';
import 'package:streak/models/company_profile.dart';

class CompanyInfoTab extends StatelessWidget {
  final CompanyProfile info;
  final String about;

  const CompanyInfoTab({
    super.key,
    required this.info,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Descripción de la empresa ---
          Text('Sobre la empresa', style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            about,
            style: tt.bodyMedium!.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          // --- Información general ---
          _InfoRow(label: 'Sitio web', value: info.website),
          _InfoRow(label: 'Sector', value: info.sector),
          _InfoRow(label: 'Tamaño del personal', value: info.headcount),
          _InfoRow(label: 'Oficina central', value: info.hq),
          _InfoRow(label: 'Tipo', value: info.type),
          _InfoRow(label: 'Fundada', value: info.founded),
          _InfoRow(label: 'Especialidad', value: info.specialty),

          const SizedBox(height: 16),

          // --- Galería ---
          if (info.galleryUrls.isNotEmpty) ...[
            Text('Galería de la empresa', style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SizedBox(
              height: 86,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: info.galleryUrls.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      info.galleryUrls[i],
                      width: 140,
                      height: 86,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: tt.bodyMedium!.copyWith(fontWeight: FontWeight.w700)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: tt.bodyMedium),
          ),
        ],
      ),
    );
  }
}
