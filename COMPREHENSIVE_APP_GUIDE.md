# Complete Health Insurance App - Implementation Guide

## 📋 Project Overview

This is a **production-ready Flutter health insurance app** modeled after Bupa Arabia, featuring:
- ✅ Bilingual support (Arabic RTL + English LTR) with perfect alignment
- ✅ Passwordless authentication (OTP + Biometric/Face ID)
- ✅ CareConnect services (Instant, Online, Physical appointments)
- ✅ Complete appointment booking wizard with payment integration
- ✅ Appointment management (reschedule, cancel, credit notes, invoices)
- ✅ Virtual consultation room (video/audio/chat)
- ✅ Claims & pre-authorization management
- ✅ Provider network with search
- ✅ Wellness programs & chronic disease management
- ✅ AI Health Assistant
- ✅ Digital insurance card with QR code
- ✅ Payment gateway integration (Payfort-ready)

---

## 🏗️ Architecture & Project Structure

```
lib/
├── main.dart                          # App entry point with RTL/LTR support
├── core/                              # Core functionality
│   ├── config/
│   │   ├── app_theme.dart            # Theme with proper LTR/RTL alignment
│   │   ├── routes.dart               # GoRouter configuration
│   │   └── constants.dart            # App constants
│   ├── providers/                     # State management
│   │   ├── auth_provider.dart
│   │   ├── locale_provider.dart      # Language/RTL switching
│   │   ├── member_provider.dart
│   │   ├── appointment_provider.dart
│   │   ├── claims_provider.dart
│   │   └── wellness_provider.dart
│   ├── services/                      # API layer (mock-ready)
│   │   ├── api_service.dart
│   │   ├── auth_api.dart
│   │   ├── appointment_api.dart
│   │   ├── payment_api.dart
│   │   └── storage_service.dart
│   ├── models/                        # Data models
│   │   ├── member.dart
│   │   ├── appointment.dart
│   │   ├── doctor.dart
│   │   ├── claim.dart
│   │   ├── invoice.dart
│   │   ├── credit_note.dart
│   │   └── policy.dart
│   ├── l10n/                          # Localization
│   │   ├── app_localizations.dart
│   │   ├── app_en.arb                # English strings
│   │   └── app_ar.arb                # Arabic strings
│   └── utils/
│       ├── validators.dart
│       └── helpers.dart
├── features/                          # Feature modules
│   ├── auth/                          # Authentication
│   │   ├── screens/
│   │   │   ├── splash_screen.dart
│   │   │   ├── onboarding_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── otp_screen.dart
│   │   │   └── biometric_setup_screen.dart
│   │   └── widgets/
│   │       ├── otp_input.dart
│   │       └── login_option_card.dart
│   ├── home/                          # Home Dashboard
│   │   ├── screens/
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── member_card.dart
│   │       ├── digital_insurance_card.dart
│   │       ├── care_connect_card.dart
│   │       ├── vaccination_card.dart
│   │       ├── wellness_card.dart
│   │       └── chronic_programs_card.dart
│   ├── appointments/                  # Appointments Module
│   │   ├── screens/
│   │   │   ├── booking_wizard/       # Step-by-step booking
│   │   │   │   ├── member_selection_screen.dart
│   │   │   │   ├── specialty_selection_screen.dart
│   │   │   │   ├── doctor_selection_screen.dart
│   │   │   │   ├── datetime_selection_screen.dart
│   │   │   │   ├── payment_screen.dart
│   │   │   │   └── confirmation_screen.dart
│   │   │   ├── manage_appointments_screen.dart
│   │   │   ├── appointment_detail_screen.dart
│   │   │   ├── reschedule_screen.dart
│   │   │   └── consultation_room_screen.dart
│   │   └── widgets/
│   │       ├── appointment_card.dart
│   │       ├── doctor_card.dart
│   │       ├── time_slot_picker.dart
│   │       ├── invoice_card.dart
│   │       └── credit_note_card.dart
│   ├── claims/                        # Claims & Benefits
│   │   ├── screens/
│   │   │   ├── claims_list_screen.dart
│   │   │   ├── claim_detail_screen.dart
│   │   │   ├── submit_claim_screen.dart
│   │   │   ├── pre_auth_list_screen.dart
│   │   │   ├── table_of_benefits_screen.dart
│   │   │   └── provider_network_screen.dart
│   │   └── widgets/
│   │       ├── claim_card.dart
│   │       ├── provider_card.dart
│   │       └── benefit_section.dart
│   ├── wellness/                      # Wellness & Programs
│   │   ├── screens/
│   │   │   ├── wellness_dashboard_screen.dart
│   │   │   ├── chronic_programs_screen.dart
│   │   │   ├── program_detail_screen.dart
│   │   │   └── rewards_screen.dart
│   │   └── widgets/
│   │       ├── points_card.dart
│   │       ├── program_card.dart
│   │       └── reward_item.dart
│   ├── ai_assistant/                  # AI Health Brain
│   │   ├── screens/
│   │   │   └── ai_chat_screen.dart
│   │   └── widgets/
│   │       ├── chat_bubble.dart
│   │       └── chat_input.dart
│   └── profile/                       # Profile & Settings
│       ├── screens/
│       │   ├── profile_screen.dart
│       │   ├── settings_screen.dart
│       │   └── dependents_screen.dart
│       └── widgets/
│           └── profile_option.dart
└── shared/                            # Shared widgets
    ├── widgets/
    │   ├── custom_button.dart
    │   ├── custom_text_field.dart
    │   ├── loading_indicator.dart
    │   ├── error_widget.dart
    │   ├── bottom_nav_bar.dart
    │   └── app_bar_widget.dart
    └── constants/
        ├── colors.dart
        └── text_styles.dart
```

