import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import 'package:intl/intl.dart';

/// Step 4: Date and time selection
class DateTimeSelectionStep extends StatefulWidget {
  const DateTimeSelectionStep({super.key});

  @override
  State<DateTimeSelectionStep> createState() => _DateTimeSelectionStepState();
}

class _DateTimeSelectionStepState extends State<DateTimeSelectionStep> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock available time slots
  final List<TimeOfDay> _mockTimeSlots = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 30),
    const TimeOfDay(hour: 10, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 11, minute: 0),
    const TimeOfDay(hour: 11, minute: 30),
    const TimeOfDay(hour: 14, minute: 0),
    const TimeOfDay(hour: 14, minute: 30),
    const TimeOfDay(hour: 15, minute: 0),
    const TimeOfDay(hour: 15, minute: 30),
    const TimeOfDay(hour: 16, minute: 0),
    const TimeOfDay(hour: 16, minute: 30),
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 30),
  ];

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic ? 'اختر التاريخ والوقت' : 'Select Date & Time',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        Text(
          isArabic
              ? 'اختر التاريخ المناسب ثم اختر الوقت المتاح'
              : 'Choose your preferred date and available time slot',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLG),

        // Calendar
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingSM),
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 90)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay ?? appointmentProvider.selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                appointmentProvider.setDate(selectedDay);
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.saturday,
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: const TextStyle(color: AppColors.error),
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: AppTextStyles.subtitle1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingXL),

        // Time slots (only show if date is selected)
        if (_selectedDay != null || appointmentProvider.selectedDate != null) ...[
          Text(
            isArabic ? 'الأوقات المتاحة' : 'Available Time Slots',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: AppTheme.spacingMD),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppTheme.spacingSM,
              mainAxisSpacing: AppTheme.spacingSM,
              childAspectRatio: 2.2,
            ),
            itemCount: _mockTimeSlots.length,
            itemBuilder: (context, index) {
              final timeSlot = _mockTimeSlots[index];
              final isSelected = appointmentProvider.selectedTime != null &&
                  appointmentProvider.selectedTime!.hour == timeSlot.hour &&
                  appointmentProvider.selectedTime!.minute == timeSlot.minute;

              // Format time
              final now = DateTime.now();
              final dateTime = DateTime(
                now.year,
                now.month,
                now.day,
                timeSlot.hour,
                timeSlot.minute,
              );
              final timeString = DateFormat('HH:mm').format(dateTime);

              return InkWell(
                onTap: () {
                  appointmentProvider.setTime(timeSlot);
                },
                borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.border,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    timeString,
                    style: AppTextStyles.body2.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppTheme.spacingMD),

          // Selected summary
          if (appointmentProvider.selectedDate != null &&
              appointmentProvider.selectedTime != null)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMD),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                border: Border.all(
                  color: AppColors.success.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 24,
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? 'الموعد المختار' : 'Selected Appointment',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat('EEEE, MMMM d, yyyy').format(appointmentProvider.selectedDate!)} - ${DateFormat('HH:mm').format(DateTime(2024, 1, 1, appointmentProvider.selectedTime!.hour, appointmentProvider.selectedTime!.minute))}',
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                ),
                const SizedBox(width: AppTheme.spacingMD),
                Expanded(
                  child: Text(
                    isArabic
                        ? 'الرجاء اختيار تاريخ من التقويم أولاً'
                        : 'Please select a date from the calendar first',
                    style: AppTextStyles.body2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
