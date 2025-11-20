import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

enum LoginMethod { mobile, id }

/// Login screen - supports mobile number or national/membership ID
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginMethod _selectedMethod = LoginMethod.mobile;
  final _identifierController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_identifierController.text.isEmpty) {
      _showError('Please enter your mobile number or ID');
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final session = await authProvider.sendOtp(_identifierController.text);

    setState(() => _isLoading = false);

    if (session != null) {
      if (mounted) {
        context.push('/otp');
      }
    } else {
      _showError('Failed to send OTP. Please try again.');
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
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Language toggle
          TextButton.icon(
            onPressed: () => localeProvider.toggleLocale(),
            icon: const Icon(Icons.language),
            label: Text(localeProvider.isArabic ? 'EN' : 'عربي'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppTheme.spacingXL),

              // Logo
              const Icon(
                Icons.local_hospital_rounded,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // Title
              Text(
                l10n.appTitle,
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingSM),

              Text(
                'Manage your health insurance with ease',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing2XL),

              // Login method selection
              Text(
                l10n.login,
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // Method selection buttons
              Row(
                children: [
                  Expanded(
                    child: _buildMethodButton(
                      method: LoginMethod.mobile,
                      icon: Icons.phone_android,
                      label: l10n.loginWithMobile,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: _buildMethodButton(
                      method: LoginMethod.id,
                      icon: Icons.badge,
                      label: l10n.loginWithId,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // Input field
              TextField(
                controller: _identifierController,
                keyboardType: _selectedMethod == LoginMethod.mobile
                    ? TextInputType.phone
                    : TextInputType.number,
                decoration: InputDecoration(
                  labelText: _selectedMethod == LoginMethod.mobile
                      ? l10n.mobileNumber
                      : l10n.nationalId,
                  hintText: _selectedMethod == LoginMethod.mobile
                      ? '+966 5XX XXX XXX'
                      : '1XXXXXXXXX',
                  prefixIcon: Icon(
                    _selectedMethod == LoginMethod.mobile
                        ? Icons.phone
                        : Icons.credit_card,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

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
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.sendOtp),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // Info text
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMD),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                ),
                child: Text(
                  'Demo: Enter any mobile number or ID, then use OTP: 123456',
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

  Widget _buildMethodButton({
    required LoginMethod method,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedMethod == method;

    return OutlinedButton(
      onPressed: () {
        setState(() => _selectedMethod = method);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 2,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
