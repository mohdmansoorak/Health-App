import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../home/widgets/bottom_nav_bar.dart';

/// Profile and settings screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final authProvider = context.watch<AuthProvider>();
    final l10n = AppLocalizations.of(context);
    final isArabic = localeProvider.isArabic;
    final member = memberProvider.primaryMember;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Header
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        member?.name.substring(0, 1).toUpperCase() ?? 'U',
                        style: AppTextStyles.display.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    Text(
                      isArabic ? member?.nameAr ?? '' : member?.name ?? '',
                      style: AppTextStyles.h3,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      '${isArabic ? 'رقم العضوية' : 'Member ID'}: ${member?.memberId ?? ''}',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMD,
                        vertical: AppTheme.spacingSM,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 16,
                          ),
                          const SizedBox(width: AppTheme.spacingXS),
                          Text(
                            isArabic ? 'نشط' : 'Active',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // Account Section
            Text(
              isArabic ? 'الحساب' : 'Account',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _SettingCard(
              icon: Icons.person_rounded,
              iconColor: AppColors.primary,
              title: isArabic ? 'المعلومات الشخصية' : 'Personal Information',
              onTap: () {
                // TODO: Navigate to personal info
              },
            ),
            const SizedBox(height: AppTheme.spacingSM),

            _SettingCard(
              icon: Icons.family_restroom_rounded,
              iconColor: AppColors.info,
              title: isArabic ? 'الأفراد المشمولين' : 'Family Members',
              subtitle: isArabic
                  ? '${memberProvider.dependents.length} أفراد'
                  : '${memberProvider.dependents.length} members',
              onTap: () {
                // TODO: Navigate to family members
              },
            ),
            const SizedBox(height: AppTheme.spacingSM),

            _SettingCard(
              icon: Icons.credit_card_rounded,
              iconColor: AppColors.secondary,
              title: isArabic ? 'طرق الدفع' : 'Payment Methods',
              onTap: () {
                // TODO: Navigate to payment methods
              },
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // Settings Section
            Text(
              l10n.settings,
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _SettingCard(
              icon: Icons.language_rounded,
              iconColor: AppColors.primary,
              title: l10n.language,
              subtitle: isArabic ? 'العربية' : 'English',
              trailing: Switch(
                value: isArabic,
                onChanged: (value) {
                  localeProvider.toggleLocale();
                },
                activeColor: AppColors.primary,
              ),
              onTap: () {
                localeProvider.toggleLocale();
              },
            ),
            const SizedBox(height: AppTheme.spacingSM),

            _SettingCard(
              icon: Icons.fingerprint_rounded,
              iconColor: AppColors.info,
              title: isArabic ? 'المصادقة البيومترية' : 'Biometric Authentication',
              subtitle: authProvider.isBiometricEnabled
                  ? (isArabic ? 'مفعّل' : 'Enabled')
                  : (isArabic ? 'معطّل' : 'Disabled'),
              trailing: Switch(
                value: authProvider.isBiometricEnabled,
                onChanged: (value) async {
                  if (value) {
                    await authProvider.enableBiometric();
                  } else {
                    await authProvider.disableBiometric();
                  }
                },
                activeColor: AppColors.primary,
              ),
              onTap: () async {
                if (!authProvider.isBiometricEnabled) {
                  await authProvider.enableBiometric();
                } else {
                  await authProvider.disableBiometric();
                }
              },
            ),
            const SizedBox(height: AppTheme.spacingSM),

            _SettingCard(
              icon: Icons.notifications_rounded,
              iconColor: AppColors.warning,
              title: l10n.notifications,
              onTap: () {
                // TODO: Navigate to notification settings
              },
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // Support Section
            Text(
              isArabic ? 'الدعم' : 'Support',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacingMD),

            _SettingCard(
              icon: Icons.help_outline_rounded,
              iconColor: AppColors.info,
              title: isArabic ? 'مركز المساعدة' : 'Help Center',
              onTap: () {
                // TODO: Navigate to help center
              },
            ),
            const SizedBox(height: AppTheme.spacingSM),

            _SettingCard(
              icon: Icons.contact_support_rounded,
              iconColor: AppColors.secondary,
              title: isArabic ? 'اتصل بنا' : 'Contact Us',
              onTap: () {
                // TODO: Navigate to contact us
              },
            ),
            const SizedBox(height: AppTheme.spacingSM),

            _SettingCard(
              icon: Icons.info_outline_rounded,
              iconColor: AppColors.primary,
              title: isArabic ? 'عن التطبيق' : 'About',
              subtitle: 'Version 1.0.0',
              onTap: () {
                // TODO: Show about dialog
              },
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // Logout Button
            ElevatedButton(
              onPressed: () async {
                await authProvider.logout();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout_rounded),
                  const SizedBox(width: AppTheme.spacingSM),
                  Text(l10n.logout),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
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
                padding: const EdgeInsets.all(AppTheme.spacingSM),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: AppTheme.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.subtitle2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else
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
