import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/services/auth_service.dart';

/// OTP Verification Screen
/// User enters 6-digit OTP code to verify login
/// Includes countdown timer and resend functionality
class OtpScreen extends StatefulWidget {
  final String loginMethod;
  final String loginValue;

  const OtpScreen({
    super.key,
    required this.loginMethod,
    required this.loginValue,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // OTP input controllers (6 digits)
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  // Timer for OTP expiry
  int _secondsRemaining = 30;
  Timer? _timer;

  // Loading and error states
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Start countdown timer
  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  /// Resend OTP
  Future<void> _resendOtp() async {
    final authService = context.read<AuthService>();

    try {
      await authService.sendOtp(
        loginMethod: widget.loginMethod,
        loginValue: widget.loginValue,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully'),
          backgroundColor: Color(0xFF10B981),
        ),
      );

      _startTimer();

      // Clear OTP fields
      for (var controller in _otpControllers) {
        controller.clear();
      }
      setState(() {
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to resend OTP'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
    }
  }

  /// Verify OTP
  Future<void> _verifyOtp() async {
    // Get OTP from all fields
    final otp = _otpControllers.map((c) => c.text).join();

    if (otp.length != 6) {
      setState(() {
        _errorMessage = 'Please enter all 6 digits';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = context.read<AuthService>();
      final success = await authService.verifyOtp(otp);

      if (!mounted) return;

      if (success) {
        // Navigate to home screen
        context.go('/home');
      } else {
        setState(() {
          _errorMessage = 'Invalid OTP. Please try again.';
          _isLoading = false;
        });

        // Clear OTP fields
        for (var controller in _otpControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Verification failed. Please try again.';
        _isLoading = false;
      });
    }
  }

  /// Get masked login value for display
  String get _maskedLoginValue {
    final value = widget.loginValue;
    if (widget.loginMethod == 'mobile') {
      if (value.length > 4) {
        return '${value.substring(0, value.length - 4).replaceAll(RegExp(r'.'), '*')}${value.substring(value.length - 4)}';
      }
    } else {
      if (value.length > 4) {
        return '${value.substring(0, 2)}${'*' * (value.length - 4)}${value.substring(value.length - 2)}';
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Icon
              const Icon(
                Icons.lock_outline,
                size: 64,
                color: Color(0xFF2563EB),
              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Enter OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle with masked login value
              Text(
                'We sent a code to ${widget.loginMethod == 'mobile' ? 'mobile' : 'ID'}: $_maskedLoginValue',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 8),

              // Hint about correct OTP
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Demo: Use OTP code 123456',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildOtpField(index)),
              ),

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
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // Verify button
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
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
                    : const Text('Verify'),
              ),

              const SizedBox(height: 24),

              // Timer and resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_secondsRemaining > 0) ...[
                    const Text(
                      'Resend OTP in ',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                    Text(
                      '${_secondsRemaining}s',
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    const Text(
                      "Didn't receive code? ",
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                    TextButton(
                      onPressed: _resendOtp,
                      child: const Text('Resend'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build single OTP input field
  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 48,
      height: 56,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            // Move to next field
            if (index < 5) {
              _focusNodes[index + 1].requestFocus();
            } else {
              // Last field, hide keyboard
              _focusNodes[index].unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            // Move to previous field on delete
            _focusNodes[index - 1].requestFocus();
          }

          setState(() {
            _errorMessage = null;
          });
        },
      ),
    );
  }
}
