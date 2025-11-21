import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_insurance_app/core/providers/locale_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocaleProvider Tests', () {
    late LocaleProvider localeProvider;

    setUp(() async {
      // Clear shared preferences before each test
      SharedPreferences.setMockInitialValues({});
      localeProvider = LocaleProvider();
      // Wait for initialization to complete
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      localeProvider.dispose();
    });

    group('Initialization', () {
      test('should initialize with English locale by default', () {
        expect(localeProvider.locale.languageCode, equals('en'));
        expect(localeProvider.isEnglish, isTrue);
        expect(localeProvider.isArabic, isFalse);
      });

      test('should restore saved locale from storage', () async {
        // Setup - create provider with Arabic locale saved
        SharedPreferences.setMockInitialValues({
          'app_locale': 'ar',
        });

        final provider = LocaleProvider();
        await Future.delayed(const Duration(milliseconds: 100));

        expect(provider.locale.languageCode, equals('ar'));
        expect(provider.isArabic, isTrue);
        expect(provider.isEnglish, isFalse);

        provider.dispose();
      });
    });

    group('Text Direction', () {
      test('should return LTR for English', () {
        expect(localeProvider.textDirection, equals(TextDirection.ltr));
      });

      test('should return RTL for Arabic', () async {
        await localeProvider.setArabic();
        expect(localeProvider.textDirection, equals(TextDirection.rtl));
      });
    });

    group('Locale Switching', () {
      test('setArabic should change locale to Arabic', () async {
        await localeProvider.setArabic();

        expect(localeProvider.locale.languageCode, equals('ar'));
        expect(localeProvider.isArabic, isTrue);
        expect(localeProvider.isEnglish, isFalse);
      });

      test('setEnglish should change locale to English', () async {
        await localeProvider.setArabic();
        await localeProvider.setEnglish();

        expect(localeProvider.locale.languageCode, equals('en'));
        expect(localeProvider.isEnglish, isTrue);
        expect(localeProvider.isArabic, isFalse);
      });

      test('setLocale should change to specific locale', () async {
        await localeProvider.setLocale(const Locale('ar'));

        expect(localeProvider.locale.languageCode, equals('ar'));
      });

      test('setLocale should not change if locale is same', () async {
        var changeCount = 0;
        localeProvider.addListener(() {
          changeCount++;
        });

        await localeProvider.setLocale(const Locale('en'));

        expect(changeCount, equals(0)); // No change since already English
      });

      test('setLocale should persist to storage', () async {
        await localeProvider.setArabic();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('app_locale'), equals('ar'));
      });
    });

    group('Toggle Locale', () {
      test('toggleLocale should switch from English to Arabic', () async {
        expect(localeProvider.isEnglish, isTrue);

        await localeProvider.toggleLocale();

        expect(localeProvider.isArabic, isTrue);
        expect(localeProvider.isEnglish, isFalse);
      });

      test('toggleLocale should switch from Arabic to English', () async {
        await localeProvider.setArabic();
        expect(localeProvider.isArabic, isTrue);

        await localeProvider.toggleLocale();

        expect(localeProvider.isEnglish, isTrue);
        expect(localeProvider.isArabic, isFalse);
      });

      test('toggleLocale should work multiple times', () async {
        await localeProvider.toggleLocale(); // to Arabic
        expect(localeProvider.isArabic, isTrue);

        await localeProvider.toggleLocale(); // back to English
        expect(localeProvider.isEnglish, isTrue);

        await localeProvider.toggleLocale(); // to Arabic again
        expect(localeProvider.isArabic, isTrue);
      });
    });

    group('Localized Keys', () {
      test('getLocalizedKey should return English key when locale is English', () {
        final key = localeProvider.getLocalizedKey('hello', 'مرحبا');
        expect(key, equals('hello'));
      });

      test('getLocalizedKey should return Arabic key when locale is Arabic', () async {
        await localeProvider.setArabic();
        final key = localeProvider.getLocalizedKey('hello', 'مرحبا');
        expect(key, equals('مرحبا'));
      });

      test('getLocalizedKey should handle empty strings', () {
        final key = localeProvider.getLocalizedKey('', '');
        expect(key, equals(''));
      });
    });

    group('State Management', () {
      test('should notify listeners on locale change', () async {
        var notified = false;
        localeProvider.addListener(() {
          notified = true;
        });

        await localeProvider.setArabic();

        expect(notified, isTrue);
      });

      test('should notify listeners on toggle', () async {
        var notifyCount = 0;
        localeProvider.addListener(() {
          notifyCount++;
        });

        await localeProvider.toggleLocale();

        expect(notifyCount, greaterThan(0));
      });
    });

    group('Persistence', () {
      test('should persist locale across provider instances', () async {
        await localeProvider.setArabic();

        // Create new provider instance
        final newProvider = LocaleProvider();
        await Future.delayed(const Duration(milliseconds: 100));

        expect(newProvider.locale.languageCode, equals('ar'));
        expect(newProvider.isArabic, isTrue);

        newProvider.dispose();
      });

      test('should persist after toggle', () async {
        await localeProvider.toggleLocale();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('app_locale'), equals('ar'));
      });
    });

    group('Edge Cases', () {
      test('should handle multiple setArabic calls', () async {
        await localeProvider.setArabic();
        await localeProvider.setArabic();
        await localeProvider.setArabic();

        expect(localeProvider.isArabic, isTrue);
      });

      test('should handle rapid locale switching', () async {
        await localeProvider.setArabic();
        await localeProvider.setEnglish();
        await localeProvider.setArabic();
        await localeProvider.setEnglish();

        expect(localeProvider.isEnglish, isTrue);
      });

      test('should handle custom locale codes', () async {
        await localeProvider.setLocale(const Locale('fr'));

        expect(localeProvider.locale.languageCode, equals('fr'));
        expect(localeProvider.isArabic, isFalse);
        expect(localeProvider.isEnglish, isFalse);
      });
    });
  });
}
