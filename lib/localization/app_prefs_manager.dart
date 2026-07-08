import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/data/models/session/auth_session.dart';
import 'package:sports_app/data/models/session/frontend_context.dart';
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
  FrontendContextData? _currentContext;
  late AuthenticationStatus _status;
  bool _hasSkippedLogin = false;

  Future<void> init() async {
    bool firstTimerun;
    _prefs = AppPreferences();
    firstTimerun = await _prefs.getFirstTimeRun();
    _hasSkippedLogin = await _prefs.getSkippedLogin();

    // Load and cache data from SharedPreferences
    _currentUser = await _prefs.getUserData();
    _currentContext = await _prefs.getFrontendContext();

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
  FrontendContextData? get currentContextValue => _currentContext;
  AuthenticationStatus get currentAuthStateValue => _status;
  bool get hasSkippedLogin => _hasSkippedLogin;

  // Save a value and update the cache
  Future<void> saveValue(User user) async {
    await _prefs.storeUserData(user);
    await _prefs.storeFirstTimeRun(false);
    await _prefs.setSkippedLogin(false);

    // Decode JWT expiry (if token exists)
    if (user.token != null && user.token!.isNotEmpty) {
      try {
        final expiryMillis = _decodeJwtExpiry(user.token!);
        await _prefs.setTokenExpiry(expiryMillis);
      } catch (e) {
        // Optionally log decoding error
        debugPrint("Failed to decode token expiry: $e");
      }
    }

    _currentUser = await _prefs.getUserData(); // Update the cache
    _hasSkippedLogin = await _prefs.getSkippedLogin();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Future<void> saveSession(AuthenticatedUserPayload payload) async {
    await saveValue(payload.user);
    if (payload.context != null) {
      await saveFrontendContext(payload.context!);
    }
  }

  Future<void> saveFrontendContext(FrontendContextData context) async {
    await _prefs.storeFrontendContext(context);
    _currentContext = await _prefs.getFrontendContext();
    _controller.add(_status);
  }

  Future<User?> updateUser(User user) async {
    await _prefs.updateUser(user);

    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
    return _currentUser;
  }

  Future<User?> updateUserPhoto(String photo) async {
    await _prefs.updateUserPicture(photo);

    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
    return _currentUser;
  }

  // get user data

  // update user data token only
  Future<void> updateUserToken(String token) async {
    if (_currentUser != null) {
      await _prefs.updateToken(token);
      _currentUser = await _prefs.getUserData();
      _status = _verificationStatus(_currentUser);
      _controller.add(_status);
    }
  }

  Future<void> updateUserTokens(RefreshTokenPayload payload) async {
    if (_currentUser != null) {
      int? expiryMillis;
      if (payload.expiresIn != null) {
        expiryMillis = DateTime.now().millisecondsSinceEpoch +
            (payload.expiresIn! * 1000);
      } else {
        try {
          expiryMillis = _decodeJwtExpiry(payload.accessToken);
        } catch (_) {
          expiryMillis = null;
        }
      }

      await _prefs.updateTokens(
        accessToken: payload.accessToken,
        refreshToken: payload.refreshToken,
        expiryMillis: expiryMillis,
      );
      _currentUser = await _prefs.getUserData();
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

  Future<void> setSkippedLogin(bool skipped) async {
    await _prefs.setSkippedLogin(skipped);
    if (skipped) {
      await _prefs.storeFirstTimeRun(false);
    }
    _hasSkippedLogin = await _prefs.getSkippedLogin();
    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Future<void> logOut() async {
    await GoogleSignIn(scopes: ['profile', 'email']).signOut();
    await _prefs.removeUser();
    await removeTokenExpiry();
    _currentUser = await _prefs.getUserData();
    _currentContext = await _prefs.getFrontendContext();
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
