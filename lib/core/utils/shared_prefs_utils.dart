import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static SharedPreferences? _prefs;

  // Keys
  static const String languageCodeKey = 'language_code';
  static const String deliveryNoKey = 'delivery_no';
  static const String passwordKey = 'password';
  static const String userNameKey = 'user_name';
  static const String isFirstRunKey = 'is_first_run';

  // Init
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Language methods
  static Future<bool> setLanguageCode(String code) async {
    return await _prefs?.setString(languageCodeKey, code) ?? false;
  }

  static String getLanguageCode() {
    return _prefs?.getString(languageCodeKey) ?? 'en';
  }

  // Helper method to get the full locale
  static Locale getLocale() {
    final String languageCode = getLanguageCode();
    final String countryCode = languageCode == 'ar' ? 'EG' : 'US';
    return Locale(languageCode, countryCode);
  }

  // User data methods
  static Future<bool> saveUserData({
    required String deliveryNo,
    required String password,
    String? userName,
  }) async {
    await _prefs?.setString(deliveryNoKey, deliveryNo);
    await _prefs?.setString(passwordKey, password);
    if (userName != null) {
      await _prefs?.setString(userNameKey, userName);
    }
    return true;
  }

  static Future<void> clearUserData() async {
    await _prefs?.remove(deliveryNoKey);
    await _prefs?.remove(passwordKey);
    await _prefs?.remove(userNameKey);
  }

  static String? getDeliveryNo() {
    return _prefs?.getString(deliveryNoKey);
  }

  static String? getUserName() {
    return _prefs?.getString(userNameKey);
  }

  static String? getDeliveryName() {
    return _prefs?.getString(userNameKey);
  }

  // First run check
  static Future<bool> setFirstRun(bool isFirstRun) async {
    return await _prefs?.setBool(isFirstRunKey, isFirstRun) ?? false;
  }

  static bool isFirstRun() {
    return _prefs?.getBool(isFirstRunKey) ?? true;
  }
}
