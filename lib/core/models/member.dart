import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum MemberStatus { active, inactive, suspended }

/// Member/Dependent model
class Member extends Equatable {
  final String id;
  final String membershipId;
  final String name;
  final String nameAr;
  final String nationalId;
  final DateTime dateOfBirth;
  final Gender gender;
  final String phone;
  final String email;
  final bool isPrimary;
  final String relationToPrimary;
  final String policyNumber;
  final MemberStatus status;
  final String? photoUrl;

  const Member({
    required this.id,
    required this.membershipId,
    required this.name,
    required this.nameAr,
    required this.nationalId,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
    required this.isPrimary,
    required this.relationToPrimary,
    required this.policyNumber,
    required this.status,
    this.photoUrl,
  });

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  String get genderText => gender == Gender.male ? 'Male' : 'Female';
  String get genderTextAr => gender == Gender.male ? 'ذكر' : 'أنثى';

  @override
  List<Object?> get props => [
        id,
        membershipId,
        name,
        nameAr,
        nationalId,
        dateOfBirth,
        gender,
        phone,
        email,
        isPrimary,
        relationToPrimary,
        policyNumber,
        status,
        photoUrl,
      ];

  Member copyWith({
    String? id,
    String? membershipId,
    String? name,
    String? nameAr,
    String? nationalId,
    DateTime? dateOfBirth,
    Gender? gender,
    String? phone,
    String? email,
    bool? isPrimary,
    String? relationToPrimary,
    String? policyNumber,
    MemberStatus? status,
    String? photoUrl,
  }) {
    return Member(
      id: id ?? this.id,
      membershipId: membershipId ?? this.membershipId,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      nationalId: nationalId ?? this.nationalId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isPrimary: isPrimary ?? this.isPrimary,
      relationToPrimary: relationToPrimary ?? this.relationToPrimary,
      policyNumber: policyNumber ?? this.policyNumber,
      status: status ?? this.status,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
