import 'package:shared_preferences/shared_preferences.dart';


class SharePreferenceUtils {

  static void saveInt(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, val);
  }

  static void saveString(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, val);
  }

  static void remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static void saveBool(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, val);
  }

  static Future<int> getInt(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<String> getString(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> getBool(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

}