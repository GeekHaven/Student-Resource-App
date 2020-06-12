import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<bool> getBooleanValue(String keyParam) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(keyParam) ?? false;
  }

  static Future<bool> setBooleanValue(String keyParam, bool valueParam) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.setBool(keyParam, valueParam);
  }

  static Future<String> getStringValue(String keyParam) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(keyParam ?? '');
  }

  static Future<bool> setStringValue(String keyParam, Object valueParam) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.setString(keyParam, json.encode(valueParam));
  }

  static clearPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
