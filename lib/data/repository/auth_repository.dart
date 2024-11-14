


import 'package:sports_app/router/router.dart';

import '../../localization/app_prefs.dart';
import '../services/service.dart';

class AuthRepository {
  static AuthRepository instance = AuthRepository();
  String? authUser;
  final _prefs = service<AppPreferences>();

  Future<void> login(String user) async {
    authUser = user;
    await _prefs.storeAuthData(user);
  }

  _clearInfo() async {
    await _prefs.removeUser();
  }

  void logout() async {
    _clearInfo();
    authUser = null;
    rootNavigatorKey.currentState!.pushReplacementNamed(AppRoute.home.name);
  }

  Future load() async {
    authUser = await _prefs.getAuthData();
    if (authUser == null) {
      return false;
    }
    return true;
  }
}
