import 'package:equatable/equatable.dart';

/// Doctor model
class Doctor extends Equatable {
  final String id;
  final String name;
  final String nameAr;
  final String specialty;
  final String specialtyAr;
  final List<String> languages;
  final String? photoUrl;
  final double rating;
  final int reviewCount;
  final String? bio;
  final String? bioAr;
  final int experienceYears;
  final List<String> qualifications;
  final bool isAvailableNow;
  final DateTime? nextAvailableSlot;
  final double consultationFee;

  const Doctor({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.specialty,
    required this.specialtyAr,
    required this.languages,
    this.photoUrl,
    required this.rating,
    required this.reviewCount,
    this.bio,
    this.bioAr,
    required this.experienceYears,
    required this.qualifications,
    required this.isAvailableNow,
    this.nextAvailableSlot,
    required this.consultationFee,
  });

  String get languagesText => languages.join(', ');

  @override
  List<Object?> get props => [
        id,
        name,
        nameAr,
        specialty,
        specialtyAr,
        languages,
        photoUrl,
        rating,
        reviewCount,
        bio,
        bioAr,
        experienceYears,
        qualifications,
        isAvailableNow,
        nextAvailableSlot,
        consultationFee,
      ];
}
