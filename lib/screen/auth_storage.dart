import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {

  // SAVE USER (SIGN UP)
  static Future<void> saveUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", email);
    await prefs.setString("password", password);
    await prefs.setString("firstName", firstName);
    await prefs.setString("lastName", lastName);
  }

  // GET USER
  static Future<Map<String, String>> getUser() async {

    final prefs = await SharedPreferences.getInstance();

    return {
      "email": prefs.getString("email") ?? "",
      "password": prefs.getString("password") ?? "",
      "firstName": prefs.getString("firstName") ?? "",
      "lastName": prefs.getString("lastName") ?? "",
    };
  }

  // ✅ REMEMBER LOGIN INPUT (AUTO-FILL ONLY)
  static Future<void> setRememberLogin({
    required String email,
    required String password,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("remember_email", email);
    await prefs.setString("remember_password", password);
  }

  // GET REMEMBERED LOGIN
  static Future<Map<String, String>> getRememberLogin() async {

    final prefs = await SharedPreferences.getInstance();

    return {
      "email": prefs.getString("remember_email") ?? "",
      "password": prefs.getString("remember_password") ?? "",
    };
  }

  // UPDATE PASSWORD
  static Future<void> updatePassword(String newPassword) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("password", newPassword);
  }

  // REMEMBER FLAG (OPTION ONLY)
  static Future<void> setRemember(bool value) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("remember", value);
  }

  static Future<bool> getRemember() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("remember") ?? false;
  }

  // LOGOUT (ONLY REMOVE FLAG)
  static Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("remember", false);
  }

  // CHECK USER EXISTS
  static Future<bool> userExists() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey("email") &&
        prefs.containsKey("password");
  }
}