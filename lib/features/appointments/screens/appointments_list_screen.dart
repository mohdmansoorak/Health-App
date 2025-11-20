import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/models/appointment.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import 'package:intl/intl.dart';

/// Appointments list screen with upcoming and previous tabs
class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({super.key});

  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load appointments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentProvider>().loadAppointments();
    });
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
        title: Text(l10n.appointments),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.upcoming),
            Tab(text: l10n.previous),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _UpcomingTab(),
          _PreviousTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show booking type selector
          _showBookingTypeSelector(context);
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.bookAppointment),
      ),
    );
  }

  void _showBookingTypeSelector(BuildContext context) {
    final isArabic = context.read<LocaleProvider>().isArabic;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isArabic ? 'اختر نوع الحجز' : 'Select Booking Type',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingLG),

            // Instant Consultation
            _BookingTypeCard(
              icon: Icons.video_call_rounded,
              iconColor: AppColors.instantConsultation,
              title: isArabic ? 'استشارة فورية' : 'Instant Consultation',
              subtitle: isArabic
                  ? 'تحدث مع طبيب عام الآن'
                  : 'Talk to GP now - 24/7',
              onTap: () {
                Navigator.pop(context);
                context.push('/booking/instant');
              },
            ),
            const SizedBox(height: AppTheme.spacingMD),

            // Online Booking
            _BookingTypeCard(
              icon: Icons.calendar_today_rounded,
              iconColor: AppColors.onlineBooking,
              title: isArabic ? 'حجز أونلاين' : 'Online Booking',
              subtitle: isArabic
                  ? 'استشارة مرئية مع أخصائيين'
                  : 'Video consultation with specialists',
              onTap: () {
                Navigator.pop(context);
                context.push('/booking/online');
              },
            ),
            const SizedBox(height: AppTheme.spacingMD),

            // Physical Clinic
            _BookingTypeCard(
              icon: Icons.local_hospital_rounded,
              iconColor: AppColors.physicalClinic,
              title: isArabic ? 'عيادة فعلية' : 'Physical Clinic',
              subtitle: isArabic
                  ? 'زيارة عيادتنا في الرياض'
                  : 'Visit our clinic in Riyadh',
              onTap: () {
                Navigator.pop(context);
                context.push('/booking/physical');
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}

class _UpcomingTab extends StatelessWidget {
  const _UpcomingTab();

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isArabic = context.watch<LocaleProvider>().isArabic;
    final l10n = AppLocalizations.of(context);

    final upcomingAppointments = appointmentProvider.upcomingAppointments;

    if (upcomingAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 80,
              color: AppColors.textSecondary.withOpacity(0.3),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              l10n.noAppointments,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => appointmentProvider.loadAppointments(),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        itemCount: upcomingAppointments.length,
        itemBuilder: (context, index) {
          final appointment = upcomingAppointments[index];
          return _AppointmentCard(
            appointment: appointment,
            isUpcoming: true,
          );
        },
      ),
    );
  }
}

class _PreviousTab extends StatelessWidget {
  const _PreviousTab();

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final l10n = AppLocalizations.of(context);

    final previousAppointments = appointmentProvider.previousAppointments;

    if (previousAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_rounded,
              size: 80,
              color: AppColors.textSecondary.withOpacity(0.3),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              l10n.noAppointments,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => appointmentProvider.loadAppointments(),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        itemCount: previousAppointments.length,
        itemBuilder: (context, index) {
          final appointment = previousAppointments[index];
          return _AppointmentCard(
            appointment: appointment,
            isUpcoming: false,
          );
        },
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool isUpcoming;

  const _AppointmentCard({
    required this.appointment,
    required this.isUpcoming,
  });

  Color _getTypeColor() {
    switch (appointment.type) {
      case AppointmentType.instantConsultation:
        return AppColors.instantConsultation;
      case AppointmentType.onlineConsultation:
        return AppColors.onlineBooking;
      case AppointmentType.physicalClinic:
        return AppColors.physicalClinic;
    }
  }

  IconData _getTypeIcon() {
    switch (appointment.type) {
      case AppointmentType.instantConsultation:
        return Icons.video_call_rounded;
      case AppointmentType.onlineConsultation:
        return Icons.videocam_rounded;
      case AppointmentType.physicalClinic:
        return Icons.local_hospital_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LocaleProvider>().isArabic;
    final l10n = AppLocalizations.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMD),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to appointment details
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with type badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSM,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getTypeIcon(), size: 14, color: _getTypeColor()),
                        const SizedBox(width: 4),
                        Text(
                          isArabic ? appointment.typeTextAr : appointment.typeText,
                          style: AppTextStyles.caption.copyWith(
                            color: _getTypeColor(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // Doctor info
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? appointment.doctorNameAr
                              : appointment.doctorName,
                          style: AppTextStyles.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          isArabic
                              ? appointment.specialtyAr
                              : appointment.specialty,
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

              // Date and time
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppTheme.spacingXS),
                  Text(
                    DateFormat('EEE, MMM d, yyyy').format(appointment.dateTime),
                    style: AppTextStyles.body2,
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppTheme.spacingXS),
                  Text(
                    DateFormat('hh:mm a').format(appointment.dateTime),
                    style: AppTextStyles.body2,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // Action buttons
              if (isUpcoming)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Reschedule
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(l10n.reschedule),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingSM),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Join / View details
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          appointment.type == AppointmentType.physicalClinic
                              ? l10n.viewDetails
                              : (isArabic ? 'انضم' : 'Join'),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    if (appointment.hasInvoice)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: View invoice
                          },
                          icon: const Icon(Icons.receipt_long_rounded, size: 16),
                          label: Text(isArabic ? 'الفاتورة' : 'Invoice'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    if (appointment.hasInvoice && appointment.hasPrescription)
                      const SizedBox(width: AppTheme.spacingSM),
                    if (appointment.hasPrescription)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: View prescription
                          },
                          icon: const Icon(Icons.medication_rounded, size: 16),
                          label: Text(isArabic ? 'الوصفة' : 'Rx'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
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

class _BookingTypeCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BookingTypeCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
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
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: AppTheme.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
