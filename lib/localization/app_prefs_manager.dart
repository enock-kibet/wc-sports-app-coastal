import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/localization/app_prefs.dart';

enum AuthenticationStatus { notAuthenticated, notVerified, verified, firstTime }

class AppPreferencesManager {
  static final AppPreferencesManager _instance = AppPreferencesManager._internal();

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

    _status = firstTimerun? AuthenticationStatus.firstTime: _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Stream<AuthenticationStatus> get stream async* {
    yield _status;
    yield* _controller.stream.asBroadcastStream();
  }

  AuthenticationStatus _verificationStatus(User? user){
    if(user == null){return AuthenticationStatus.notAuthenticated;}
    if(!user.emailVerified){return AuthenticationStatus.notVerified;}
    return AuthenticationStatus.verified;
  }

  // Synchronous access
  User? get currentUserValue => _currentUser;
  AuthenticationStatus get currentAuthStateValue => _status;



  // Save a value and update the cache
  Future<void> saveValue(User user) async{
    await _prefs.storeUserData(user);
    _currentUser = await _prefs.getUserData();// Update the cache
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }
  Future<void> clearFirstTime()async{
    await _prefs.storeFirstTimeRun(false);
    _currentUser = await _prefs.getUserData();
    _status = _verificationStatus(_currentUser);
    _controller.add(_status);
  }

  Future<void> logOut()async{
    final GoogleSignInAccount? googleSignIn =await GoogleSignIn(scopes: ['profile', 'email']).signOut();
    await _prefs.removeUser();
    _currentUser = await _prefs.getUserData();
    _status=_verificationStatus(_currentUser);
    _controller.add(_status);
  }
}
