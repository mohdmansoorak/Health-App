import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/models/doctor.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

/// Step 3: Doctor selection
class DoctorSelectionStep extends StatefulWidget {
  const DoctorSelectionStep({super.key});

  @override
  State<DoctorSelectionStep> createState() => _DoctorSelectionStepState();
}

class _DoctorSelectionStepState extends State<DoctorSelectionStep> {
  List<Doctor> _mockDoctors = [];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  void _loadDoctors() {
    // Mock doctor data - in production, fetch from API based on specialty
    _mockDoctors = [
      Doctor(
        id: 'doc1',
        name: 'Dr. John Smith',
        nameAr: 'د. جون سميث',
        specialty: 'General Physician',
        specialtyAr: 'طبيب عام',
        rating: 4.8,
        reviewCount: 156,
        experience: 15,
        languages: ['English', 'Arabic'],
        availableSlots: 12,
        consultationFee: 150.0,
      ),
      Doctor(
        id: 'doc2',
        name: 'Dr. Sarah Johnson',
        nameAr: 'د. سارة جونسون',
        specialty: 'Dermatologist',
        specialtyAr: 'أخصائية أمراض جلدية',
        rating: 4.9,
        reviewCount: 203,
        experience: 12,
        languages: ['English'],
        availableSlots: 8,
        consultationFee: 200.0,
      ),
      Doctor(
        id: 'doc3',
        name: 'Dr. Ahmed Hassan',
        nameAr: 'د. أحمد حسن',
        specialty: 'Cardiologist',
        specialtyAr: 'أخصائي أمراض قلب',
        rating: 4.7,
        reviewCount: 189,
        experience: 20,
        languages: ['Arabic', 'English'],
        availableSlots: 5,
        consultationFee: 250.0,
      ),
      Doctor(
        id: 'doc4',
        name: 'Dr. Fatima Al-Rashid',
        nameAr: 'د. فاطمة الراشد',
        specialty: 'Pediatrician',
        specialtyAr: 'أخصائية أطفال',
        rating: 5.0,
        reviewCount: 312,
        experience: 18,
        languages: ['Arabic', 'English', 'French'],
        availableSlots: 15,
        consultationFee: 180.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic ? 'اختر الطبيب' : 'Select Doctor',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        Text(
          isArabic
              ? 'اختر الطبيب المناسب من القائمة أدناه'
              : 'Choose your preferred doctor from the list below',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Doctor cards
        ..._mockDoctors.map((doctor) {
          final isSelected =
              appointmentProvider.selectedDoctor?.id == doctor.id;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingMD),
            child: Card(
              elevation: isSelected ? 4 : 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: InkWell(
                onTap: () {
                  appointmentProvider.setDoctor(doctor);
                },
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Doctor avatar
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.person_rounded,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMD),

                          // Doctor info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? doctor.nameAr : doctor.name,
                                  style: AppTextStyles.subtitle1.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingXS),
                                Text(
                                  isArabic
                                      ? doctor.specialtyAr
                                      : doctor.specialty,
                                  style: AppTextStyles.body2.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingXS),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.warning,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${doctor.rating}',
                                      style: AppTextStyles.caption.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      ' (${doctor.reviewCount})',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Selection indicator
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 28,
                            ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingMD),

                      // Doctor details
                      Wrap(
                        spacing: AppTheme.spacingMD,
                        runSpacing: AppTheme.spacingSM,
                        children: [
                          _DetailChip(
                            icon: Icons.work_outline_rounded,
                            label: isArabic
                                ? '${doctor.experience} سنة خبرة'
                                : '${doctor.experience} yrs exp',
                          ),
                          _DetailChip(
                            icon: Icons.calendar_today_rounded,
                            label: isArabic
                                ? '${doctor.availableSlots} موعد متاح'
                                : '${doctor.availableSlots} slots',
                          ),
                          _DetailChip(
                            icon: Icons.payments_rounded,
                            label:
                                '${doctor.consultationFee} ${isArabic ? 'ريال' : 'SAR'}',
                          ),
                        ],
                      ),

                      // Languages
                      const SizedBox(height: AppTheme.spacingSM),
                      Wrap(
                        spacing: 4,
                        children: doctor.languages
                            .map((lang) => Chip(
                                  label: Text(
                                    lang,
                                    style: AppTextStyles.caption,
                                  ),
                                  backgroundColor:
                                      AppColors.info.withOpacity(0.1),
                                  side: BorderSide.none,
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  labelPadding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingSM,
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSM,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
