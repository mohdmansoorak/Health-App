import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import 'package:intl/intl.dart';

/// Step 6: Confirmation - Review all details before booking
class ConfirmationStep extends StatelessWidget {
  const ConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final memberProvider = context.watch<MemberProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;

    // Get selected data
    final selectedMember = memberProvider.allMembers.firstWhere(
      (m) => m.memberId == appointmentProvider.selectedMemberId,
      orElse: () => memberProvider.primaryMember!,
    );
    final doctor = appointmentProvider.selectedDoctor;
    final date = appointmentProvider.selectedDate;
    final time = appointmentProvider.selectedTime;
    final appointmentType = appointmentProvider.selectedType;

    if (doctor == null || date == null || time == null) {
      return Center(
        child: Text(
          isArabic
              ? 'معلومات الحجز غير مكتملة'
              : 'Booking information incomplete',
          style: AppTextStyles.body1.copyWith(color: AppColors.error),
        ),
      );
    }

    final consultationFee = doctor.consultationFee;
    final insuranceCoverage = consultationFee * 0.8;
    final copayment = consultationFee - insuranceCoverage;

    // Format date and time
    final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(date);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);

    String appointmentTypeText = '';
    IconData appointmentTypeIcon = Icons.calendar_today;
    Color appointmentTypeColor = AppColors.primary;

    switch (appointmentType) {
      case null:
        break;
      case AppointmentType.instantConsultation:
        appointmentTypeText = isArabic ? 'استشارة فورية' : 'Instant Consultation';
        appointmentTypeIcon = Icons.video_call_rounded;
        appointmentTypeColor = AppColors.instantConsultation;
        break;
      case AppointmentType.onlineConsultation:
        appointmentTypeText = isArabic ? 'حجز أونلاين' : 'Online Consultation';
        appointmentTypeIcon = Icons.videocam_rounded;
        appointmentTypeColor = AppColors.onlineBooking;
        break;
      case AppointmentType.physicalClinic:
        appointmentTypeText = isArabic ? 'عيادة فعلية' : 'Physical Clinic';
        appointmentTypeIcon = Icons.local_hospital_rounded;
        appointmentTypeColor = AppColors.physicalClinic;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Success Icon
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              size: 80,
              color: AppColors.success,
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        Text(
          isArabic ? 'تأكيد الحجز' : 'Confirm Booking',
          style: AppTextStyles.h3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spacingSM),

        Text(
          isArabic
              ? 'راجع تفاصيل موعدك قبل التأكيد'
              : 'Review your appointment details before confirming',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spacingXL),

        // Appointment Type Badge
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMD),
          decoration: BoxDecoration(
            color: appointmentTypeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            border: Border.all(
              color: appointmentTypeColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(appointmentTypeIcon, color: appointmentTypeColor, size: 24),
              const SizedBox(width: AppTheme.spacingSM),
              Text(
                appointmentTypeText,
                style: AppTextStyles.subtitle1.copyWith(
                  color: appointmentTypeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Details Card
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
                // Member
                _DetailRow(
                  icon: Icons.person_rounded,
                  label: isArabic ? 'المريض' : 'Patient',
                  value: isArabic ? selectedMember.nameAr : selectedMember.name,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                Divider(color: AppColors.border),
                const SizedBox(height: AppTheme.spacingMD),

                // Doctor
                _DetailRow(
                  icon: Icons.medical_services_rounded,
                  label: isArabic ? 'الطبيب' : 'Doctor',
                  value: isArabic ? doctor.nameAr : doctor.name,
                  subtitle: isArabic ? doctor.specialtyAr : doctor.specialty,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                Divider(color: AppColors.border),
                const SizedBox(height: AppTheme.spacingMD),

                // Date & Time
                _DetailRow(
                  icon: Icons.calendar_today_rounded,
                  label: isArabic ? 'التاريخ والوقت' : 'Date & Time',
                  value: formattedDate,
                  subtitle: formattedTime,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                Divider(color: AppColors.border),
                const SizedBox(height: AppTheme.spacingMD),

                // Payment
                _DetailRow(
                  icon: Icons.payments_rounded,
                  label: isArabic ? 'المبلغ المطلوب' : 'Amount Due',
                  value: '${copayment.toStringAsFixed(2)} ${isArabic ? 'ريال' : 'SAR'}',
                  subtitle: isArabic
                      ? '(تغطية التأمين: ${insuranceCoverage.toStringAsFixed(2)} ريال)'
                      : '(Insurance coverage: ${insuranceCoverage.toStringAsFixed(2)} SAR)',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Important Notice
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMD),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            border: Border.all(
              color: AppColors.warning.withOpacity(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.warning,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'تنبيه هام' : 'Important Notice',
                      style: AppTextStyles.subtitle2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isArabic
                          ? 'سيتم إرسال تأكيد الموعد عبر الرسائل القصيرة والبريد الإلكتروني. يرجى الحضور قبل 15 دقيقة من الموعد.'
                          : 'Appointment confirmation will be sent via SMS and email. Please arrive 15 minutes before your appointment time.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Terms and conditions
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check_box_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacingSM),
            Expanded(
              child: Text(
                isArabic
                    ? 'بالضغط على تأكيد الحجز، فإنك توافق على الشروط والأحكام وسياسة الإلغاء.'
                    : 'By confirming this booking, you agree to the terms and conditions and cancellation policy.',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingSM),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSM),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: AppTheme.spacingMD),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.body1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
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
      ],
    );
  }
}
