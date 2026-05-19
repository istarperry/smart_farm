import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _email = "email";
  static const _password = "password";
  static const _firstName = "firstName";
  static const _lastName = "lastName";
  static const _remember = "remember";

  // SAVE USER
  static Future<void> saveUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_email, email);
    await prefs.setString(_password, password);
    await prefs.setString(_firstName, firstName);
    await prefs.setString(_lastName, lastName);
  }

  // GET USER
  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "email": prefs.getString(_email) ?? "",
      "password": prefs.getString(_password) ?? "",
      "firstName": prefs.getString(_firstName) ?? "",
      "lastName": prefs.getString(_lastName) ?? "",
    };
  }

  // UPDATE PASSWORD
  static Future<void> updatePassword(String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_password, newPassword);
  }

  // REMEMBER ME CONTROL
  static Future<void> setRemember(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_remember, value);
  }

  static Future<bool> getRemember() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_remember) ?? false;
  }
}
