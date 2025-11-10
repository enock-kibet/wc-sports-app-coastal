import 'dart:async';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/localization/app_prefs.dart';

enum AuthenticationStatus { notAuthenticated, notVerified, verified, firstTime }

class AppPreferencesManager {
  static final AppPreferencesManager _instance =
      AppPreferencesManager._internal();

  factory AppPreferencesManager() {
    return _instance;
  }

  AppPreferencesManager._internal();

  final _controller = StreamController<AuthenticationStatus>.broadcast();

  late AppPreferences _prefs;

  // Example cached data
  late User? _currentUser;
  late AuthenticationStatus _status;

  Future<void> init() async {
    bool firstTimerun;
    _prefs = AppPreferences();
    firstTimerun = await _prefs.getFirstTimeRun();

    // Load and cache data from SharedPreferences
    _currentUser = await _prefs.getUserData();

    _status = firstTimerun
        ? AuthenticationStatus.firstTime
        : _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Stream<AuthenticationStatus> get stream async* {
    yield _status;
    yield* _controller.stream.asBroadcastStream();
  }

  AuthenticationStatus _verificationStatus(User? user) {
    if (user == null) {
      return AuthenticationStatus.notAuthenticated;
    }
    if (!user.emailVerified) {
      return AuthenticationStatus.notVerified;
    }
    return AuthenticationStatus.verified;
  }

  // Synchronous access
  User? get currentUserValue => _currentUser;
  AuthenticationStatus get currentAuthStateValue => _status;

  // Save a value and update the cache
  Future<void> saveValue(User user) async {
    await _prefs.storeUserData(user);

    // Decode JWT expiry (if token exists)
    if (user.token != null && user.token!.isNotEmpty) {
      try {
        final expiryMillis = _decodeJwtExpiry(user.token!);
        await _prefs.setTokenExpiry(expiryMillis);
      } catch (e) {
        // Optionally log decoding error
        print("Failed to decode token expiry: $e");
      }
    }

    _currentUser = await _prefs.getUserData(); // Update the cache
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Future<User?> updateUser(User user) async {
    await _prefs.updateUser(user);

    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Future<User?> updateUserPhoto(String photo) async {
    await _prefs.updateUserPicture(photo);

    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  // get user data

  // update user data token only
  Future<void> updateUserToken(String token) async {
    if (_currentUser != null) {
      await _prefs.updateToken(token);
      _status = _verificationStatus(_currentUser);
      _controller.add(_status);
    }
  }

  Future<void> clearFirstTime() async {
    await _prefs.storeFirstTimeRun(false);
    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Future<void> logOut() async {
    final GoogleSignInAccount? googleSignIn =
        await GoogleSignIn(scopes: ['profile', 'email']).signOut();
    await _prefs.removeUser();
    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  int _decodeJwtExpiry(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid JWT format');
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final Map<String, dynamic> payloadMap = jsonDecode(payload);
    return payloadMap['exp'] * 1000; // Convert to milliseconds
  }

  Future<void> setTokenExpiry(int expiryMillis) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('token_expiry', expiryMillis);
  }

  Future<int?> getTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('token_expiry');
  }

  Future<void> removeTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token_expiry');
  }
}
