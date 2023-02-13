import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static late SharedPreferences _preferences;
  static const tokenKey = 'token';
  static const companyNameKey = 'company_name';
  static const expiryTimeKey = 'expiresIn';

  static Future init() async=>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserToken(String token) async =>
      await _preferences.setString(tokenKey, token);

  static String? getUserToken() => _preferences.getString(tokenKey);


  static Future setCompanyName(String conpanyName) async =>
      await _preferences.setString(companyNameKey, conpanyName);

  static String? getCompanyName() => _preferences.getString(companyNameKey);


  static Future setExpiryTime(String expiryDate) async =>
      await _preferences.setString(expiryTimeKey, expiryDate);

  static String? getExpiryTime() => _preferences.getString(expiryTimeKey);




  static void clearAllPreferences() {
    _preferences.clear();
  }


}