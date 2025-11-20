/// Claim model
/// Represents an insurance claim with all its details
class Claim {
  final String id;
  final String policyId;
  final String description;
  final DateTime submittedDate;
  final String amount;
  final String status; // 'Submitted', 'Approved', 'Rejected', 'Processing'

  Claim({
    required this.id,
    required this.policyId,
    required this.description,
    required this.submittedDate,
    required this.amount,
    required this.status,
  });

  /// Create dummy claims for testing
  static List<Claim> getDummyClaims() {
    return [
      Claim(
        id: 'CLM001',
        policyId: '1',
        description: 'Hospital visit for consultation',
        submittedDate: DateTime(2024, 11, 15),
        amount: 'SAR 500',
        status: 'Approved',
      ),
      Claim(
        id: 'CLM002',
        policyId: '1',
        description: 'Prescription medicines',
        submittedDate: DateTime(2024, 11, 10),
        amount: 'SAR 250',
        status: 'Processing',
      ),
      Claim(
        id: 'CLM003',
        policyId: '2',
        description: 'Car accident repair',
        submittedDate: DateTime(2024, 10, 5),
        amount: 'SAR 3,500',
        status: 'Approved',
      ),
      Claim(
        id: 'CLM004',
        policyId: '1',
        description: 'Dental checkup',
        submittedDate: DateTime(2024, 9, 20),
        amount: 'SAR 300',
        status: 'Rejected',
      ),
      Claim(
        id: 'CLM005',
        policyId: '1',
        description: 'Medical tests and lab work',
        submittedDate: DateTime(2024, 11, 18),
        amount: 'SAR 450',
        status: 'Submitted',
      ),
    ];
  }
}
