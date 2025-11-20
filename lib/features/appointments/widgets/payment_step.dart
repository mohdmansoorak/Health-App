import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

/// Step 5: Payment details
class PaymentStep extends StatefulWidget {
  const PaymentStep({super.key});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  String _paymentMethod = 'insurance';

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;

    // Get consultation fee from selected doctor
    final consultationFee =
        appointmentProvider.selectedDoctor?.consultationFee ?? 0.0;
    final insuranceCoverage = consultationFee * 0.8; // 80% coverage
    final copayment = consultationFee - insuranceCoverage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic ? 'تفاصيل الدفع' : 'Payment Details',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        Text(
          isArabic
              ? 'راجع تفاصيل الدفع واختر طريقة الدفع'
              : 'Review payment details and select payment method',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Cost Breakdown
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'ملخص التكلفة' : 'Cost Summary',
                  style: AppTextStyles.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMD),

                _CostRow(
                  label: isArabic ? 'رسوم الاستشارة' : 'Consultation Fee',
                  amount: consultationFee,
                  isArabic: isArabic,
                ),
                const SizedBox(height: AppTheme.spacingSM),

                _CostRow(
                  label: isArabic ? 'التغطية التأمينية (80%)' : 'Insurance Coverage (80%)',
                  amount: -insuranceCoverage,
                  isArabic: isArabic,
                  isDiscount: true,
                ),
                const SizedBox(height: AppTheme.spacingMD),

                Divider(color: AppColors.border),
                const SizedBox(height: AppTheme.spacingSM),

                _CostRow(
                  label: isArabic ? 'المبلغ المطلوب (التحمل)' : 'Amount Due (Copayment)',
                  amount: copayment,
                  isArabic: isArabic,
                  isTotal: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingXL),

        // Payment Method
        Text(
          isArabic ? 'طريقة الدفع' : 'Payment Method',
          style: AppTextStyles.subtitle1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppTheme.spacingMD),

        // Insurance Coverage
        _PaymentMethodCard(
          value: 'insurance',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
          icon: Icons.health_and_safety_rounded,
          iconColor: AppColors.primary,
          title: isArabic ? 'التأمين الصحي' : 'Health Insurance',
          subtitle: isArabic
              ? 'تغطية 80% من التكلفة'
              : '80% coverage, copayment required',
        ),
        const SizedBox(height: AppTheme.spacingMD),

        // Credit/Debit Card
        _PaymentMethodCard(
          value: 'card',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
          icon: Icons.credit_card_rounded,
          iconColor: AppColors.info,
          title: isArabic ? 'بطاقة ائتمان/مدين' : 'Credit/Debit Card',
          subtitle: isArabic ? 'ادفع المبلغ كاملاً بالبطاقة' : 'Pay full amount by card',
        ),
        const SizedBox(height: AppTheme.spacingMD),

        // Apple Pay / STC Pay
        _PaymentMethodCard(
          value: 'wallet',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
          icon: Icons.account_balance_wallet_rounded,
          iconColor: AppColors.secondary,
          title: isArabic ? 'المحفظة الرقمية' : 'Digital Wallet',
          subtitle: isArabic
              ? 'Apple Pay, STC Pay, أو مدى'
              : 'Apple Pay, STC Pay, or Mada',
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Info notice
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMD),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.info,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingMD),
              Expanded(
                child: Text(
                  isArabic
                      ? 'سيتم تأكيد الدفع في الخطوة التالية. لن يتم الخصم حتى تتم الموافقة.'
                      : 'Payment will be confirmed in the next step. No charges will be made until approved.',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CostRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isArabic;
  final bool isDiscount;
  final bool isTotal;

  const _CostRow({
    required this.label,
    required this.amount,
    required this.isArabic,
    this.isDiscount = false,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.w600)
              : AppTextStyles.body2,
        ),
        Text(
          '${amount >= 0 ? '' : '-'}${amount.abs().toStringAsFixed(2)} ${isArabic ? 'ريال' : 'SAR'}',
          style: isTotal
              ? AppTextStyles.h4.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                )
              : AppTextStyles.body1.copyWith(
                  color: isDiscount ? AppColors.success : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _PaymentMethodCard({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => onChanged(value),
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
                child: Icon(icon, color: iconColor, size: 28),
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
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
