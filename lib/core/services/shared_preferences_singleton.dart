// lib/core/services/shared_preferences_singleton.dart
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _instance;

  /// تهيئة SharedPreferences
  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  // ==========================================
  // Boolean Methods
  // ==========================================
  
  static Future<bool> setBool(String key, bool value) async {
    return await _instance.setBool(key, value);
  }

  static bool getBool(String key) {
    return _instance.getBool(key) ?? false;
  }

  // ==========================================
  // String Methods
  // ==========================================
  
  static Future<bool> setString(String key, String value) async {
    return await _instance.setString(key, value);
  }

  static String? getString(String key) {
    return _instance.getString(key);
  }

  // ==========================================
  // Int Methods
  // ==========================================
  
  static Future<bool> setInt(String key, int value) async {
    return await _instance.setInt(key, value);
  }

  static int? getInt(String key) {
    return _instance.getInt(key);
  }

  // ==========================================
  // Double Methods
  // ==========================================
  
  static Future<bool> setDouble(String key, double value) async {
    return await _instance.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _instance.getDouble(key);
  }

  // ==========================================
  // List Methods
  // ==========================================
  
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _instance.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return _instance.getStringList(key);
  }

  // ==========================================
  // Remove & Clear Methods
  // ==========================================
  
  static Future<bool> remove(String key) async {
    return await _instance.remove(key);
  }

  static Future<bool> clear() async {
    return await _instance.clear();
  }

  // ==========================================
  // Check Methods
  // ==========================================
  
  static bool containsKey(String key) {
    return _instance.containsKey(key);
  }

  static Set<String> getKeys() {
    return _instance.getKeys();
  }

  // ==========================================
  // Reload Method
  // ==========================================
  
  static Future<void> reload() async {
    await _instance.reload();
  }
}