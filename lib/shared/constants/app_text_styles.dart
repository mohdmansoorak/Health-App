import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography system for the app
/// Supports both LTR (Inter/SF Pro) and RTL (Cairo) fonts
class AppTextStyles {
  // Display styles
  static const display1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: AppColors.text,
  );

  static const display2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: AppColors.text,
  );

  // Headings
  static const h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: AppColors.text,
  );

  static const h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.text,
  );

  static const h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.text,
  );

  static const h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.text,
  );

  // Body text
  static const body1 = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: AppColors.text,
  );

  static const body2 = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: AppColors.text,
  );

  static const body3 = TextStyle(
    fontSize: 12,
    height: 1.5,
    color: AppColors.text,
  );

  // Special
  static const caption = TextStyle(
    fontSize: 12,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static const overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  // Link
  static const link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // Badge/Chip
  static const badge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
