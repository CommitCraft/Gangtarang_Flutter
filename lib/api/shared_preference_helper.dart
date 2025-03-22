import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static final SharedPreferenceHelper _instance = SharedPreferenceHelper._internal();
  late SharedPreferences _prefs;

  factory SharedPreferenceHelper() {
    return _instance;
  }

  SharedPreferenceHelper._internal() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a String value
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get a String value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Remove a value
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
