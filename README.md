# Health Insurance App

A comprehensive health insurance management application available in two platforms:
- **Web Application**: React-based responsive web app
- **Mobile Application**: Flutter-based native mobile app for Android/iOS

Both apps feature a professional blue color theme (#2563EB) and provide complete insurance management capabilities.

## 🚀 Live Deployments

### Web Application
- **Live URL**: https://mohdmansoorak.github.io/Health-App
- **Status**: Automatically deployed via GitHub Actions on every push to main
- **Technology**: React 18 + React Router DOM v6

### Mobile Application
- **Platform**: Android APK and iOS (Flutter)
- **Build Status**: Automatically built via GitLab CI/CD
- **Download**: Check GitLab CI/CD artifacts for latest APK builds

## 📱 Mobile App (Flutter)

### Features
- **Authentication**: Login with mobile number or ID number, OTP verification
- **Home Dashboard**: Welcome screen with quick access cards
- **My Policies**: View all insurance policies with details
- **My Claims**: Track claims with status indicators
- **Insurance Card**: Digital insurance card with QR code
- **Support**: Contact options, FAQ, and help resources
- **Profile**: User profile management and settings

### Getting Started (Mobile)

#### Prerequisites
- Flutter 3.16+ installed
- Android Studio or VS Code with Flutter extension
- Android device/emulator or iOS device/simulator

#### Installation
```bash
# Get Flutter dependencies
flutter pub get

# Run on connected device
flutter run

# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
```

#### Login Instructions
1. Enter mobile number (e.g., 501234567) OR ID number (e.g., 1234567890)
2. Click "Send OTP"
3. Enter OTP: **123456** (hardcoded for demo)
4. Access all features

### Project Structure (Flutter)
```
lib/
├── config/
│   ├── router.dart          # Navigation configuration
│   └── theme.dart           # App theme and colors
├── models/
│   ├── policy.dart          # Policy data model
│   └── claim.dart           # Claim data model
├── screens/
│   ├── splash_screen.dart   # Initial loading screen
│   ├── login_screen.dart    # Login with mobile/ID
│   ├── otp_screen.dart      # OTP verification
│   ├── home_screen.dart     # Main dashboard
│   ├── policies_screen.dart # Policies list
│   ├── policy_detail_screen.dart
│   ├── claims_screen.dart   # Claims management
│   ├── insurance_card_screen.dart
│   ├── support_screen.dart
│   └── profile_screen.dart
├── services/
│   └── auth_service.dart    # Authentication logic
└── main.dart                # App entry point
```

## 🌐 Web App (React)

### Features
- **Authentication**: User login and registration
- **Dashboard**: Policy overview, recent claims, quick actions
- **Policy Management**: View policies, coverage details, family members
- **Claims Management**: File claims, track status, upload documents
- **Healthcare Providers**: Find doctors and hospitals, filter by specialty
- **Digital ID Card**: View, download, and print insurance card
- **Payments**: Pay premiums, payment history, auto-pay settings
- **Profile & Settings**: Manage personal information, security settings
- **Support**: FAQ, contact options, support tickets

### Getting Started (Web)

#### Prerequisites
- Node.js 16+
- npm or yarn

#### Installation
```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build

# Deploy to GitHub Pages
npm run deploy
```

#### Demo Access
Use any email and password to log in and explore the web app.

### Project Structure (React)
```
src/
├── components/
│   └── Layout.js            # Main layout with navigation
├── context/
│   └── AppContext.js        # Global state management
├── data/
│   └── mockData.js          # Mock data for demo
├── pages/
│   ├── Login.js
│   ├── Register.js
│   ├── Dashboard.js
│   ├── Policies.js
│   ├── PolicyDetails.js
│   ├── Claims.js
│   ├── FileClaim.js
│   ├── Providers.js
│   ├── IDCard.js
│   ├── Payments.js
│   ├── Profile.js
│   └── Support.js
├── styles/
│   └── global.css
├── App.js
└── index.js
```

## 🎨 Design System

### Color Palette
- **Primary**: #2563EB (Blue)
- **Primary Dark**: #1E40AF
- **Primary Light**: #3B82F6
- **Success**: #10B981 (Green)
- **Warning**: #F59E0B (Amber)
- **Error**: #EF4444 (Red)
- **Background**: #F9FAFB

### Typography
- Flutter: Default Material Design fonts
- React: System font stack (-apple-system, BlinkMacSystemFont, Segoe UI)

## 🔧 Technology Stack

### Mobile (Flutter)
- **Framework**: Flutter 3.16+
- **Language**: Dart
- **State Management**: Provider
- **Routing**: go_router
- **Local Storage**: shared_preferences
- **UI**: Material Design 3

### Web (React)
- **Framework**: React 18
- **Routing**: React Router DOM v6
- **Icons**: Lucide React
- **Styling**: CSS-in-JS
- **State**: Context API

## 📦 Deployment

### Automated Deployments

#### Web (GitHub Actions)
- Triggered on push to `main` branch
- Builds Flutter web version
- Deploys to GitHub Pages
- URL: https://mohdmansoorak.github.io/Health-App

#### Mobile (GitLab CI/CD)
- Builds Android APK (debug & release)
- Builds Android App Bundle
- Builds Flutter web version
- Artifacts available for 30 days

### Manual Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for comprehensive deployment instructions including:
- Web deployment to GitHub Pages
- Android APK installation
- iOS build and deployment
- Troubleshooting guide

## 🧪 Testing

### Mobile App Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Web App Testing
```bash
# Run tests
npm test

# Run tests with coverage
npm test -- --coverage
```

## 📱 Features Comparison

| Feature | Mobile App | Web App |
|---------|-----------|---------|
| Authentication | ✅ Mobile/ID + OTP | ✅ Email/Password |
| Dashboard | ✅ | ✅ |
| Policies | ✅ | ✅ |
| Claims | ✅ | ✅ |
| Insurance Card | ✅ | ✅ |
| Providers | ❌ | ✅ |
| Payments | ❌ | ✅ |
| Support | ✅ | ✅ |
| Profile | ✅ | ✅ |

## 🔐 Security Notes

- Mobile app uses hardcoded OTP "123456" for demo purposes
- Web app accepts any credentials for demo purposes
- Production deployment should implement:
  - Real OTP service integration
  - Backend API authentication
  - Secure token storage
  - HTTPS/SSL certificates
  - Data encryption

## 📝 Development Notes

### For Non-Developers
Both applications are designed to work out-of-the-box with dummy data. The web app is instantly accessible via the provided URL. For the mobile app, download the APK from GitLab CI/CD artifacts.

### API Integration
Both apps are structured for easy API integration:
- Replace static data methods in models
- Update service layers with HTTP calls
- Add environment configuration
- Implement proper error handling

## 🤝 Contributing

This is a demo project. For production use, please implement:
- Real authentication backend
- Database integration
- API endpoints
- Security best practices
- Error tracking
- Analytics

## 📄 License

MIT License

## 📞 Support

For issues or questions:
- Check [DEPLOYMENT.md](DEPLOYMENT.md) for deployment help
- Review the Flutter README for mobile app details
- Check GitHub Issues for known problems

---

**Quick Links:**
- 🌐 [Live Web App](https://mohdmansoorak.github.io/Health-App)
- 📱 [Download APK](https://gitlab.com/mohdmansoorak/Health-App/-/pipelines) (GitLab artifacts)
- 📚 [Deployment Guide](DEPLOYMENT.md)