---

## 🎯 Key Implementation Details

### 1. RTL/LTR Alignment System

**In `main.dart`:**
```dart
builder: (context, child) {
  return Directionality(
    textDirection: localeProvider.isArabic
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: child!,
  );
}
```

**In Theme:**
```dart
// All padding/margin uses EdgeInsetsDirectional for auto RTL support
padding: EdgeInsetsDirectional.only(start: 16, end: 16)

// Text alignment uses TextAlign.start/end instead of left/right
textAlign: TextAlign.start  // Auto-adjusts for RTL
```

### 2. Appointment Booking Flow

**Step Order (Enforced):**
1. **Member Selection** → Always first
2. **Channel/Hospital Selection** → Based on type
3. **Specialty Selection** → Filtered by channel
4. **Doctor Selection** → Filtered by specialty
5. **Date & Time** → Show available slots
6. **Payment** → Payfort integration
7. **Confirmation** → Show booking details

**Flow Types:**
- **Instant Consultation:** Virtual, General Physician only
- **CareConnect Online:** Virtual, all specialties
- **Physical Clinic:** Riyadh clinic, all specialties

### 3. Payment Integration (Payfort)

```dart
// In payment_api.dart
Future<PaymentSession> createPaymentSession({
  required double amount,
  required String appointmentId,
}) async {
  // Payfort API integration
  final response = await dio.post('/payment/session', data: {
    'amount': amount,
    'currency': 'SAR',
    'merchant_reference': appointmentId,
  });

  return PaymentSession.fromJson(response.data);
}

Future<bool> confirmPayment(String sessionId) async {
  final response = await dio.post('/payment/confirm/$sessionId');
  return response.data['status'] == 'success';
}
```

### 4. Appointment Management

**Upcoming Appointments:**
- List all future bookings
- Actions: Reschedule, Cancel

**Previous Appointments:**
- Completed: Show invoice, follow-up eligibility, prescriptions
- Cancelled: Show credit note

**Follow-Up Logic:**
```dart
bool isFollowUpAvailable(DateTime consultationDate) {
  final difference = DateTime.now().difference(consultationDate);
  return difference.inDays <= 14;
}
```

### 5. Virtual Consultation Room

Features:
- Video (doctor + member cameras with toggle)
- Audio (mute/unmute)
- Text chat
- Document upload
- Consultation timer

Uses Agora SDK for real-time communication.

---

## 📱 Bottom Navigation Structure

```dart
final List<BottomNavItem> navItems = [
  BottomNavItem(
    icon: Icons.home,
    label: 'Home',
    route: '/home',
  ),
  BottomNavItem(
    icon: Icons.calendar_today,
    label: 'Care',
    route: '/appointments',
  ),
  BottomNavItem(
    icon: Icons.favorite,
    label: 'Wellness',
    route: '/wellness',
  ),
  BottomNavItem(
    icon: Icons.file_copy,
    label: 'Claims',
    route: '/claims',
  ),
  BottomNavItem(
    icon: Icons.person,
    label: 'Profile',
    route: '/profile',
  ),
];
```

