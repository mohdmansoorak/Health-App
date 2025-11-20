import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../widgets/digital_card_widget.dart';
import '../widgets/service_card_widget.dart';
import '../widgets/bottom_nav_bar.dart';

/// Home screen with CareConnect services and dashboard
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load member data if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MemberProvider>().loadMemberData();
    });
  }

  void _onNavItemTapped(int index) {
    setState(() => _selectedIndex = index);
    // TODO: Navigate to different tabs
    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        // Care/Appointments
        context.push('/appointments');
        break;
      case 2:
        // Wellness
        context.push('/wellness');
        break;
      case 3:
        // Claims
        context.push('/claims');
        break;
      case 4:
        // Profile
        context.push('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final memberProvider = context.watch<MemberProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final member = memberProvider.primaryMember;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: AppTextStyles.h2.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          // Language toggle
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => localeProvider.toggleLocale(),
            tooltip: localeProvider.isArabic ? 'English' : 'العربية',
          ),
          // Notifications
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          // Profile
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppTheme.spacingSM),
            child: GestureDetector(
              onTap: () => context.push('/profile'),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  member?.name.substring(0, 1).toUpperCase() ?? 'U',
                  style: AppTextStyles.button.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => memberProvider.loadMemberData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppTheme.spacingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome message
                if (member != null) ...[
                  Text(
                    l10n.welcomeBack,
                    style: AppTextStyles.h3,
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    localeProvider.isArabic ? member.nameAr : member.name,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLG),
                ],

                // Digital Insurance Card
                const DigitalCardWidget(),
                const SizedBox(height: AppTheme.spacingXL),

                // CareConnect Services Section
                Text(
                  l10n.careConnectServices,
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: AppTheme.spacingMD),

                // Instant Consultation
                ServiceCardWidget(
                  icon: Icons.video_call_rounded,
                  iconColor: AppColors.instantConsultation,
                  title: l10n.instantConsultation,
                  subtitle: localeProvider.isArabic
                      ? 'تحدث مع طبيب عام الآن - على مدار الساعة'
                      : 'Talk to GP now - 24/7',
                  onTap: () {
                    // TODO: Navigate to instant consultation
                    context.push('/booking/instant');
                  },
                ),
                const SizedBox(height: AppTheme.spacingMD),

                // Online Booking
                ServiceCardWidget(
                  icon: Icons.calendar_today_rounded,
                  iconColor: AppColors.onlineBooking,
                  title: l10n.onlineBooking,
                  subtitle: localeProvider.isArabic
                      ? 'استشارة مرئية مع أخصائيين'
                      : 'Video consultation with specialists',
                  onTap: () {
                    // TODO: Navigate to online booking
                    context.push('/booking/online');
                  },
                ),
                const SizedBox(height: AppTheme.spacingMD),

                // Physical Clinic
                ServiceCardWidget(
                  icon: Icons.local_hospital_rounded,
                  iconColor: AppColors.physicalClinic,
                  title: l10n.physicalClinic,
                  subtitle: localeProvider.isArabic
                      ? 'زيارة عيادتنا في الرياض'
                      : 'Visit our clinic in Riyadh',
                  onTap: () {
                    // TODO: Navigate to physical clinic booking
                    context.push('/booking/physical');
                  },
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // Quick Access Cards Row 1
                Row(
                  children: [
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.vaccines_rounded,
                        iconColor: AppColors.info,
                        title: localeProvider.isArabic ? 'التطعيمات' : 'Vaccinations',
                        onTap: () {
                          // TODO: Navigate to vaccinations
                        },
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMD),
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.favorite_rounded,
                        iconColor: AppColors.secondary,
                        title: localeProvider.isArabic ? 'العافية والولاء' : 'Wellness',
                        subtitle: localeProvider.isArabic
                            ? '${member?.loyaltyPoints ?? 0} نقطة'
                            : '${member?.loyaltyPoints ?? 0} pts',
                        onTap: () {
                          context.push('/wellness');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingMD),

                // Quick Access Cards Row 2
                Row(
                  children: [
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.medical_services_rounded,
                        iconColor: AppColors.warning,
                        title: localeProvider.isArabic
                            ? 'إدارة الأمراض المزمنة'
                            : 'Chronic Care',
                        onTap: () {
                          // TODO: Navigate to chronic management
                        },
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMD),
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.psychology_rounded,
                        iconColor: AppColors.primaryDark,
                        title: localeProvider.isArabic
                            ? 'المساعد الذكي'
                            : 'Health Brain AI',
                        onTap: () {
                          // TODO: Navigate to AI assistant
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingLG),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}

/// Small quick access card widget
class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingSM),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                title,
                style: AppTextStyles.subtitle1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppTheme.spacingXS),
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
      ),
    );
  }
}
