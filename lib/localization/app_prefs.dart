
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  /// Store Auth data in shared preferences
  Future<void> storeAuthData(String data) async {
    await SharedPreferences.getInstance().then(
      (value) => value.setString("USER", data),
    );
  }

  /// Get Auth data from shared preferences
  Future<String?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("USER");
    if (data != null) {
      return data;
    }
    return null;
  }

  ///Remove user from shared preferences
  Future<bool?> removeUser() async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.remove("USER");
  }
}
