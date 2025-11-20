import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import 'package:intl/intl.dart';

/// Digital insurance card widget with QR code
class DigitalCardWidget extends StatelessWidget {
  const DigitalCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final l10n = AppLocalizations.of(context);
    final member = memberProvider.primaryMember;
    final policy = memberProvider.activePolicy;

    if (member == null || policy == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showQrCodeDialog(context, member, policy);
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusLG),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeProvider.isArabic
                              ? 'بطاقتي الرقمية'
                              : 'My Digital Card',
                          style: AppTextStyles.subtitle1.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          localeProvider.isArabic ? member.nameAr : member.name,
                          style: AppTextStyles.h3.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // QR Code Preview
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingXS),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                      ),
                      child: QrImageView(
                        data: member.memberId,
                        version: QrVersions.auto,
                        size: 60,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingLG),

                // Card Details
                Row(
                  children: [
                    Expanded(
                      child: _CardDetail(
                        label: l10n.membershipId,
                        value: member.memberId,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMD),
                    Expanded(
                      child: _CardDetail(
                        label: localeProvider.isArabic
                            ? 'رقم الوثيقة'
                            : 'Policy Number',
                        value: policy.policyNumber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingMD),

                // Valid Until
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CardDetail(
                      label: localeProvider.isArabic ? 'صالحة حتى' : 'Valid Until',
                      value: DateFormat('dd/MM/yyyy').format(policy.endDate),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 16,
                        ),
                        const SizedBox(width: AppTheme.spacingXS),
                        Text(
                          localeProvider.isArabic ? 'نشط' : 'Active',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingMD),

                // Tap to view QR hint
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.qr_code_rounded,
                        color: Colors.white.withOpacity(0.7),
                        size: 16,
                      ),
                      const SizedBox(width: AppTheme.spacingXS),
                      Text(
                        localeProvider.isArabic
                            ? 'اضغط لعرض رمز الاستجابة السريعة'
                            : 'Tap to view QR code',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQrCodeDialog(BuildContext context, member, policy) {
    final localeProvider = context.read<LocaleProvider>();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLG),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localeProvider.isArabic
                    ? 'بطاقة العضوية الرقمية'
                    : 'Digital Membership Card',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: AppTheme.spacingLG),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMD),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                  border: Border.all(color: AppColors.border, width: 2),
                ),
                child: QrImageView(
                  data: member.memberId,
                  version: QrVersions.auto,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              Text(
                localeProvider.isArabic ? member.nameAr : member.name,
                style: AppTextStyles.h4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingXS),
              Text(
                member.memberId,
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(localeProvider.isArabic ? 'إغلاق' : 'Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String label;
  final String value;

  const _CardDetail({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          value,
          style: AppTextStyles.subtitle2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
