import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Authentication Service
/// Handles login, OTP verification, and user session management
/// Uses shared_preferences to store auth token locally
class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _authToken;
  String? _userName;
  String? _loginMethod; // 'mobile' or 'id'
  String? _loginValue; // the mobile number or ID number

  bool get isAuthenticated => _isAuthenticated;
  String? get userName => _userName;
  String? get loginMethod => _loginMethod;
  String? get loginValue => _loginValue;

  /// Initialize auth service and check if user is already logged in
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('auth_token');
    _userName = prefs.getString('user_name');
    _loginMethod = prefs.getString('login_method');
    _loginValue = prefs.getString('login_value');

    if (_authToken != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  /// Send OTP to mobile or ID
  /// This is a DUMMY function - in real app, this would call an API
  /// Returns: success message or throws error
  Future<String> sendOtp({
    required String loginMethod,
    required String loginValue,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Store the login method and value for later verification
    _loginMethod = loginMethod;
    _loginValue = loginValue;

    // In a real app, you would call an API here
    // For now, we just return success
    return 'OTP sent successfully';
  }

  /// Verify OTP code
  /// This is a DUMMY function - in real app, this would call an API
  /// Returns: true if OTP is correct (123456), false otherwise
  Future<bool> verifyOtp(String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if OTP is the magic number: 123456
    if (otp == '123456') {
      // Create a dummy auth token
      _authToken = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
      _userName = 'Mansoor'; // Dummy user name
      _isAuthenticated = true;

      // Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', _authToken!);
      await prefs.setString('user_name', _userName!);
      await prefs.setString('login_method', _loginMethod!);
      await prefs.setString('login_value', _loginValue!);

      notifyListeners();
      return true;
    }

    return false;
  }

  /// Logout user
  /// Clears all stored data and resets authentication state
  Future<void> logout() async {
    _isAuthenticated = false;
    _authToken = null;
    _userName = null;
    _loginMethod = null;
    _loginValue = null;

    // Clear local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_name');
    await prefs.remove('login_method');
    await prefs.remove('login_value');

    notifyListeners();
  }
}
