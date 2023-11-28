import 'package:shared_preferences/shared_preferences.dart';

 class UserPreferences {
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', userId);
  }
}