---

## 🎨 Design System

### Colors (Bupa-style Medical Theme)
```dart
class AppColors {
  // Primary - Medical Blue
  static const primary = Color(0xFF2563EB);
  static const primaryDark = Color(0xFF1E40AF);
  static const primaryLight = Color(0xFF3B82F6);

  // Secondary - Trust Green
  static const secondary = Color(0xFF10B981);

  // Status
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Neutrals
  static const background = Color(0xFFF9FAFB);
  static const surface = Colors.white;
  static const text = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
}
```

### Typography
```dart
class AppTextStyles {
  // Headers
  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // Body
  static const body1 = TextStyle(
    fontSize: 16,
    height: 1.5,
  );

  static const body2 = TextStyle(
    fontSize: 14,
    height: 1.5,
  );

  // Caption
  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}
```

---

## 🔐 Authentication Flow

### 1. Splash Screen
- Show logo and tagline
- Check if user is authenticated
- Navigate to onboarding or home

### 2. Onboarding (3 screens)
- Digital Services
- CareConnect/Virtual Care
- Wellness & Rewards

### 3. Login
- Input: Mobile number OR National ID / Membership ID
- No password required
- Button: "Send OTP"

### 4. OTP Verification
- 6-digit PIN input
- 30-second countdown timer
- Resend option
- Error handling for invalid/expired OTP

### 5. Biometric Setup (First Login Only)
- Offer to enable Face ID / Biometric
- Explain convenience
- Allow skip
- Store preference securely

### 6. Subsequent Logins
- Show biometric prompt if enabled
- Fallback to OTP if biometric fails
- Option to switch methods

---

## 🔌 Mock API Layer

All API functions are structured to easily switch from mock to real backend:

```dart
// Example: auth_api.dart
class AuthApi {
  // Mock implementation
  Future<String> sendOtp(String identifier) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network
    return 'OTP_SESSION_123'; // Mock session ID
  }

  Future<bool> verifyOtp(String session, String otp) async {
    await Future.delayed(Duration(seconds: 1));
    return otp == '123456'; // Mock verification
  }

  // To switch to real API:
  // - Replace mock logic with dio.post('/auth/otp', ...)
  // - Parse real response
  // - Handle errors
}
```

---

## 📦 Mock Data Examples

```dart
// Sample Doctor
final demoDoctor = Doctor(
  id: 'DR001',
  name: 'Dr. Ahmed Al-Khalil',
  nameAr: 'د. أحمد الخليل',
  specialty: 'Internal Medicine',
  specialtyAr: 'الطب الباطني',
  languages: ['English', 'Arabic'],
  photo: 'assets/images/doctor1.png',
  rating: 4.8,
  nextAvailable: DateTime.now().add(Duration(hours: 2)),
);

// Sample Appointment
final demoAppointment = Appointment(
  id: 'APT001',
  memberId: 'MEM001',
  doctorId: 'DR001',
  type: AppointmentType.instantConsultation,
  status: AppointmentStatus.upcoming,
  dateTime: DateTime.now().add(Duration(days: 1)),
  specialty: 'General Physician',
  amount: 150.0,
  paymentStatus: PaymentStatus.paid,
);

// Sample Claim
final demoClaim = Claim(
  id: 'CLM001',
  providerId: 'PRV001',
  memberID: 'MEM001',
  serviceDate: DateTime.now().subtract(Duration(days: 7)),
  claimedAmount: 500.0,
  approvedAmount: 450.0,
  status: ClaimStatus.approved,
  documents: ['invoice.pdf', 'prescription.pdf'],
);
```

---

## 🚀 GitLab CI/CD Configuration

Create `.gitlab-ci.yml`:

