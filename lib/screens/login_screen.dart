import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/services/auth_service.dart';

/// Login Screen
/// Allows user to login with Mobile Number OR ID Number
/// Validates input and sends OTP
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Login method: 'mobile' or 'id'
  String _loginMethod = 'mobile';

  // Text controllers for input fields
  final _mobileController = TextEditingController();
  final _idController = TextEditingController();

  // Country code for mobile (default Saudi Arabia)
  String _countryCode = '+966';

  // Loading state
  bool _isLoading = false;

  // Error message
  String? _errorMessage;

  @override
  void dispose() {
    _mobileController.dispose();
    _idController.dispose();
    super.dispose();
  }

  /// Validate and send OTP
  Future<void> _sendOtp() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    String loginValue;

    // Validate based on login method
    if (_loginMethod == 'mobile') {
      final mobile = _mobileController.text.trim();

      if (mobile.isEmpty) {
        setState(() {
          _errorMessage = 'Please enter your mobile number';
          _isLoading = false;
        });
        return;
      }

      if (mobile.length < 9) {
        setState(() {
          _errorMessage = 'Mobile number must be at least 9 digits';
          _isLoading = false;
        });
        return;
      }

      loginValue = '$_countryCode$mobile';
    } else {
      final id = _idController.text.trim();

      if (id.isEmpty) {
        setState(() {
          _errorMessage = 'Please enter your ID number';
          _isLoading = false;
        });
        return;
      }

      if (id.length < 10) {
        setState(() {
          _errorMessage = 'ID number must be at least 10 digits';
          _isLoading = false;
        });
        return;
      }

      loginValue = id;
    }

    try {
      // Send OTP via AuthService
      final authService = context.read<AuthService>();
      await authService.sendOtp(
        loginMethod: _loginMethod,
        loginValue: loginValue,
      );

      if (!mounted) return;

      // Navigate to OTP screen
      context.push(
        '/otp',
        extra: {
          'loginMethod': _loginMethod,
          'loginValue': loginValue,
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to send OTP. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Logo
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.shield,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Login to access your insurance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 40),

              // Login method toggle
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildMethodButton('Mobile', 'mobile'),
                    ),
                    Expanded(
                      child: _buildMethodButton('ID Number', 'id'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Input fields based on selected method
              if (_loginMethod == 'mobile') ...[
                _buildMobileInput(),
              ] else ...[
                _buildIdInput(),
              ],

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // Send OTP button
              ElevatedButton(
                onPressed: _isLoading ? null : _sendOtp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build method toggle button
  Widget _buildMethodButton(String label, String method) {
    final isSelected = _loginMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _loginMethod = method;
          _errorMessage = null;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  /// Build mobile number input
  Widget _buildMobileInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mobile Number',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Country code dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: const Text(
                '+966',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 12),
            // Mobile number input
            Expanded(
              child: TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  hintText: '5XXXXXXXX',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build ID number input
  Widget _buildIdInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ID Number',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _idController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            hintText: 'Enter your ID number',
            prefixIcon: Icon(Icons.badge),
          ),
        ),
      ],
    );
  }
}
