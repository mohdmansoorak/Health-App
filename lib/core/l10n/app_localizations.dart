import 'package:flutter/material.dart';

/// Simple localization class for Arabic and English
/// In production, use flutter_localizations with ARB files
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isArabic => locale.languageCode == 'ar';

  // App
  String get appTitle => isArabic ? 'تأمين هيلث جارد' : 'HealthGuard Insurance';

  // Authentication
  String get login => isArabic ? 'تسجيل الدخول' : 'Login';
  String get loginWithMobile =>
      isArabic ? 'تسجيل الدخول بالجوال' : 'Login with Mobile';
  String get loginWithId =>
      isArabic ? 'تسجيل الدخول بالهوية' : 'Login with ID';
  String get sendOtp => isArabic ? 'إرسال الرمز' : 'Send OTP';
  String get verifyOtp => isArabic ? 'التحقق من الرمز' : 'Verify OTP';
  String get mobileNumber => isArabic ? 'رقم الجوال' : 'Mobile Number';
  String get nationalId => isArabic ? 'رقم الهوية الوطنية' : 'National ID';
  String get membershipId => isArabic ? 'رقم العضوية' : 'Membership ID';
  String get enterOtp => isArabic ? 'أدخل الرمز' : 'Enter OTP';
  String get resendOtp => isArabic ? 'إعادة إرسال الرمز' : 'Resend OTP';

  // Navigation
  String get home => isArabic ? 'الرئيسية' : 'Home';
  String get care => isArabic ? 'الرعاية' : 'Care';
  String get appointments => isArabic ? 'المواعيد' : 'Appointments';
  String get wellness => isArabic ? 'الصحة' : 'Wellness';
  String get claims => isArabic ? 'المطالبات' : 'Claims';
  String get profile => isArabic ? 'الملف الشخصي' : 'Profile';

  // Home Dashboard
  String get welcomeBack => isArabic ? 'مرحباً بعودتك' : 'Welcome Back';
  String get myInsuranceCard =>
      isArabic ? 'بطاقة التأمين الخاصة بي' : 'My Insurance Card';
  String get careConnectServices =>
      isArabic ? 'خدمات كير كونكت' : 'CareConnect Services';
  String get instantConsultation =>
      isArabic ? 'استشارة فورية' : 'Instant Consultation';
  String get onlineBooking => isArabic ? 'حجز أونلاين' : 'Online Booking';
  String get physicalClinic => isArabic ? 'العيادة الفعلية' : 'Physical Clinic';

  // Appointments
  String get bookAppointment => isArabic ? 'حجز موعد' : 'Book Appointment';
  String get manageAppointments =>
      isArabic ? 'إدارة المواعيد' : 'Manage Appointments';
  String get upcoming => isArabic ? 'القادمة' : 'Upcoming';
  String get previous => isArabic ? 'السابقة' : 'Previous';
  String get reschedule => isArabic ? 'إعادة الجدولة' : 'Reschedule';
  String get cancel => isArabic ? 'إلغاء' : 'Cancel';
  String get viewDetails => isArabic ? 'عرض التفاصيل' : 'View Details';

  // Common
  String get save => isArabic ? 'حفظ' : 'Save';
  String get back => isArabic ? 'رجوع' : 'Back';
  String get next => isArabic ? 'التالي' : 'Next';
  String get done => isArabic ? 'تم' : 'Done';
  String get loading => isArabic ? 'جاري التحميل...' : 'Loading...';
  String get error => isArabic ? 'خطأ' : 'Error';
  String get success => isArabic ? 'نجح' : 'Success';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
