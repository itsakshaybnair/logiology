
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyDP = 'user_DP';
  static const _keyName = 'user_name';
  static const _keyPassword = 'user_password';
   static const _loginStatus = 'login_status';


 

  static Future<void> setUserName({
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyName, name);

  }

  static Future<void> setUserPassword({
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyPassword, password);
  }


  static Future<void> setLoginStatus({
    required bool isLoggedIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_loginStatus, isLoggedIn);
  }


  static Future<void> setUserDP({
    required String dP,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyDP, dP);
  }

  static Future getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final photo = prefs.getString(_keyDP);
    final name = prefs.getString(_keyName);
    final password = prefs.getString(_keyPassword);
     final loginStatus = prefs.getBool(_loginStatus);

    UserInfo.dP = photo ?? '';
    UserInfo.name = name ?? 'admin';
    UserInfo.paswword = password ?? 'Pass@123';
    UserInfo.loginStatus = loginStatus ?? false;

  }

 
}

class UserInfo {
  static String dP = '';
  static String name = '';
  static String paswword = '';
  static bool loginStatus = false;
}
