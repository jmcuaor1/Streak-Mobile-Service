import 'package:flutter/material.dart';

/// Colores de la aplicación Streak
class AppColors {
  // ==================== COLORES PRIMARIOS ====================
  
  /// Color primario - Azul Streak
  static const Color primary = Color(0xFF2F6FED);
  static const Color primaryDark = Color(0xFF1E5BC8);
  static const Color primaryLight = Color(0xFF5E94FF);
  
  /// Color secundario - Púrpura
  static const Color secondary = Color(0xFF6E57E0);
  static const Color secondaryDark = Color(0xFF5641B5);
  static const Color secondaryLight = Color(0xFF8E7AEC);
  
  /// Color terciario - Verde (para streaks/gamificación)
  static const Color tertiary = Color(0xFF10B981);
  static const Color tertiaryDark = Color(0xFF059669);
  static const Color tertiaryLight = Color(0xFF34D399);
  
  // ==================== COLORES DE ESTADO ====================
  
  /// Success - Verde
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  
  /// Error - Rojo
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  
  /// Warning - Amarillo
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  
  /// Info - Azul claro
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  
  // ==================== ESCALA DE GRISES ====================
  
  static const Color black = Color(0xFF000000);
  static const Color grey900 = Color(0xFF111827);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);
  
  // ==================== COLORES DE FONDO ====================
  
  /// Background principal
  static const Color background = Color(0xFFF8F9FA);
  
  /// Background de cards
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  /// Background de inputs
  static const Color inputBackground = Color(0xFFF3F4F6);
  
  // ==================== COLORES DE TEXTO ====================
  
  /// Texto principal
  static const Color textPrimary = Color(0xFF111827);
  
  /// Texto secundario
  static const Color textSecondary = Color(0xFF6B7280);
  
  /// Texto deshabilitado
  static const Color textDisabled = Color(0xFF9CA3AF);
  
  /// Texto en fondos oscuros
  static const Color textOnDark = Color(0xFFFFFFFF);
  
  // ==================== GRADIENTES ====================
  
  /// Gradiente primario (para headers, cards especiales, etc.)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3E1BFF), Color(0xFF6E57E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Gradiente de success (para streaks activos)
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Gradiente de card (sutil)
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // ==================== COLORES ESPECÍFICOS DE STREAK ====================
  
  /// Color para streak activo
  static const Color streakActive = Color(0xFFFF6B35);
  
  /// Color para achievement desbloqueado
  static const Color achievementUnlocked = Color(0xFFFFD700);
  
  /// Color para nivel completado
  static const Color levelComplete = Color(0xFF10B981);
  
  // ==================== SOMBRAS ====================
  
  /// Sombra suave para cards
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 15,
      offset: Offset(0, 5),
    ),
  ];
  
  /// Sombra para botones elevados
  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];
}

