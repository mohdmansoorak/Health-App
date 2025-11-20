import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages app language and text direction (LTR/RTL)
/// Supports Arabic (RTL) and English (LTR)
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  static const String _localeKey = 'app_locale';

  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';
  bool get isEnglish => _locale.languageCode == 'en';

  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  LocaleProvider() {
    _loadLocale();
  }

  /// Load saved locale from storage
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
      notifyListeners();
    }
  }

  /// Set locale to Arabic (RTL)
  Future<void> setArabic() async {
    await setLocale(const Locale('ar'));
  }

  /// Set locale to English (LTR)
  Future<void> setEnglish() async {
    await setLocale(const Locale('en'));
  }

  /// Toggle between Arabic and English
  Future<void> toggleLocale() async {
    if (isArabic) {
      await setEnglish();
    } else {
      await setArabic();
    }
  }

  /// Set specific locale
  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;

    _locale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, newLocale.languageCode);
    notifyListeners();
  }

  /// Get localized string key for current language
  String getLocalizedKey(String enKey, String arKey) {
    return isArabic ? arKey : enKey;
  }
}
