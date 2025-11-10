import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Widget de navegación inferior
/// Navegación principal de la aplicación con FAB central
class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onFabTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onFabTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        height: 56, // Reducido de 60 a 56 para evitar overflow
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home
            _NavIcon(
              icon: Icons.home_filled,
              label: 'Inicio',
              active: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            
            // Search
            _NavIcon(
              icon: Icons.search,
              label: 'Buscar',
              active: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            
            // Espacio para FAB
            const SizedBox(width: 40),
            
            // Gigs
            _NavIcon(
              icon: Icons.flash_on,
              label: 'Gigs',
              active: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            
            // Profile
            _NavIcon(
              icon: Icons.person_outline,
              label: 'Perfil',
              active: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de FAB personalizado para la navegación
class NavFab extends StatelessWidget {
  const NavFab({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

/// Icono de navegación individual
class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Reducido de 8 a 6
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active ? AppColors.primary : AppColors.grey400,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: active ? AppColors.primary : AppColors.grey400,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

