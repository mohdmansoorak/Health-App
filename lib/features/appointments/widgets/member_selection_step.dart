import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

/// Step 1: Member selection (self or dependents)
class MemberSelectionStep extends StatelessWidget {
  const MemberSelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberProvider>();
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;

    final allMembers = [
      if (memberProvider.primaryMember != null) memberProvider.primaryMember!,
      ...memberProvider.dependents,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic
              ? 'لمن هذا الموعد؟'
              : 'Who is this appointment for?',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        Text(
          isArabic
              ? 'اختر العضو الذي سيحضر الموعد'
              : 'Select the member who will attend the appointment',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Member cards
        ...allMembers.map((member) {
          final isSelected =
              appointmentProvider.selectedMemberId == member.memberId;

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
                  appointmentProvider.setSelectedMember(member.memberId);
                },
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMD),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: isSelected
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.1),
                        child: Text(
                          (isArabic ? member.nameAr : member.name)
                              .substring(0, 1)
                              .toUpperCase(),
                          style: AppTextStyles.h3.copyWith(
                            color: isSelected ? Colors.white : AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMD),

                      // Member info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? member.nameAr : member.name,
                              style: AppTextStyles.subtitle1.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingXS),
                            Text(
                              '${isArabic ? 'رقم العضوية' : 'Member ID'}: ${member.memberId}',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            if (member.isPrimary)
                              Container(
                                margin: const EdgeInsets.only(
                                    top: AppTheme.spacingXS),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.spacingSM,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.radiusSM),
                                ),
                                child: Text(
                                  isArabic ? 'العضو الأساسي' : 'Primary Member',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
                        )
                      else
                        Icon(
                          Icons.radio_button_unchecked,
                          color: AppColors.border,
                          size: 28,
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
