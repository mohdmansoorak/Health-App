/// Policy model
/// Represents an insurance policy with all its details
class Policy {
  final String id;
  final String name;
  final String policyNumber;
  final String type;
  final String status; // 'Active' or 'Expired'
  final DateTime startDate;
  final DateTime endDate;
  final String coverageAmount;
  final String description;

  Policy({
    required this.id,
    required this.name,
    required this.policyNumber,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.coverageAmount,
    required this.description,
  });

  /// Create dummy policies for testing
  static List<Policy> getDummyPolicies() {
    return [
      Policy(
        id: '1',
        name: 'Medical Insurance',
        policyNumber: 'MED-2024-001234',
        type: 'Health',
        status: 'Active',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 12, 31),
        coverageAmount: 'SAR 500,000',
        description: 'Comprehensive medical insurance covering hospitalization, outpatient care, and prescription medicines.',
      ),
      Policy(
        id: '2',
        name: 'Motor Insurance',
        policyNumber: 'MOT-2024-005678',
        type: 'Vehicle',
        status: 'Active',
        startDate: DateTime(2024, 3, 15),
        endDate: DateTime(2025, 3, 14),
        coverageAmount: 'SAR 100,000',
        description: 'Comprehensive motor vehicle insurance covering damages, theft, and third-party liability.',
      ),
      Policy(
        id: '3',
        name: 'Travel Insurance',
        policyNumber: 'TRV-2023-009876',
        type: 'Travel',
        status: 'Expired',
        startDate: DateTime(2023, 6, 1),
        endDate: DateTime(2023, 12, 31),
        coverageAmount: 'SAR 50,000',
        description: 'Travel insurance covering medical emergencies, trip cancellations, and lost baggage.',
      ),
    ];
  }

  /// Find policy by ID
  static Policy? findById(String id) {
    try {
      return getDummyPolicies().firstWhere((policy) => policy.id == id);
    } catch (e) {
      return null;
    }
  }
}
