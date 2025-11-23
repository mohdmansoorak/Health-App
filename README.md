# CareConnect Health

A comprehensive React Native mobile application for health insurance management, inspired by leading GCC insurance apps like Bupa Arabia. Built with modern technologies and best practices.

## 🎯 Features

### Authentication
- Mobile number / National ID login
- OTP verification
- PIN creation and management
- Secure authentication flow

### Core Features
- **Dashboard**: Quick access to all services, upcoming appointments, and recent claims
- **Digital e-Card**: Download and share your insurance card with QR code
- **Policy Management**: View policy details, coverage, and benefits
- **Approvals**: Track medical procedure approvals
- **Claims**: Submit and track insurance claims
- **Provider Search**: Find in-network hospitals and clinics
- **Appointment Booking**: Book, manage, and reschedule appointments
- **Telemedicine**: Instant GP consultations
- **Chronic Care Program**: Specialized programs for chronic conditions
- **Wellness Rewards**: Earn points through health challenges

### Technical Features
- ✅ TypeScript for type safety
- ✅ Redux Toolkit for state management
- ✅ React Navigation for routing
- ✅ Multilingual support (English + Arabic with RTL)
- ✅ Responsive design for all screen sizes
- ✅ Modern UI with healthcare theme
- ✅ Mock API services for development

## 📱 Tech Stack

- **Framework**: React Native 0.73
- **Language**: TypeScript
- **Navigation**: React Navigation 6
- **State Management**: Redux Toolkit
- **Internationalization**: i18next
- **Styling**: React Native StyleSheet with custom theme
- **HTTP Client**: Axios
- **Icons**: React Native Vector Icons

## 🚀 Getting Started

### Prerequisites

- Node.js >= 18
- npm or yarn
- React Native CLI
- Xcode (for iOS development)
- Android Studio (for Android development)

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd Health-App
```

2. Install dependencies:
```bash
npm install
```

3. Install iOS dependencies (macOS only):
```bash
cd ios && pod install && cd ..
```

### Running the App

#### Android
```bash
npm run android
```

#### iOS
```bash
npm run ios
```

#### Start Metro bundler
```bash
npm start
```

## 📁 Project Structure

```
src/
├── assets/              # Images, fonts, and other static assets
├── components/          # Reusable UI components
│   ├── Button.tsx
│   ├── Card.tsx
│   ├── Input.tsx
│   ├── QuickActionButton.tsx
│   └── Header.tsx
├── config/              # Configuration files
│   ├── theme.ts        # Theme colors, spacing, typography
│   └── i18n.ts         # Internationalization setup
├── navigation/          # Navigation structure
│   ├── RootNavigator.tsx
│   ├── AuthStack.tsx
│   ├── MainTabs.tsx
│   └── types.ts
├── screens/             # All app screens
│   ├── Auth/           # Authentication screens
│   ├── Dashboard/      # Home dashboard
│   ├── Policy/         # Policy and benefits
│   ├── Approvals/      # Medical approvals
│   ├── Claims/         # Claims management
│   ├── Providers/      # Provider search
│   ├── Appointments/   # Appointment booking
│   ├── Telemedicine/   # Instant consultations
│   ├── ChronicCare/    # Chronic care programs
│   ├── Wellness/       # Wellness rewards
│   ├── Notifications/  # Notifications center
│   └── Support/        # Help and support
├── services/           # API services and mock data
│   ├── api.ts
│   ├── authService.ts
│   └── mockData.ts
├── store/              # Redux store
│   ├── index.ts
│   └── slices/
│       ├── authSlice.ts
│       └── userSlice.ts
└── utils/              # Utility functions
    ├── responsive.ts
    └── rtl.ts
```

## 🎨 Theme Configuration

The app uses a healthcare-inspired color scheme:

- **Primary**: #0066CC (Blue)
- **Secondary**: #00A3A1 (Teal/Green)
- **Background**: #F8FAFC
- **Success**: #10B981
- **Error**: #DC2626
- **Warning**: #F59E0B

Customize theme in `src/config/theme.ts`

## 🌍 Internationalization

The app supports English and Arabic with RTL layout. To add translations:

1. Open `src/config/i18n.ts`
2. Add translations to the `resources` object
3. Use the `useTranslation` hook in components:

```tsx
import {useTranslation} from 'react-i18next';

const MyComponent = () => {
  const {t} = useTranslation();
  return <Text>{t('common.welcome')}</Text>;
};
```

## 🔧 Configuration

### API Base URL

Update the API base URL in `src/services/api.ts`:

```typescript
export const API_BASE_URL = 'https://your-api-url.com';
```

### Adding New Screens

1. Create screen file in appropriate directory under `src/screens/`
2. Add navigation type to `src/navigation/types.ts`
3. Register in relevant navigator (AuthStack, HomeStack, etc.)
4. Add route in navigator component

Example:
```tsx
// src/screens/NewFeature/NewScreen.tsx
import React from 'react';
import {View, Text} from 'react-native';

const NewScreen = () => {
  return (
    <View>
      <Text>New Screen</Text>
    </View>
  );
};

export default NewScreen;
```

## 🧪 Testing

```bash
npm test
```

## 📦 Building

### Android
```bash
cd android
./gradlew assembleRelease
```

### iOS
```bash
cd ios
xcodebuild -workspace CareConnectHealth.xcworkspace -scheme CareConnectHealth -configuration Release
```

## 🔄 GitLab CI/CD

The project includes a GitLab CI/CD pipeline (`.gitlab-ci.yml`) with the following stages:

1. **Install**: Install dependencies
2. **Lint**: Run ESLint and TypeScript checks
3. **Build**: Build Android and iOS apps
4. **Deploy**: Deploy to app stores (manual trigger)

### Pipeline Variables

Set these variables in GitLab CI/CD settings:
- `ANDROID_KEYSTORE_FILE`: Android signing keystore
- `ANDROID_KEYSTORE_PASSWORD`: Keystore password
- `IOS_CERTIFICATE`: iOS signing certificate

## 📱 Mock Data

The app includes comprehensive mock data for development and testing:

- User profiles
- Policy information
- Benefits and coverage
- Approvals
- Claims
- Appointments
- Providers
- Wellness challenges

Mock data is in `src/services/mockData.ts`

## 🔐 Authentication Flow

1. User enters mobile number or National ID
2. OTP is sent (use `1234` for testing)
3. User verifies OTP
4. Optional: Create PIN for quick access
5. User is authenticated and navigates to main app

## 🎯 Future Enhancements

- Real-time notifications
- Biometric authentication
- Dark mode support
- Offline mode with data sync
- In-app chat support
- Health tracking integration
- Document scanner for claims
- Video consultations

## 📝 License

This project is licensed under the MIT License.

## 👥 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

For support, please contact [support@careconnect.health](mailto:support@careconnect.health)

## 🙏 Acknowledgments

- Inspired by Bupa Arabia and other leading GCC health insurance apps
- Built with React Native and modern best practices
- Designed for healthcare accessibility and user experience

---

**Made with ❤️ for better healthcare access**
