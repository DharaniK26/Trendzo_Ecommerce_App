import 'package:shared_preferences/shared_preferences.dart';

class AppSharedpref {
  static SharedPreferences? sharedpref;
  static initialize() async {
    if (sharedpref != null) {
      return sharedpref;
    } else {
      sharedpref = await SharedPreferences.getInstance();
    }
  }

  static bool getBool(String key) {
    return sharedpref?.getBool(key) ?? false;
  }

  static Future<void> setBool(String key, bool value) async {
    sharedpref?.setBool(key, value);
  }

  static Future<void> clearshareddata() async {
    await Future.wait([sharedpref!.remove(AppSharedkeys.userId)]);
  }

  // Generic helpers for String and String List
  static Future<void> setString(String key, String value) async {
    await sharedpref?.setString(key, value);
  }

  static String getString(String key) {
    return sharedpref?.getString(key) ?? '';
  }

  static Future<void> setStringList(String key, List<String> values) async {
    await sharedpref?.setStringList(key, values);
  }

  static List<String> getStringList(String key) {
    return sharedpref?.getStringList(key) ?? <String>[];
  }
}

class AppSharedkeys {
  static String userId = "userId";
  static String wishlist = "wishlist";
}
