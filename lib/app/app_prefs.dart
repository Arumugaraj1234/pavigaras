import 'package:pavigaras/app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserId(int userId) async {
    _sharedPreferences.setInt(AppConstants.prefsKeyUserId, userId);
  }

  Future<int> userId() async {
    return _sharedPreferences.getInt(AppConstants.prefsKeyUserId) ?? 0;
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(AppConstants.prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(AppConstants.prefsKeyIsUserLoggedIn) ??
        false;
  }

  Future<void> setUserName(String name) async {
    _sharedPreferences.setString(AppConstants.prefsKeyUserName, name);
  }

  Future<String> userName() async {
    return _sharedPreferences.getString(AppConstants.prefsKeyUserName) ??
        AppConstants.emptyString;
  }
}
