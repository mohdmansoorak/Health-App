import 'package:flutter_test/flutter_test.dart';
import 'package:health_insurance_app/core/providers/member_provider.dart';
import 'package:health_insurance_app/core/models/member.dart';
import 'package:health_insurance_app/core/models/policy.dart';

void main() {
  group('MemberProvider Tests', () {
    late MemberProvider memberProvider;

    setUp(() {
      memberProvider = MemberProvider();
    });

    tearDown(() {
      memberProvider.dispose();
    });

    group('Initialization', () {
      test('should initialize with empty state', () {
        expect(memberProvider.primaryMember, isNull);
        expect(memberProvider.dependents, isEmpty);
        expect(memberProvider.allMembers, isEmpty);
        expect(memberProvider.policy, isNull);
        expect(memberProvider.isLoading, isFalse);
        expect(memberProvider.selectedMember, isNull);
      });
    });

    group('Load Member Data', () {
      test('should set loading state while loading', () async {
        final loadFuture = memberProvider.loadMemberData();

        expect(memberProvider.isLoading, isTrue);

        await loadFuture;

        expect(memberProvider.isLoading, isFalse);
      });

      test('should load primary member', () async {
        await memberProvider.loadMemberData();

        expect(memberProvider.primaryMember, isNotNull);
        expect(memberProvider.primaryMember?.id, equals('MEM001'));
        expect(memberProvider.primaryMember?.isPrimary, isTrue);
        expect(memberProvider.primaryMember?.name, equals('Mohammed Mansoor'));
      });

      test('should load dependents', () async {
        await memberProvider.loadMemberData();

        expect(memberProvider.dependents, isNotEmpty);
        expect(memberProvider.dependents.length, equals(2));

        final spouse = memberProvider.dependents[0];
        expect(spouse.relationToPrimary, equals('Spouse'));
        expect(spouse.name, equals('Sara Mansoor'));

        final son = memberProvider.dependents[1];
        expect(son.relationToPrimary, equals('Son'));
        expect(son.name, equals('Ahmed Mansoor'));
      });

      test('should load policy', () async {
        await memberProvider.loadMemberData();

        expect(memberProvider.policy, isNotNull);
        expect(memberProvider.policy?.policyNumber, equals('POL-2024-001'));
        expect(memberProvider.policy?.planName, equals('Premium Health Coverage'));
        expect(memberProvider.policy?.status, equals(PolicyStatus.active));
      });

      test('allMembers should include primary and dependents', () async {
        await memberProvider.loadMemberData();

        expect(memberProvider.allMembers.length, equals(3));
        expect(memberProvider.allMembers[0].isPrimary, isTrue);
        expect(memberProvider.allMembers[1].isPrimary, isFalse);
        expect(memberProvider.allMembers[2].isPrimary, isFalse);
      });

      test('should notify listeners on load completion', () async {
        var notifyCount = 0;
        memberProvider.addListener(() {
          notifyCount++;
        });

        await memberProvider.loadMemberData();

        expect(notifyCount, greaterThan(0));
      });
    });

    group('Get Member By ID', () {
      setUp(() async {
        await memberProvider.loadMemberData();
      });

      test('should return correct member by ID', () {
        final member = memberProvider.getMemberById('MEM002');

        expect(member, isNotNull);
        expect(member?.id, equals('MEM002'));
        expect(member?.name, equals('Sara Mansoor'));
      });

      test('should return first member if ID not found', () {
        final member = memberProvider.getMemberById('INVALID_ID');

        expect(member, isNotNull);
        expect(member?.id, equals('MEM001')); // Returns first member
      });

      test('should find primary member', () {
        final member = memberProvider.getMemberById('MEM001');

        expect(member, isNotNull);
        expect(member?.isPrimary, isTrue);
      });

      test('should find dependent member', () {
        final member = memberProvider.getMemberById('MEM003');

        expect(member, isNotNull);
        expect(member?.isPrimary, isFalse);
        expect(member?.relationToPrimary, equals('Son'));
      });
    });

    group('Member Selection', () {
      late Member testMember;

      setUp(() async {
        await memberProvider.loadMemberData();
        testMember = memberProvider.primaryMember!;
      });

      test('should select member', () {
        memberProvider.selectMember(testMember);

        expect(memberProvider.selectedMember, isNotNull);
        expect(memberProvider.selectedMember?.id, equals(testMember.id));
      });

      test('should clear selected member', () {
        memberProvider.selectMember(testMember);
        expect(memberProvider.selectedMember, isNotNull);

        memberProvider.clearSelectedMember();

        expect(memberProvider.selectedMember, isNull);
      });

      test('should notify listeners on member selection', () {
        var notified = false;
        memberProvider.addListener(() {
          notified = true;
        });

        memberProvider.selectMember(testMember);

        expect(notified, isTrue);
      });

      test('should notify listeners on clear selection', () {
        memberProvider.selectMember(testMember);

        var notified = false;
        memberProvider.addListener(() {
          notified = true;
        });

        memberProvider.clearSelectedMember();

        expect(notified, isTrue);
      });

      test('should allow selecting different members', () {
        final dependent = memberProvider.dependents[0];

        memberProvider.selectMember(testMember);
        expect(memberProvider.selectedMember?.id, equals('MEM001'));

        memberProvider.selectMember(dependent);
        expect(memberProvider.selectedMember?.id, equals('MEM002'));
      });
    });

    group('Policy Information', () {
      setUp(() async {
        await memberProvider.loadMemberData();
      });

      test('policy should have correct coverage details', () {
        final policy = memberProvider.policy;

        expect(policy?.inpatientCoverage, isTrue);
        expect(policy?.outpatientCoverage, isTrue);
        expect(policy?.maternityCoverage, isTrue);
        expect(policy?.pharmacyCoverage, isTrue);
        expect(policy?.dentalCoverage, isFalse);
        expect(policy?.opticalCoverage, isFalse);
      });

      test('policy should have correct dates', () {
        final policy = memberProvider.policy;

        expect(policy?.startDate.year, equals(2024));
        expect(policy?.endDate.year, equals(2024));
        expect(policy?.startDate.month, equals(1));
        expect(policy?.endDate.month, equals(12));
      });

      test('policy should have coverage amount', () {
        final policy = memberProvider.policy;

        expect(policy?.coverageAmount, equals(500000.0));
      });

      test('policy should have copayment percentage', () {
        final policy = memberProvider.policy;

        expect(policy?.copaymentPercentage, equals(20));
      });
    });

    group('Member Properties', () {
      setUp(() async {
        await memberProvider.loadMemberData();
      });

      test('primary member should have complete information', () {
        final primary = memberProvider.primaryMember;

        expect(primary?.membershipId, equals('1234567890'));
        expect(primary?.nationalId, equals('1234567890'));
        expect(primary?.phone, equals('+966501234567'));
        expect(primary?.email, equals('mohammed@example.com'));
        expect(primary?.gender, equals(Gender.male));
        expect(primary?.status, equals(MemberStatus.active));
      });

      test('dependents should have Arabic names', () {
        final spouse = memberProvider.dependents[0];
        final son = memberProvider.dependents[1];

        expect(spouse.nameAr, equals('سارة منصور'));
        expect(son.nameAr, equals('أحمد منصور'));
      });

      test('all members should have same policy number', () {
        final allMembers = memberProvider.allMembers;

        for (final member in allMembers) {
          expect(member.policyNumber, equals('POL-2024-001'));
        }
      });
    });

    group('State Management', () {
      test('should handle multiple loads', () async {
        await memberProvider.loadMemberData();
        final firstPrimaryId = memberProvider.primaryMember?.id;

        await memberProvider.loadMemberData();
        final secondPrimaryId = memberProvider.primaryMember?.id;

        expect(firstPrimaryId, equals(secondPrimaryId));
      });

      test('should maintain selected member across reloads', () async {
        await memberProvider.loadMemberData();
        final member = memberProvider.primaryMember!;
        memberProvider.selectMember(member);

        await memberProvider.loadMemberData();

        // Selection is independent of data loading
        expect(memberProvider.selectedMember, isNotNull);
      });
    });

    group('Edge Cases', () {
      test('getMemberById should handle empty members list', () {
        final member = memberProvider.getMemberById('ANY_ID');

        // Before loading, allMembers is empty, so this might throw
        // The current implementation uses orElse: () => allMembers.first
        // which would fail on empty list. This is an edge case to document.
        expect(member, isNull);
      });

      test('clearSelectedMember should work when nothing selected', () {
        expect(memberProvider.selectedMember, isNull);

        memberProvider.clearSelectedMember();

        expect(memberProvider.selectedMember, isNull);
      });

      test('should handle rapid member selection changes', () async {
        await memberProvider.loadMemberData();
        final members = memberProvider.allMembers;

        for (final member in members) {
          memberProvider.selectMember(member);
        }

        expect(memberProvider.selectedMember?.id, equals(members.last.id));
      });
    });
  });
}
