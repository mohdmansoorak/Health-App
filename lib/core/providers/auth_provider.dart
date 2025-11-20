import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Manages authentication state
/// Supports OTP login and biometric authentication
class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isBiometricEnabled = false;
  bool _isBiometricAvailable = false;
  String? _authToken;
  String? _userId;
  String? _otpSession;

  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _biometricEnabledKey = 'biometric_enabled';

  bool get isAuthenticated => _isAuthenticated;
  bool get isBiometricEnabled => _isBiometricEnabled;
  bool get isBiometricAvailable => _isBiometricAvailable;
  String? get authToken => _authToken;
  String? get userId => _userId;
  String? get otpSession => _otpSession;

  AuthProvider() {
    _checkAuthStatus();
    _checkBiometricAvailability();
  }

  /// Check if user is already authenticated
  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = await _secureStorage.read(key: _tokenKey);
    _userId = prefs.getString(_userIdKey);
    _isBiometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;

    if (_authToken != null && _userId != null) {
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  /// Check if biometric authentication is available on device
  Future<void> _checkBiometricAvailability() async {
    try {
      _isBiometricAvailable = await _localAuth.canCheckBiometrics;
      notifyListeners();
    } catch (e) {
      _isBiometricAvailable = false;
    }
  }

  /// Send OTP to mobile number or ID
  /// Returns session ID for verification
  Future<String?> sendOtp(String identifier) async {
    try {
      // Mock API call
      await Future.delayed(const Duration(seconds: 1));

      // In production, call: final response = await authApi.sendOtp(identifier);
      _otpSession = 'SESSION_${DateTime.now().millisecondsSinceEpoch}';

      notifyListeners();
      return _otpSession;
    } catch (e) {
      return null;
    }
  }

  /// Verify OTP
  /// Mock: accepts "123456" as valid OTP
  Future<bool> verifyOtp(String otp) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock verification
      if (otp == '123456') {
        _authToken = 'TOKEN_${DateTime.now().millisecondsSinceEpoch}';
        _userId = 'USER_${DateTime.now().millisecondsSinceEpoch}';
        _isAuthenticated = true;

        // Save to storage
        final prefs = await SharedPreferences.getInstance();
        await _secureStorage.write(key: _tokenKey, value: _authToken);
        await prefs.setString(_userIdKey, _userId!);

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Enable biometric authentication
  Future<bool> enableBiometric() async {
    if (!_isBiometricAvailable) return false;

    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Enable biometric login for quick access',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        _isBiometricEnabled = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_biometricEnabledKey, true);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Authenticate with biometric
  Future<bool> authenticateWithBiometric() async {
    if (!_isBiometricEnabled || !_isBiometricAvailable) return false;

    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access your health insurance',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Disable biometric authentication
  Future<void> disableBiometric() async {
    _isBiometricEnabled = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, false);
    notifyListeners();
  }

  /// Logout
  Future<void> logout() async {
    _isAuthenticated = false;
    _authToken = null;
    _userId = null;
    _otpSession = null;

    final prefs = await SharedPreferences.getInstance();
    await _secureStorage.delete(key: _tokenKey);
    await prefs.remove(_userIdKey);

    notifyListeners();
  }

  /// Check if this is first login (for biometric setup prompt)
  Future<bool> isFirstLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLoggedIn = prefs.getBool('has_logged_in') ?? false;
    if (!hasLoggedIn) {
      await prefs.setBool('has_logged_in', true);
      return true;
    }
    return false;
  }
}
