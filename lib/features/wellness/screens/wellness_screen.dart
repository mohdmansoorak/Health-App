import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../home/widgets/bottom_nav_bar.dart';

/// Wellness and loyalty programs screen
class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;
    final l10n = AppLocalizations.of(context);
    final member = memberProvider.primaryMember;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wellness),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Loyalty Points Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              ),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.secondary, Color(0xFF059669)],
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    Text(
                      isArabic ? 'نقاط الولاء' : 'Loyalty Points',
                      style: AppTextStyles.subtitle1.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    Text(
                      '${member?.loyaltyPoints ?? 0}',
                      style: AppTextStyles.display.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement redeem rewards
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.secondary,
                      ),
                      child: Text(
                        isArabic ? 'استبدال المكافآت' : 'Redeem Rewards',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // Wellness Programs Section
            Text(
              isArabic ? 'برامج العافية' : 'Wellness Programs',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _ProgramCard(
              icon: Icons.medical_services_rounded,
              iconColor: AppColors.warning,
              title: isArabic ? 'إدارة الأمراض المزمنة' : 'Chronic Disease Management',
              description: isArabic
                  ? 'برامج متخصصة لإدارة الأمراض المزمنة مثل السكري وضغط الدم'
                  : 'Specialized programs for managing chronic conditions like diabetes and hypertension',
              onTap: () {
                // TODO: Navigate to chronic management
              },
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _ProgramCard(
              icon: Icons.fitness_center_rounded,
              iconColor: AppColors.info,
              title: isArabic ? 'تتبع اللياقة البدنية' : 'Fitness Tracking',
              description: isArabic
                  ? 'تتبع نشاطك البدني واكسب نقاط ولاء'
                  : 'Track your physical activity and earn loyalty points',
              onTap: () {
                // TODO: Navigate to fitness tracking
              },
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _ProgramCard(
              icon: Icons.restaurant_rounded,
              iconColor: AppColors.secondary,
              title: isArabic ? 'التغذية الصحية' : 'Healthy Nutrition',
              description: isArabic
                  ? 'نصائح غذائية وخطط وجبات مخصصة'
                  : 'Nutrition advice and personalized meal plans',
              onTap: () {
                // TODO: Navigate to nutrition
              },
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _ProgramCard(
              icon: Icons.self_improvement_rounded,
              iconColor: AppColors.primaryDark,
              title: isArabic ? 'الصحة النفسية' : 'Mental Health',
              description: isArabic
                  ? 'دعم الصحة النفسية والرفاهية العامة'
                  : 'Mental health support and overall wellbeing',
              onTap: () {
                // TODO: Navigate to mental health
              },
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _ProgramCard(
              icon: Icons.pregnant_woman_rounded,
              iconColor: Color(0xFFEC4899),
              title: isArabic ? 'صحة الأم والطفل' : 'Mother & Child Health',
              description: isArabic
                  ? 'برامج دعم صحة الأم والطفل'
                  : 'Support programs for maternal and child health',
              onTap: () {
                // TODO: Navigate to mother & child health
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ProgramCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMD),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMD),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                ),
                child: Icon(icon, color: iconColor, size: 32),
              ),
              const SizedBox(width: AppTheme.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      description,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
