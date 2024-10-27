import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/data/models/user/user.dart';

class AppPreferences {
  /// Store Auth data in shared preferences
  Future<void> storeAuthData(User data) async {
    await SharedPreferences.getInstance().then(
      (value) => value.setString("USER", jsonEncode(data.toJson())),
    );
  }

  /// Get Auth data from shared preferences
  Future<User?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("USER");
    if (data != null) {
      return User.fromJson(jsonDecode(data));
    }
    return null;
  }

  ///Remove user from shared preferences
  Future<bool?> removeUser() async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.remove("USER");
  }
}
