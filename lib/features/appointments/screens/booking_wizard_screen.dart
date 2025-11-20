import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/appointment_provider.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/models/appointment.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../widgets/member_selection_step.dart';
import '../widgets/specialty_selection_step.dart';
import '../widgets/doctor_selection_step.dart';
import '../widgets/datetime_selection_step.dart';
import '../widgets/payment_step.dart';
import '../widgets/confirmation_step.dart';

/// Comprehensive booking wizard for all appointment types
class BookingWizardScreen extends StatefulWidget {
  final AppointmentType appointmentType;

  const BookingWizardScreen({
    super.key,
    required this.appointmentType,
  });

  @override
  State<BookingWizardScreen> createState() => _BookingWizardScreenState();
}

class _BookingWizardScreenState extends State<BookingWizardScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the booking flow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appointmentProvider = context.read<AppointmentProvider>();
      appointmentProvider.resetWizard();
      appointmentProvider.setAppointmentType(widget.appointmentType);
    });
  }

  List<String> _getStepTitles(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      l10n.selectMember,
      context.read<LocaleProvider>().isArabic
          ? 'اختر التخصص'
          : 'Select Specialty',
      context.read<LocaleProvider>().isArabic ? 'اختر الطبيب' : 'Select Doctor',
      l10n.selectDateTime,
      l10n.paymentDetails,
      l10n.confirmBooking,
    ];
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return const MemberSelectionStep();
      case 1:
        return const SpecialtySelectionStep();
      case 2:
        return const DoctorSelectionStep();
      case 3:
        return const DateTimeSelectionStep();
      case 4:
        return const PaymentStep();
      case 5:
        return const ConfirmationStep();
      default:
        return const SizedBox.shrink();
    }
  }

  bool _canProceedToNextStep() {
    final appointmentProvider = context.read<AppointmentProvider>();

    switch (_currentStep) {
      case 0:
        return appointmentProvider.selectedMemberId != null;
      case 1:
        return appointmentProvider.selectedSpecialty != null;
      case 2:
        return appointmentProvider.selectedDoctor != null;
      case 3:
        return appointmentProvider.selectedDate != null &&
            appointmentProvider.selectedTime != null;
      case 4:
        return true; // Payment always can proceed (mock)
      case 5:
        return true;
      default:
        return false;
    }
  }

  Future<void> _nextStep() async {
    if (!_canProceedToNextStep()) {
      _showError(context.read<LocaleProvider>().isArabic
          ? 'الرجاء إكمال هذه الخطوة'
          : 'Please complete this step');
      return;
    }

    // If last step, book the appointment
    if (_currentStep == 5) {
      await _bookAppointment();
      return;
    }

    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _bookAppointment() async {
    setState(() => _isLoading = true);

    final appointmentProvider = context.read<AppointmentProvider>();
    final success = await appointmentProvider.bookAppointment();

    setState(() => _isLoading = false);

    if (success && mounted) {
      // Show success and navigate back
      _showSuccess(context.read<LocaleProvider>().isArabic
          ? 'تم حجز الموعد بنجاح!'
          : 'Appointment booked successfully!');

      // Navigate to appointments list
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go('/appointments');
      }
    } else if (mounted) {
      _showError(context.read<LocaleProvider>().isArabic
          ? 'فشل حجز الموعد. حاول مرة أخرى.'
          : 'Failed to book appointment. Try again.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
      ),
    );
  }

  String _getAppointmentTypeTitle() {
    final isArabic = context.read<LocaleProvider>().isArabic;
    switch (widget.appointmentType) {
      case AppointmentType.instantConsultation:
        return isArabic ? 'استشارة فورية' : 'Instant Consultation';
      case AppointmentType.onlineConsultation:
        return isArabic ? 'حجز أونلاين' : 'Online Booking';
      case AppointmentType.physicalClinic:
        return isArabic ? 'عيادة فعلية' : 'Physical Clinic';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stepTitles = _getStepTitles(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppointmentTypeTitle()),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Progress Stepper
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMD),
            color: AppColors.background,
            child: Row(
              children: List.generate(stepTitles.length, (index) {
                final isActive = index == _currentStep;
                final isCompleted = index < _currentStep;

                return Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: isCompleted || isActive
                                ? AppColors.primary
                                : AppColors.border,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      if (index < stepTitles.length - 1)
                        const SizedBox(width: 4),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Step Title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingMD),
            color: AppColors.primary.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.read<LocaleProvider>().isArabic ? 'الخطوة' : 'Step'} ${_currentStep + 1} ${context.read<LocaleProvider>().isArabic ? 'من' : 'of'} ${stepTitles.length}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  stepTitles[_currentStep],
                  style: AppTextStyles.h3,
                ),
              ],
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingLG),
              child: _buildCurrentStep(),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMD),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Back button
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousStep,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(l10n.back),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: AppTheme.spacingMD),

                  // Next/Confirm button
                  Expanded(
                    flex: _currentStep == 0 ? 1 : 1,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(_currentStep == 5
                              ? l10n.confirmBooking
                              : l10n.next),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
