import 'package:equatable/equatable.dart';

enum PolicyStatus { active, expired, suspended, cancelled }

/// Insurance Policy model
class Policy extends Equatable {
  final String policyNumber;
  final String planName;
  final String planNameAr;
  final DateTime startDate;
  final DateTime endDate;
  final PolicyStatus status;
  final double coverageAmount;
  final bool inpatientCoverage;
  final bool outpatientCoverage;
  final bool dentalCoverage;
  final bool opticalCoverage;
  final bool maternityCoverage;
  final bool pharmacyCoverage;
  final int copaymentPercentage;

  const Policy({
    required this.policyNumber,
    required this.planName,
    required this.planNameAr,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.coverageAmount,
    required this.inpatientCoverage,
    required this.outpatientCoverage,
    required this.dentalCoverage,
    required this.opticalCoverage,
    required this.maternityCoverage,
    required this.pharmacyCoverage,
    required this.copaymentPercentage,
  });

  bool get isActive => status == PolicyStatus.active;

  int get daysRemaining => endDate.difference(DateTime.now()).inDays;

  @override
  List<Object?> get props => [
        policyNumber,
        planName,
        planNameAr,
        startDate,
        endDate,
        status,
        coverageAmount,
        inpatientCoverage,
        outpatientCoverage,
        dentalCoverage,
        opticalCoverage,
        maternityCoverage,
        pharmacyCoverage,
        copaymentPercentage,
      ];
}
