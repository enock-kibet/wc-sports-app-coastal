import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';

import '../data/services/service.dart';

class AppPreferences {
  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();
  static const _keyThemeMode = 'theme_mode';
  static const _keySkippedLogin = 'skipped_login';

  /// Store data whether the app is running for the first time
  Future<void> storeFirstTimeRun(bool isFirstTime) async {
    await asyncPrefs.setBool("firstTimeRun", isFirstTime);
  }

  /// Get data whether the app is running for the first time
  Future<bool> getFirstTimeRun() async {
    return await asyncPrefs.getBool("firstTimeRun") ?? true;
  }

  Future<void> setSkippedLogin(bool skipped) async {
    await asyncPrefs.setBool(_keySkippedLogin, skipped);
  }

  Future<bool> getSkippedLogin() async {
    return await asyncPrefs.getBool(_keySkippedLogin) ?? false;
  }

  /// Store User data in shared preferences
  Future<void> storeUserData(User user) async {
    await asyncPrefs.setStringList("USERDATA", [
      user.name,
      user.email,
      user.picture ?? "",
      user.emailVerified.toString(),
      user.token ?? "",
      user.refreshToken ?? "",
      user.userID ?? "",
      user.phoneNumber ?? "",
      user.dateOfBirth ?? "",
    ]);
  }

  /// Get User data from shared preferences
  Future<User?> getUserData() async {
    final userData = await asyncPrefs.getStringList("USERDATA");
    User? user;
    try {
      user = User(
        name: userData![0],
        email: userData[1],
        picture: userData[2],
        emailVerified: (userData[3] == "true"),
        token: userData[4],
        refreshToken: userData[5],
        userID: userData[6],
        phoneNumber: userData[7],
        dateOfBirth: userData[8],
      );
    } catch (_) {
      user = null;
    }
    return user;
  }

  // get user from shared preferences and update token
  Future<User?> updateToken(String token) async {
    final userData = await asyncPrefs.getStringList("USERDATA");
    final prefs = await SharedPreferences.getInstance();
    User? user;
    try {
      if (userData != null && userData.length >= 5) {
        // Update only the token (index 4 in your current order)
        userData[4] = token ?? "";

        // Save back
        await asyncPrefs.setStringList("USERDATA", userData);
        // update prefs.getInt('token_expiry');
        setTokenExpiry(DateTime.now().millisecondsSinceEpoch +
            3600000); // Example: 1 hour from now
      }
    } catch (_) {
      user = null;
    }
    return user;
  }

  // update user data
  Future<User?> updateUser(User user) async {
    final userData = await asyncPrefs.getStringList("USERDATA");
    final userF = service<AppPreferencesManager>().currentUserValue!;
    try {
      if (userData != null && userData.length >= 5) {
        userData[0] = user.name;
        userData[1] = user.email;
        userData[2] = userF.picture ?? "";
        userData[7] = user.phoneNumber ?? "";
        userData[8] = user.dateOfBirth ?? "";

        await asyncPrefs.setStringList("USERDATA", userData);

        // print(userData);
      }
    } catch (e) {
      // print(e);
    }

    return user;
  }

  Future<String> updateUserPicture(String userPic) async {
    final userData = await asyncPrefs.getStringList("USERDATA");
    try {
      if (userData != null) {
        userData[2] = userPic;

        await asyncPrefs.setStringList("USERDATA", userData);

        // print(userData);
      }
    } catch (e) {
      // print(e);
    }

    return userPic;
  }

  ///Remove user from shared preferences
  Future<void> removeUser() async {
    await asyncPrefs.remove("USERDATA");
    // await asyncPrefs.remove("USER");
  }

  Future<void> setTokenExpiry(int expiryMillis) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('token_expiry', expiryMillis);
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeMode, mode.index);
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_keyThemeMode);
    if (index == null) return ThemeMode.system;
    return ThemeMode.values[index];
  }
}
