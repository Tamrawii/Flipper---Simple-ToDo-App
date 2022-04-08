import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences preferences;

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static storeValue(value) async {
    preferences.setBool('isDark', value);
  }

  static bool? isDark = false;

  static bool? getValue({
    required String key,
  }) {
    isDark = preferences.getBool(key);
    return isDark;
  }
}
