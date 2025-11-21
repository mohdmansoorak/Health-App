import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_insurance_app/core/providers/auth_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthProvider Tests', () {
    late AuthProvider authProvider;

    setUp(() async {
      // Clear shared preferences before each test
      SharedPreferences.setMockInitialValues({});
      authProvider = AuthProvider();
      // Wait for initialization to complete
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      authProvider.dispose();
    });

    group('Initialization', () {
      test('should initialize with unauthenticated state', () {
        expect(authProvider.isAuthenticated, isFalse);
        expect(authProvider.authToken, isNull);
        expect(authProvider.userId, isNull);
        expect(authProvider.otpSession, isNull);
      });

      test('should initialize with biometric disabled on web', () {
        expect(authProvider.isBiometricEnabled, isFalse);
        // On web, biometric should not be available
        // On mobile tests, it would be true
      });

      test('should restore authenticated state from storage', () async {
        // Setup - create provider with existing auth data
        SharedPreferences.setMockInitialValues({
          'auth_token': 'TEST_TOKEN_123',
          'user_id': 'TEST_USER_123',
        });

        final provider = AuthProvider();
        await Future.delayed(const Duration(milliseconds: 100));

        expect(provider.isAuthenticated, isTrue);
        expect(provider.authToken, 'TEST_TOKEN_123');
        expect(provider.userId, 'TEST_USER_123');

        provider.dispose();
      });
    });

    group('OTP Authentication', () {
      test('sendOtp should return session ID', () async {
        final session = await authProvider.sendOtp('1234567890');

        expect(session, isNotNull);
        expect(session, startsWith('SESSION_'));
        expect(authProvider.otpSession, equals(session));
      });

      test('sendOtp should handle multiple identifiers', () async {
        final session1 = await authProvider.sendOtp('mobile:1234567890');
        final session2 = await authProvider.sendOtp('id:ABC123');

        expect(session1, isNotNull);
        expect(session2, isNotNull);
        expect(session1, isNot(equals(session2)));
      });

      test('verifyOtp should succeed with correct OTP', () async {
        await authProvider.sendOtp('1234567890');
        final result = await authProvider.verifyOtp('123456');

        expect(result, isTrue);
        expect(authProvider.isAuthenticated, isTrue);
        expect(authProvider.authToken, isNotNull);
        expect(authProvider.userId, isNotNull);
      });

      test('verifyOtp should fail with incorrect OTP', () async {
        await authProvider.sendOtp('1234567890');
        final result = await authProvider.verifyOtp('000000');

        expect(result, isFalse);
        expect(authProvider.isAuthenticated, isFalse);
        expect(authProvider.authToken, isNull);
      });

      test('verifyOtp should persist authentication to storage', () async {
        await authProvider.sendOtp('1234567890');
        await authProvider.verifyOtp('123456');

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('auth_token'), isNotNull);
        expect(prefs.getString('user_id'), isNotNull);
      });
    });

    group('Biometric Authentication', () {
      test('enableBiometric should return false on web', () async {
        final result = await authProvider.enableBiometric();
        // On web, biometric is not available
        expect(result, isFalse);
      });

      test('authenticateWithBiometric should return false on web', () async {
        final result = await authProvider.authenticateWithBiometric();
        // On web, biometric is not available
        expect(result, isFalse);
      });

      test('disableBiometric should update state', () async {
        await authProvider.disableBiometric();

        expect(authProvider.isBiometricEnabled, isFalse);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool('biometric_enabled'), isFalse);
      });
    });

    group('Logout', () {
      test('logout should clear authentication state', () async {
        // First authenticate
        await authProvider.sendOtp('1234567890');
        await authProvider.verifyOtp('123456');

        expect(authProvider.isAuthenticated, isTrue);

        // Then logout
        await authProvider.logout();

        expect(authProvider.isAuthenticated, isFalse);
        expect(authProvider.authToken, isNull);
        expect(authProvider.userId, isNull);
        expect(authProvider.otpSession, isNull);
      });

      test('logout should clear storage', () async {
        // First authenticate
        await authProvider.sendOtp('1234567890');
        await authProvider.verifyOtp('123456');

        // Then logout
        await authProvider.logout();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('auth_token'), isNull);
        expect(prefs.getString('user_id'), isNull);
      });
    });

    group('First Login Check', () {
      test('isFirstLogin should return true on first call', () async {
        final isFirst = await authProvider.isFirstLogin();
        expect(isFirst, isTrue);
      });

      test('isFirstLogin should return false on subsequent calls', () async {
        await authProvider.isFirstLogin();
        final isFirst = await authProvider.isFirstLogin();
        expect(isFirst, isFalse);
      });

      test('isFirstLogin should persist state', () async {
        await authProvider.isFirstLogin();

        // Create new provider instance
        final newProvider = AuthProvider();
        await Future.delayed(const Duration(milliseconds: 100));

        final isFirst = await newProvider.isFirstLogin();
        expect(isFirst, isFalse);

        newProvider.dispose();
      });
    });

    group('State Management', () {
      test('should notify listeners on authentication', () async {
        var notified = false;
        authProvider.addListener(() {
          notified = true;
        });

        await authProvider.sendOtp('1234567890');
        await authProvider.verifyOtp('123456');

        expect(notified, isTrue);
      });

      test('should notify listeners on logout', () async {
        // First authenticate
        await authProvider.sendOtp('1234567890');
        await authProvider.verifyOtp('123456');

        var notified = false;
        authProvider.addListener(() {
          notified = true;
        });

        await authProvider.logout();

        expect(notified, isTrue);
      });
    });

    group('Edge Cases', () {
      test('should handle empty OTP', () async {
        await authProvider.sendOtp('1234567890');
        final result = await authProvider.verifyOtp('');

        expect(result, isFalse);
      });

      test('should handle null session on verify', () async {
        // Verify without sending OTP first
        final result = await authProvider.verifyOtp('123456');

        expect(result, isTrue); // Mock still accepts correct OTP
      });

      test('should handle multiple logout calls', () async {
        await authProvider.logout();
        await authProvider.logout();

        expect(authProvider.isAuthenticated, isFalse);
      });
    });
  });
}
