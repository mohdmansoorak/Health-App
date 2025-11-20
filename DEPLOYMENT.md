# 🚀 Deployment Guide

This document explains all deployment options for the Insurance App.

## 📱 Available Platforms

Your app can be deployed to:
1. **Web** (Browser - Desktop/Mobile)
2. **Android** (Mobile APK)
3. **iOS** (Mobile App - requires Mac)

---

## 🌐 Web Deployment (GitHub Pages)

### Status: ✅ AUTOMATED

The web version deploys **automatically** when you push to the `main` branch.

### How It Works:
1. You push code to GitHub (main branch)
2. GitHub Actions builds the Flutter web app
3. Automatically deploys to GitHub Pages
4. Available at: **https://mohdmansoorak.github.io/Health-App**

### Manual Trigger:
1. Go to: https://github.com/mohdmansoorak/Health-App/actions
2. Click "Deploy Flutter Web to GitHub Pages"
3. Click "Run workflow"
4. Select branch: `main`
5. Click "Run workflow"

### Access Your Web App:
🔗 **https://mohdmansoorak.github.io/Health-App**

Works on:
- ✅ Desktop browsers (Chrome, Firefox, Safari, Edge)
- ✅ Mobile browsers (iPhone, Android)
- ✅ Tablets
- ✅ Any device with a browser!

---

## 📱 Android Deployment (GitLab CI/CD)

### Status: ✅ AUTOMATED

Android builds happen **automatically** on GitLab when you push code.

### How It Works:
1. Push code to GitLab repository
2. GitLab CI/CD builds:
   - **APK** (for direct installation)
   - **App Bundle** (for Google Play Store)
3. Downloads available in Artifacts

### Download APK:

#### Option A: From GitLab UI
1. Go to your GitLab repository
2. Navigate to: **CI/CD → Pipelines**
3. Click on the latest successful pipeline (green checkmark ✓)
4. Click on **build_android_apk** job
5. On the right side, click **Browse** under "Job artifacts"
6. Download `app-release.apk`
7. Install on your Android phone!

#### Option B: Direct Download
1. Go to: **CI/CD → Pipelines**
2. Click the download icon on the right side of the pipeline
3. Select **build_android_apk**
4. APK downloads automatically

### Install APK on Phone:
1. Transfer APK to your Android phone
2. Open the APK file
3. Allow "Install from Unknown Sources" if prompted
4. Install and enjoy!

---

## 🍎 iOS Deployment

### Requirements:
- Mac computer with Xcode
- Apple Developer Account ($99/year)
- iOS device for testing

### Build Locally:
```bash
flutter build ios --release
```

### Deploy to App Store:
1. Open `ios/Runner.xcworkspace` in Xcode
2. Configure signing with your Apple Developer account
3. Archive and upload to App Store Connect
4. Submit for review

**Note:** iOS deployment requires a Mac and cannot be automated without one.

---

## 🔄 Deployment Status

### Current Setup:

| Platform | Method | Status | Access |
|----------|--------|--------|--------|
| **Web** | GitHub Actions | ✅ Auto | https://mohdmansoorak.github.io/Health-App |
| **Android APK** | GitLab CI/CD | ✅ Auto | Download from GitLab artifacts |
| **Android Bundle** | GitLab CI/CD | ✅ Auto | Download from GitLab artifacts |
| **iOS** | Manual | ⏸️ Requires Mac | N/A |

---

## 🛠️ Manual Build Instructions

If you want to build locally:

### Web:
```bash
flutter build web --release
# Output: build/web/
```

### Android APK:
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android Bundle:
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS:
```bash
flutter build ios --release
# Requires Mac with Xcode
```

---

## 📊 Build Information

### Latest Builds:

Check latest builds here:
- **GitHub (Web)**: https://github.com/mohdmansoorak/Health-App/actions
- **GitLab (Mobile)**: [Your GitLab URL]/pipelines

### Build Artifacts Available:

**From GitHub Actions:**
- ✅ Flutter Web Build (deployed automatically)

**From GitLab CI/CD:**
- ✅ Android APK (insurance-app-android-XXXXXX.apk)
- ✅ Android Bundle (insurance-app-bundle-XXXXXX.aab)
- ✅ Web Build (insurance-app-web-XXXXXX)

All artifacts are kept for **30 days** after build.

---

## 🎯 Quick Access

### For Users (No Technical Knowledge):

**Web App:**
Just visit: https://mohdmansoorak.github.io/Health-App

**Mobile App:**
Ask your developer to:
1. Go to GitLab → CI/CD → Pipelines
2. Download the APK
3. Send it to you
4. Install on your phone

### For Developers:

**Trigger New Build:**
```bash
git add .
git commit -m "Your changes"
git push origin main
```

Both GitHub and GitLab will build automatically!

---

## 🔐 Production Deployment Checklist

Before deploying to production (real users), make sure to:

- [ ] Replace dummy data with real API calls
- [ ] Implement real OTP system (not hardcoded 123456)
- [ ] Add proper error handling for API failures
- [ ] Set up analytics and crash reporting
- [ ] Configure proper app signing for Android
- [ ] Test on multiple devices
- [ ] Set up backend API endpoints
- [ ] Configure proper authentication tokens
- [ ] Add privacy policy and terms of service
- [ ] Test payment integration (if applicable)
- [ ] Set up proper logging
- [ ] Configure push notifications (if needed)

---

## 🆘 Troubleshooting Deployments

### GitHub Pages Not Updating:
1. Go to: Settings → Pages
2. Ensure Source is set to "GitHub Actions"
3. Check Actions tab for build errors
4. Re-run the workflow if needed

### GitLab Build Failed:
1. Go to CI/CD → Pipelines
2. Click the failed pipeline
3. Check the error logs
4. Common fixes:
   - Run `flutter clean` and rebuild
   - Check pubspec.yaml for errors
   - Ensure all dependencies are compatible

### APK Not Installing:
1. Enable "Install from Unknown Sources" on Android
2. Make sure APK is not corrupted during download
3. Check Android version compatibility (minimum API 21/Android 5.0)

---

## 📞 Support

For deployment issues:
- Check build logs on GitHub Actions or GitLab CI/CD
- Review error messages carefully
- Ensure all dependencies are up to date
- Try rebuilding after `flutter clean`

---

**Last Updated:** November 2024

**Deployment Status:** ✅ Fully Automated for Web & Android
