import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';

/// Manages appointments - booking, reschedule, cancel, etc.
class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _isLoading = false;

  // Booking wizard state
  AppointmentType? _selectedType;
  String? _selectedSpecialty;
  Doctor? _selectedDoctor;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedMemberId;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;

  // Wizard getters
  AppointmentType? get selectedType => _selectedType;
  String? get selectedSpecialty => _selectedSpecialty;
  Doctor? get selectedDoctor => _selectedDoctor;
  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  String? get selectedMemberId => _selectedMemberId;

  List<Appointment> get upcomingAppointments => _appointments
      .where((apt) =>
          apt.status == AppointmentStatus.upcoming ||
          apt.status == AppointmentStatus.confirmed)
      .toList();

  List<Appointment> get previousAppointments => _appointments
      .where((apt) =>
          apt.status == AppointmentStatus.completed ||
          apt.status == AppointmentStatus.cancelled)
      .toList();

  /// Load appointments
  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      _appointments = [
        Appointment(
          id: 'APT001',
          memberId: 'MEM001',
          doctorId: 'DR001',
          doctorName: 'Dr. Ahmed Al-Khalil',
          doctorNameAr: 'د. أحمد الخليل',
          specialty: 'Internal Medicine',
          specialtyAr: 'الطب الباطني',
          type: AppointmentType.onlineConsultation,
          status: AppointmentStatus.upcoming,
          dateTime: DateTime.now().add(const Duration(days: 2)),
          duration: 30,
          amount: 200.0,
          paymentStatus: PaymentStatus.paid,
          consultationChannel: 'Online Video',
        ),
        Appointment(
          id: 'APT002',
          memberId: 'MEM001',
          doctorId: 'DR002',
          doctorName: 'Dr. Fatima Hassan',
          doctorNameAr: 'د. فاطمة حسن',
          specialty: 'Pediatrics',
          specialtyAr: 'طب الأطفال',
          type: AppointmentType.physicalClinic,
          status: AppointmentStatus.completed,
          dateTime: DateTime.now().subtract(const Duration(days: 5)),
          duration: 30,
          amount: 150.0,
          paymentStatus: PaymentStatus.paid,
          consultationChannel: 'Physical',
          clinicAddress: 'CareConnect Riyadh Clinic, King Fahd Road',
          hasInvoice: true,
          hasPrescription: true,
          hasLabOrders: true,
        ),
      ];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Booking Wizard Methods

  void setAppointmentType(AppointmentType type) {
    _selectedType = type;
    // Reset subsequent selections
    _selectedSpecialty = null;
    _selectedDoctor = null;
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }

  void setMember(String memberId) {
    _selectedMemberId = memberId;
    notifyListeners();
  }

  void setSpecialty(String specialty) {
    _selectedSpecialty = specialty;
    _selectedDoctor = null; // Reset doctor when specialty changes
    notifyListeners();
  }

  void setDoctor(Doctor doctor) {
    _selectedDoctor = doctor;
    notifyListeners();
  }

  void setDateTime(DateTime date, TimeOfDay time) {
    _selectedDate = date;
    _selectedTime = time;
    notifyListeners();
  }

  /// Book appointment
  Future<bool> bookAppointment() async {
    if (_selectedMemberId == null ||
        _selectedType == null ||
        _selectedDoctor == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      return false;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));

      final appointment = Appointment(
        id: 'APT${DateTime.now().millisecondsSinceEpoch}',
        memberId: _selectedMemberId!,
        doctorId: _selectedDoctor!.id,
        doctorName: _selectedDoctor!.name,
        doctorNameAr: _selectedDoctor!.nameAr,
        specialty: _selectedDoctor!.specialty,
        specialtyAr: _selectedDoctor!.specialtyAr,
        type: _selectedType!,
        status: AppointmentStatus.upcoming,
        dateTime: DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
        duration: 30,
        amount: _selectedType == AppointmentType.instantConsultation
            ? 150.0
            : 200.0,
        paymentStatus: PaymentStatus.paid,
        consultationChannel: _selectedType == AppointmentType.physicalClinic
            ? 'Physical'
            : 'Online Video',
      );

      _appointments.add(appointment);
      resetBookingWizard();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Reset booking wizard
  void resetBookingWizard() {
    _selectedType = null;
    _selectedSpecialty = null;
    _selectedDoctor = null;
    _selectedDate = null;
    _selectedTime = null;
    _selectedMemberId = null;
    notifyListeners();
  }

  /// Cancel appointment
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final index = _appointments.indexWhere((apt) => apt.id == appointmentId);
      if (index != -1) {
        _appointments[index] = _appointments[index].copyWith(
          status: AppointmentStatus.cancelled,
          creditNoteNumber: 'CN${DateTime.now().millisecondsSinceEpoch}',
          creditNoteAmount: _appointments[index].amount,
        );
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Check follow-up eligibility (14 days from consultation)
  bool isFollowUpAvailable(Appointment appointment) {
    if (appointment.status != AppointmentStatus.completed) return false;

    final daysSinceConsultation =
        DateTime.now().difference(appointment.dateTime).inDays;
    return daysSinceConsultation <= 14;
  }
}
