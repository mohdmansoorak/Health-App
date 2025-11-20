import 'package:flutter/material.dart';

/// App color palette following medical/health insurance theme
/// Based on Bupa Arabia style with professional blue tones
class AppColors {
  // Primary - Medical Blue
  static const primary = Color(0xFF2563EB);
  static const primaryDark = Color(0xFF1E40AF);
  static const primaryLight = Color(0xFF3B82F6);
  static const primaryLighter = Color(0xFF60A5FA);

  // Secondary - Trust Green
  static const secondary = Color(0xFF10B981);
  static const secondaryDark = Color(0xFF059669);
  static const secondaryLight = Color(0xFF34D399);

  // Status Colors
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Neutrals
  static const background = Color(0xFFF9FAFB);
  static const surface = Colors.white;
  static const surfaceVariant = Color(0xFFF3F4F6);

  static const text = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);

  static const border = Color(0xFFE5E7EB);
  static const borderLight = Color(0xFFF3F4F6);

  static const divider = Color(0xFFE5E7EB);

  // Gradients
  static const gradientStart = primaryDark;
  static const gradientEnd = primaryLight;

  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  // Appointment Type Colors
  static const instantConsultation = Color(0xFF8B5CF6);
  static const onlineBooking = Color(0xFF3B82F6);
  static const physicalClinic = Color(0xFF10B981);

  // Status Badge Colors
  static const approved = Color(0xFF10B981);
  static const pending = Color(0xFFF59E0B);
  static const rejected = Color(0xFFEF4444);
  static const processing = Color(0xFF3B82F6);

  // Shadow
  static Color shadow = Colors.black.withOpacity(0.1);
}
