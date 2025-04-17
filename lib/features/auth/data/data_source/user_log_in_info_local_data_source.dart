import 'package:logiology/core/errors/exceptions.dart';
import 'package:logiology/core/user_info/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLogInInfoLocalDataSource {
  Future<void> getUserData();
  Future<void> setUserData(
    final String? dP,
    final String? name,
    final String? password,
    final bool? loginStatus,
  );
}

class UserLogInInfoLocalDataSourceImpl implements UserLogInInfoLocalDataSource {
  final SharedPreferences prefs;

  static const _keyDP = 'user_DP';
  static const _keyName = 'user_name';
  static const _keyPassword = 'user_password';
  static const _loginStatus = 'login_status';

  UserLogInInfoLocalDataSourceImpl(this.prefs);

  @override
  getUserData() async {
    try {
      final photo = prefs.getString(_keyDP);
      final name = prefs.getString(_keyName);
      final password = prefs.getString(_keyPassword);
      final loginStatus = prefs.getBool(_loginStatus);

      UserInfo.dP = photo ?? '';
      UserInfo.name = name ?? 'admin';
      UserInfo.paswword = password ?? 'Pass@123.';
      UserInfo.loginStatus = loginStatus ?? false;
    } catch (e) {
      throw DatabaseException(
        'Error getting user data: $e',
      );
    }
  }

  @override
  Future<void> setUserData(
      String? dP, String? name, String? password, bool? loginStatus) async {
    try {
      if (dP != null) {
        await prefs.setString(_keyDP, dP);
        UserInfo.dP = dP;
      }
      if (name != null) {
        await prefs.setString(_keyName, name);
        UserInfo.name = name;
      }
      if (password != null) {
        await prefs.setString(_keyPassword, password);
        UserInfo.paswword = password;
      }

      if (loginStatus != null) {
        await prefs.setBool(_loginStatus, loginStatus);
        UserInfo.loginStatus = loginStatus;
      }
    } catch (e) {
      throw DatabaseException(
        'Error setting user data: $e',
      );
    }
  }
}
