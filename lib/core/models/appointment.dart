import 'package:equatable/equatable.dart';

enum AppointmentType {
  instantConsultation,
  onlineConsultation,
  physicalClinic,
}

enum AppointmentStatus {
  upcoming,
  confirmed,
  completed,
  cancelled,
  noShow,
}

enum PaymentStatus {
  pending,
  paid,
  refunded,
  failed,
}

/// Appointment model
class Appointment extends Equatable {
  final String id;
  final String memberId;
  final String doctorId;
  final String doctorName;
  final String doctorNameAr;
  final String specialty;
  final String specialtyAr;
  final AppointmentType type;
  final AppointmentStatus status;
  final DateTime dateTime;
  final int duration; // in minutes
  final double amount;
  final PaymentStatus paymentStatus;
  final String consultationChannel; // "Online Video", "Physical", etc.
  final String? clinicAddress;
  final String? invoiceNumber;
  final bool hasInvoice;
  final bool hasPrescription;
  final bool hasLabOrders;
  final String? creditNoteNumber;
  final double? creditNoteAmount;

  const Appointment({
    required this.id,
    required this.memberId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorNameAr,
    required this.specialty,
    required this.specialtyAr,
    required this.type,
    required this.status,
    required this.dateTime,
    required this.duration,
    required this.amount,
    required this.paymentStatus,
    required this.consultationChannel,
    this.clinicAddress,
    this.invoiceNumber,
    this.hasInvoice = false,
    this.hasPrescription = false,
    this.hasLabOrders = false,
    this.creditNoteNumber,
    this.creditNoteAmount,
  });

  String get typeText {
    switch (type) {
      case AppointmentType.instantConsultation:
        return 'Instant Consultation';
      case AppointmentType.onlineConsultation:
        return 'Online Consultation';
      case AppointmentType.physicalClinic:
        return 'Physical Clinic';
    }
  }

  String get typeTextAr {
    switch (type) {
      case AppointmentType.instantConsultation:
        return 'استشارة فورية';
      case AppointmentType.onlineConsultation:
        return 'استشارة أونلاين';
      case AppointmentType.physicalClinic:
        return 'عيادة فعلية';
    }
  }

  String get statusText {
    switch (status) {
      case AppointmentStatus.upcoming:
        return 'Upcoming';
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.noShow:
        return 'No Show';
    }
  }

  String get statusTextAr {
    switch (status) {
      case AppointmentStatus.upcoming:
        return 'قادم';
      case AppointmentStatus.confirmed:
        return 'مؤكد';
      case AppointmentStatus.completed:
        return 'مكتمل';
      case AppointmentStatus.cancelled:
        return 'ملغي';
      case AppointmentStatus.noShow:
        return 'لم يحضر';
    }
  }

  @override
  List<Object?> get props => [
        id,
        memberId,
        doctorId,
        doctorName,
        doctorNameAr,
        specialty,
        specialtyAr,
        type,
        status,
        dateTime,
        duration,
        amount,
        paymentStatus,
        consultationChannel,
        clinicAddress,
        invoiceNumber,
        hasInvoice,
        hasPrescription,
        hasLabOrders,
        creditNoteNumber,
        creditNoteAmount,
      ];

  Appointment copyWith({
    String? id,
    String? memberId,
    String? doctorId,
    String? doctorName,
    String? doctorNameAr,
    String? specialty,
    String? specialtyAr,
    AppointmentType? type,
    AppointmentStatus? status,
    DateTime? dateTime,
    int? duration,
    double? amount,
    PaymentStatus? paymentStatus,
    String? consultationChannel,
    String? clinicAddress,
    String? invoiceNumber,
    bool? hasInvoice,
    bool? hasPrescription,
    bool? hasLabOrders,
    String? creditNoteNumber,
    double? creditNoteAmount,
  }) {
    return Appointment(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorNameAr: doctorNameAr ?? this.doctorNameAr,
      specialty: specialty ?? this.specialty,
      specialtyAr: specialtyAr ?? this.specialtyAr,
      type: type ?? this.type,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      duration: duration ?? this.duration,
      amount: amount ?? this.amount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      consultationChannel: consultationChannel ?? this.consultationChannel,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      hasInvoice: hasInvoice ?? this.hasInvoice,
      hasPrescription: hasPrescription ?? this.hasPrescription,
      hasLabOrders: hasLabOrders ?? this.hasLabOrders,
      creditNoteNumber: creditNoteNumber ?? this.creditNoteNumber,
      creditNoteAmount: creditNoteAmount ?? this.creditNoteAmount,
    );
  }
}
