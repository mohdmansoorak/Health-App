import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/models/appointment.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

/// Step 2: Specialty selection
class SpecialtySelectionStep extends StatelessWidget {
  const SpecialtySelectionStep({super.key});

  List<Map<String, String>> _getSpecialties(
      BuildContext context, AppointmentType type) {
    final isArabic = context.read<LocaleProvider>().isArabic;

    // Instant consultation only has GP
    if (type == AppointmentType.instantConsultation) {
      return [
        {
          'id': 'general',
          'name': isArabic ? 'طبيب عام' : 'General Physician',
          'icon': 'medical_services',
        },
      ];
    }

    // Online and Physical have all specialties
    return [
      {
        'id': 'general',
        'name': isArabic ? 'طبيب عام' : 'General Physician',
        'icon': 'medical_services',
      },
      {
        'id': 'dermatology',
        'name': isArabic ? 'الأمراض الجلدية' : 'Dermatology',
        'icon': 'face',
      },
      {
        'id': 'cardiology',
        'name': isArabic ? 'أمراض القلب' : 'Cardiology',
        'icon': 'favorite',
      },
      {
        'id': 'pediatrics',
        'name': isArabic ? 'طب الأطفال' : 'Pediatrics',
        'icon': 'child_care',
      },
      {
        'id': 'orthopedics',
        'name': isArabic ? 'جراحة العظام' : 'Orthopedics',
        'icon': 'accessible',
      },
      {
        'id': 'gynecology',
        'name': isArabic ? 'أمراض النساء' : 'Gynecology',
        'icon': 'pregnant_woman',
      },
      {
        'id': 'psychiatry',
        'name': isArabic ? 'الطب النفسي' : 'Psychiatry',
        'icon': 'psychology',
      },
      {
        'id': 'dentistry',
        'name': isArabic ? 'طب الأسنان' : 'Dentistry',
        'icon': 'mood',
      },
    ];
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'medical_services':
        return Icons.medical_services_rounded;
      case 'face':
        return Icons.face_rounded;
      case 'favorite':
        return Icons.favorite_rounded;
      case 'child_care':
        return Icons.child_care_rounded;
      case 'accessible':
        return Icons.accessible_rounded;
      case 'pregnant_woman':
        return Icons.pregnant_woman_rounded;
      case 'psychology':
        return Icons.psychology_rounded;
      case 'mood':
        return Icons.mood_rounded;
      default:
        return Icons.medical_services_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;

    final specialties = _getSpecialties(
        context, appointmentProvider.selectedType ?? AppointmentType.onlineConsultation);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic ? 'اختر التخصص الطبي' : 'Select Medical Specialty',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        Text(
          isArabic
              ? 'اختر التخصص المناسب لحالتك الصحية'
              : 'Choose the specialty that suits your health condition',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Specialty grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppTheme.spacingMD,
            mainAxisSpacing: AppTheme.spacingMD,
            childAspectRatio: 1.2,
          ),
          itemCount: specialties.length,
          itemBuilder: (context, index) {
            final specialty = specialties[index];
            final isSelected =
                appointmentProvider.selectedSpecialty == specialty['id'];

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
                onTap: () {
                  appointmentProvider.setSpecialty(specialty['id']!);
                },
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMD),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingMD),
                        decoration: BoxDecoration(
                          color: (isSelected
                                  ? AppColors.primary
                                  : AppColors.primary.withOpacity(0.1)),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMD),
                        ),
                        child: Icon(
                          _getIconData(specialty['icon']!),
                          color: isSelected ? Colors.white : AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingSM),
                      Text(
                        specialty['name']!,
                        style: AppTextStyles.subtitle2.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
