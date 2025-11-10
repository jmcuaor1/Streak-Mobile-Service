import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1E63D0), borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('50% de descuento\nen cualquier curso', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.2)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: cs.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text('Únete ya'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Si aún no tienes la imagen, deja un placeholder:
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(width: 90, height: 90, child: Container(color: Colors.white24)),
          ),
        ],
      ),
    );
  }
}
