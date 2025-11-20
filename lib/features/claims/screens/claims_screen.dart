import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

/// Claims and benefits screen
class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = context.watch<LocaleProvider>().isArabic;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.claims),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: isArabic ? 'المطالبات' : 'Claims'),
            Tab(text: isArabic ? 'المزايا' : 'Benefits'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ClaimsTab(),
          _BenefitsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Submit new claim
        },
        icon: const Icon(Icons.add),
        label: Text(isArabic ? 'مطالبة جديدة' : 'New Claim'),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class _ClaimsTab extends StatelessWidget {
  const _ClaimsTab();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LocaleProvider>().isArabic;

    // Mock claims data
    final mockClaims = [
      {
        'id': 'CLM-2024-001',
        'date': DateTime.now().subtract(const Duration(days: 5)),
        'type': isArabic ? 'استشارة طبية' : 'Medical Consultation',
        'amount': 250.0,
        'status': 'approved',
        'provider': isArabic ? 'مستشفى الملك فيصل' : 'King Faisal Hospital',
      },
      {
        'id': 'CLM-2024-002',
        'date': DateTime.now().subtract(const Duration(days: 15)),
        'type': isArabic ? 'وصفة طبية' : 'Prescription',
        'amount': 120.0,
        'status': 'pending',
        'provider': isArabic ? 'صيدلية النهدي' : 'Nahdi Pharmacy',
      },
      {
        'id': 'CLM-2023-089',
        'date': DateTime.now().subtract(const Duration(days: 60)),
        'type': isArabic ? 'فحوصات مخبرية' : 'Lab Tests',
        'amount': 450.0,
        'status': 'rejected',
        'provider': isArabic ? 'مختبرات البرج' : 'Al-Borg Laboratories',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      itemCount: mockClaims.length,
      itemBuilder: (context, index) {
        final claim = mockClaims[index];
        return _ClaimCard(claim: claim);
      },
    );
  }
}

class _ClaimCard extends StatelessWidget {
  final Map<String, dynamic> claim;

  const _ClaimCard({required this.claim});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getStatusText(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'موافق عليها' : 'Approved';
      case 'pending':
        return isArabic ? 'قيد المراجعة' : 'Pending';
      case 'rejected':
        return isArabic ? 'مرفوضة' : 'Rejected';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LocaleProvider>().isArabic;

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMD),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to claim details
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    claim['id'],
                    style: AppTextStyles.subtitle2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSM,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(claim['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                    child: Text(
                      _getStatusText(claim['status'], isArabic),
                      style: AppTextStyles.caption.copyWith(
                        color: _getStatusColor(claim['status']),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // Claim details
              Row(
                children: [
                  Icon(
                    Icons.medical_services_rounded,
                    size: 40,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          claim['type'],
                          style: AppTextStyles.subtitle1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          claim['provider'],
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // Date and amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, yyyy').format(claim['date']),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${claim['amount'].toStringAsFixed(2)} ${isArabic ? 'ريال' : 'SAR'}',
                    style: AppTextStyles.subtitle1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitsTab extends StatelessWidget {
  const _BenefitsTab();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LocaleProvider>().isArabic;

    return ListView(
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      children: [
        // Coverage Summary Card
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLG),
          ),
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'ملخص التغطية' : 'Coverage Summary',
                  style: AppTextStyles.h4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLG),
                _CoverageStat(
                  label: isArabic ? 'الحد الأقصى السنوي' : 'Annual Limit',
                  value: isArabic ? '500,000 ريال' : '500,000 SAR',
                ),
                const SizedBox(height: AppTheme.spacingMD),
                _CoverageStat(
                  label: isArabic ? 'المستخدم حتى الآن' : 'Used so far',
                  value: isArabic ? '12,450 ريال' : '12,450 SAR',
                ),
                const SizedBox(height: AppTheme.spacingMD),
                _CoverageStat(
                  label: isArabic ? 'المتبقي' : 'Remaining',
                  value: isArabic ? '487,550 ريال' : '487,550 SAR',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingXL),

        // Quick Links
        Text(
          isArabic ? 'روابط سريعة' : 'Quick Links',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: AppTheme.spacingMD),

        _BenefitCard(
          icon: Icons.local_hospital_rounded,
          iconColor: AppColors.primary,
          title: isArabic ? 'جدول المزايا' : 'Table of Benefits',
          onTap: () {
            // TODO: View table of benefits
          },
        ),
        const SizedBox(height: AppTheme.spacingMD),

        _BenefitCard(
          icon: Icons.business_rounded,
          iconColor: AppColors.info,
          title: isArabic ? 'شبكة مقدمي الخدمة' : 'Provider Network',
          onTap: () {
            // TODO: View provider network
          },
        ),
        const SizedBox(height: AppTheme.spacingMD),

        _BenefitCard(
          icon: Icons.verified_user_rounded,
          iconColor: AppColors.secondary,
          title: isArabic ? 'الموافقة المسبقة' : 'Pre-Authorization',
          onTap: () {
            // TODO: Request pre-authorization
          },
        ),
      ],
    );
  }
}

class _CoverageStat extends StatelessWidget {
  final String label;
  final String value;

  const _CoverageStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body1.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.subtitle1.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const _BenefitCard({
    required this.icon,
    required this.iconColor,
    required this.title,
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
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: AppTheme.spacingMD),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
