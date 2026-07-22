import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveLogin() async {
    final prefs = await _prefs();
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> logout() async {
    final prefs = await _prefs();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _prefs();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}