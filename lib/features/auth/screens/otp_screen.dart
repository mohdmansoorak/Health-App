import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/member_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

/// OTP verification screen
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  int _countdown = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = 30;
      _canResend = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _countdown > 0) {
        setState(() => _countdown--);
        _startCountdown();
      } else if (mounted) {
        setState(() => _canResend = true);
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) {
      _showError('Please enter 6-digit OTP');
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.verifyOtp(_otpController.text);

    setState(() => _isLoading = false);

    if (success) {
      // Load member data
      if (mounted) {
        await context.read<MemberProvider>().loadMemberData();
        context.go('/home');
      }
    } else {
      _showError('Invalid OTP. Please try again.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppTheme.spacingXL),

              // Icon
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // Title
              Text(
                l10n.verifyOtp,
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingSM),

              Text(
                'Enter the 6-digit code sent to your mobile',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing2XL),

              // PIN Code Field
              Directionality(
                textDirection: TextDirection.ltr, // Always LTR for PIN
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    fieldHeight: 56,
                    fieldWidth: 48,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.border,
                    selectedColor: AppColors.primary,
                  ),
                  cursorColor: AppColors.primary,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (code) => _verifyOtp(),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // Countdown / Resend
              if (_canResend)
                TextButton(
                  onPressed: () {
                    _startCountdown();
                    // TODO: Resend OTP
                  },
                  child: Text(l10n.resendOtp),
                )
              else
                Text(
                  'Resend OTP in $_countdown seconds',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: AppTheme.spacingLG),

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
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.verifyOtp),
              ),
              const Spacer(),

              // Info
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMD),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                ),
                child: const Text(
                  'Demo OTP: 123456',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
