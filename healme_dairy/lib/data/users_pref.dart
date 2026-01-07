
import 'package:shared_preferences/shared_preferences.dart';

class UsersPref {
  static const _keyUserName  = 'user_name';

 static Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }
  
}