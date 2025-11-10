import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesManager {
  final SharedPreferences prefs;

  AppPreferencesManager(this.prefs);

  Future<void> saveTokenExpiry(int expiryMillis) async {
    await prefs.setInt('token_expiry', expiryMillis);
  }

  int? getTokenExpiry() {
    return prefs.getInt('token_expiry');
  }
}