import 'package:flutter/material.dart';
import '../models/member.dart';
import '../models/policy.dart';

/// Manages member data and family dependents
class MemberProvider extends ChangeNotifier {
  Member? _primaryMember;
  List<Member> _dependents = [];
  Policy? _policy;
  bool _isLoading = false;

  Member? get primaryMember => _primaryMember;
  List<Member> get dependents => _dependents;
  List<Member> get allMembers => [
        if (_primaryMember != null) _primaryMember!,
        ..._dependents,
      ];
  Policy? get policy => _policy;
  bool get isLoading => _isLoading;

  /// Load member data (mock implementation)
  Future<void> loadMemberData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      _primaryMember = Member(
        id: 'MEM001',
        membershipId: '1234567890',
        name: 'Mohammed Mansoor',
        nameAr: 'محمد منصور',
        nationalId: '1234567890',
        dateOfBirth: DateTime(1990, 1, 15),
        gender: Gender.male,
        phone: '+966501234567',
        email: 'mohammed@example.com',
        isPrimary: true,
        relationToPrimary: 'Self',
        policyNumber: 'POL-2024-001',
        status: MemberStatus.active,
      );

      _dependents = [
        Member(
          id: 'MEM002',
          membershipId: '1234567891',
          name: 'Sara Mansoor',
          nameAr: 'سارة منصور',
          nationalId: '1234567891',
          dateOfBirth: DateTime(1992, 5, 20),
          gender: Gender.female,
          phone: '',
          email: '',
          isPrimary: false,
          relationToPrimary: 'Spouse',
          policyNumber: 'POL-2024-001',
          status: MemberStatus.active,
        ),
        Member(
          id: 'MEM003',
          membershipId: '1234567892',
          name: 'Ahmed Mansoor',
          nameAr: 'أحمد منصور',
          nationalId: '1234567892',
          dateOfBirth: DateTime(2015, 8, 10),
          gender: Gender.male,
          phone: '',
          email: '',
          isPrimary: false,
          relationToPrimary: 'Son',
          policyNumber: 'POL-2024-001',
          status: MemberStatus.active,
        ),
      ];

      _policy = Policy(
        policyNumber: 'POL-2024-001',
        planName: 'Premium Health Coverage',
        planNameAr: 'التغطية الصحية الشاملة',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 12, 31),
        status: PolicyStatus.active,
        coverageAmount: 500000.0,
        inpatientCoverage: true,
        outpatientCoverage: true,
        dentalCoverage: false,
        opticalCoverage: false,
        maternityCoverage: true,
        pharmacyCoverage: true,
        copaymentPercentage: 20,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get member by ID
  Member? getMemberById(String id) {
    return allMembers.firstWhere(
      (member) => member.id == id,
      orElse: () => allMembers.first,
    );
  }

  /// Select member for appointment booking
  Member? _selectedMember;
  Member? get selectedMember => _selectedMember;

  void selectMember(Member member) {
    _selectedMember = member;
    notifyListeners();
  }

  void clearSelectedMember() {
    _selectedMember = null;
    notifyListeners();
  }
}