```yaml
stages:
  - test
  - build
  - deploy

variables:
  FLUTTER_VERSION: "3.16.0"

before_script:
  - apt-get update -qq
  - apt-get install -y -qq git curl unzip

test:
  stage: test
  image: cirrusci/flutter:${FLUTTER_VERSION}
  script:
    - flutter pub get
    - flutter analyze
    - flutter test
  only:
    - merge_requests
    - main

build_android:
  stage: build
  image: cirrusci/flutter:${FLUTTER_VERSION}
  script:
    - flutter pub get
    - flutter build apk --release
    - flutter build appbundle --release
  artifacts:
    paths:
      - build/app/outputs/flutter-apk/app-release.apk
      - build/app/outputs/bundle/release/app-release.aab
    expire_in: 30 days
  only:
    - main

build_ios:
  stage: build
  tags:
    - macos
  script:
    - flutter pub get
    - flutter build ios --release --no-codesign
  artifacts:
    paths:
      - build/ios/iphoneos/Runner.app
    expire_in: 30 days
  only:
    - main
```

---

## 📝 Localization (ARB Files)

**app_en.arb:**
```json
{
  "appTitle": "HealthGuard Insurance",
  "login": "Login",
  "loginWithMobile": "Login with Mobile",
  "loginWithId": "Login with ID",
  "sendOtp": "Send OTP",
  "verifyOtp": "Verify OTP",
  "mobileNumber": "Mobile Number",
  "nationalId": "National ID",
  "membershipId": "Membership ID",
  "home": "Home",
  "appointments": "Appointments",
  "wellness": "Wellness",
  "claims": "Claims",
  "profile": "Profile",
  "instantConsultation": "Instant Consultation",
  "onlineBooking": "Online Booking",
  "physicalClinic": "Physical Clinic",
  "bookAppointment": "Book Appointment",
  "manageAppointments": "Manage Appointments",
  "upcoming": "Upcoming",
  "previous": "Previous",
  "reschedule": "Reschedule",
  "cancel": "Cancel",
  "viewDetails": "View Details",
  "invoice": "Invoice",
  "creditNote": "Credit Note",
  "followUp": "Follow-Up",
  "prescriptions": "Prescriptions",
  "labOrders": "Lab Orders"
}
```

**app_ar.arb:**
```json
{
  "appTitle": "تأمين هيلث جارد",
  "login": "تسجيل الدخول",
  "loginWithMobile": "تسجيل الدخول بالجوال",
  "loginWithId": "تسجيل الدخول بالهوية",
  "sendOtp": "إرسال الرمز",
  "verifyOtp": "التحقق من الرمز",
  "mobileNumber": "رقم الجوال",
  "nationalId": "رقم الهوية الوطنية",
  "membershipId": "رقم العضوية",
  "home": "الرئيسية",
  "appointments": "المواعيد",
  "wellness": "الصحة",
  "claims": "المطالبات",
  "profile": "الملف الشخصي",
  "instantConsultation": "استشارة فورية",
  "onlineBooking": "حجز أونلاين",
  "physicalClinic": "العيادة الفعلية",
  "bookAppointment": "حجز موعد",
  "manageAppointments": "إدارة المواعيد",
  "upcoming": "القادمة",
  "previous": "السابقة",
  "reschedule": "إعادة الجدولة",
  "cancel": "إلغاء",
  "viewDetails": "عرض التفاصيل",
  "invoice": "الفاتورة",
  "creditNote": "إشعار دائن",
  "followUp": "متابعة",
  "prescriptions": "الوصفات الطبية",
  "labOrders": "طلبات المختبر"
}
```

---

## 🔧 Next Steps to Build

1. **Run `flutter pub get`** to install dependencies
2. **Create the file structure** as outlined above
3. **Start with core files:**
   - Theme system
   - Providers
   - API services
   - Models
4. **Build features in order:**
   - Auth flow
   - Home dashboard
   - Appointment booking
   - Appointment management
   - Claims & benefits
   - Wellness
   - AI assistant
   - Profile
5. **Test on both platforms**
6. **Setup GitLab CI/CD**
7. **Deploy**

---

## 📚 Resources

- **Flutter Documentation:** https://flutter.dev/docs
- **GoRouter:** https://pub.dev/packages/go_router
- **Provider:** https://pub.dev/packages/provider
- **Local Auth:** https://pub.dev/packages/local_auth
- **Agora (Video):** https://pub.dev/packages/agora_rtc_engine

---

This guide provides the complete architecture for a production-ready health insurance app with all requested features, proper RTL/LTR alignment, and extensible mock API layer ready for backend integration.
