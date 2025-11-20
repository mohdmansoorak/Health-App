# Insurance Mobile App

A complete insurance mobile application built with Flutter, similar to Tawuniya app. This app allows users to manage their insurance policies, claims, view insurance cards, and get support.

## 📱 Features

### ✅ Implemented Features

1. **Login System**
   - Login with Mobile Number OR ID Number
   - OTP verification (use code: `123456`)
   - Secure token storage

2. **Home Dashboard**
   - Welcome message with user name
   - Quick access cards to all features
   - Beautiful blue-themed UI

3. **My Policies**
   - View all insurance policies
   - Policy details (Medical, Motor, Travel)
   - Coverage information
   - Expiry dates

4. **My Claims**
   - List of all claims
   - Status tracking (Submitted, Processing, Approved, Rejected)
   - Claim amounts and dates

5. **Insurance Card**
   - Digital insurance card
   - Member information
   - QR code and barcode placeholders
   - Download and share options

6. **Support / Contact Us**
   - Phone, Email, WhatsApp support
   - FAQ section
   - 24/7 availability info

7. **Profile**
   - User information
   - Settings
   - Logout functionality

## 🚀 How to Run the App

### Prerequisites

Before you start, make sure you have:

1. **Flutter installed** on your computer
   - Download from: https://flutter.dev/docs/get-started/install
   - Follow the installation guide for your operating system (Windows, Mac, or Linux)

2. **An Android Emulator OR a Real Android Phone**
   - For emulator: Install Android Studio
   - For real phone: Enable USB debugging in developer options

3. **VS Code or Android Studio** (code editor)

### Step-by-Step Guide

#### 1. Open Terminal/Command Prompt

Navigate to this project folder:
```bash
cd /path/to/Health-App
```

#### 2. Install Dependencies

Run this command to download all required packages:
```bash
flutter pub get
```

Wait for it to complete. You'll see "Got dependencies!" when done.

#### 3. Check Your Setup

Make sure everything is configured correctly:
```bash
flutter doctor
```

This shows you if Flutter is properly installed and if you have a device ready.

#### 4. Run the App

##### Option A: Using an Emulator

1. Start your Android emulator from Android Studio
2. Run:
```bash
flutter run
```

##### Option B: Using a Real Phone

1. Connect your phone via USB
2. Enable USB debugging on your phone
3. Run:
```bash
flutter run
```

The app will build and install on your device automatically!

### 🎯 First Time Login

When you open the app:

1. Wait for the splash screen (2 seconds)
2. You'll see the login screen
3. Choose **Mobile** or **ID** login
4. Enter any number (e.g., `501234567` for mobile or `1234567890` for ID)
5. Click "Send OTP"
6. Enter OTP code: **123456** (this is the only code that works)
7. Click "Verify"
8. You're in! 🎉

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── config/
│   ├── router.dart          # Navigation routes
│   └── theme.dart           # App colors and styles
├── models/
│   ├── policy.dart          # Policy data model
│   └── claim.dart           # Claim data model
├── screens/
│   ├── splash_screen.dart   # Splash screen
│   ├── login_screen.dart    # Login page
│   ├── otp_screen.dart      # OTP verification
│   ├── home_screen.dart     # Main dashboard
│   ├── policies_screen.dart # Policies list
│   ├── policy_detail_screen.dart
│   ├── claims_screen.dart
│   ├── insurance_card_screen.dart
│   ├── support_screen.dart
│   └── profile_screen.dart
└── services/
    └── auth_service.dart    # Authentication logic
```

## 📦 Building for Production

### Build Android APK

To create an installable APK file:

```bash
flutter build apk --release
```

The APK will be created at:
```
build/app/outputs/flutter-apk/app-release.apk
```

You can install this APK on any Android phone!

### Build for iOS (Mac only)

```bash
flutter build ios --release
```

## 🎨 Color Theme

The app uses a professional blue theme:
- Primary Blue: `#2563EB`
- Dark Blue: `#1E40AF`
- Light Blue: `#3B82F6`

## 🔧 Troubleshooting

### "Command not found: flutter"
- Flutter is not installed or not in your PATH
- Reinstall Flutter and add it to your system PATH

### "No devices found"
- Make sure your emulator is running OR
- Your phone is connected and USB debugging is enabled

### "Gradle build failed"
- Delete `build` folder and run again
- Make sure you have internet connection (needs to download dependencies)

### App shows error on startup
- Run `flutter clean`
- Run `flutter pub get`
- Try running again

## 📝 Notes for Non-Developers

- **This app uses DUMMY DATA** - all policies, claims, and user info are fake
- **OTP code is always 123456** - this is for testing only
- **No real backend** - everything runs locally on your phone
- **Ready for API integration** - the code is structured to easily connect to a real backend later

## 🔐 Security Note

Currently, the app stores auth tokens in local storage (SharedPreferences). For a production app, you should:
- Implement proper token encryption
- Add token expiry
- Use secure backend APIs
- Implement proper user authentication

## 📞 Need Help?

If you face any issues:

1. Check the **Troubleshooting** section above
2. Make sure you followed all steps in **How to Run**
3. Check Flutter documentation: https://flutter.dev/docs
4. Verify Flutter is installed correctly: `flutter doctor`

## 📄 License

This is a demo project for educational purposes.

---

**Made with Flutter** 💙

**Happy Coding!** 🚀
