import 'dart:async';

import 'package:sports_app/localization/app_prefs.dart';

import '../services/service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository._();
  static AuthenticationRepository instance = AuthenticationRepository._();
  final _controller = StreamController<AuthenticationStatus>.broadcast();
  final _prefs = service<AppPreferences>();

  AuthenticationStatus _status = AuthenticationStatus.unknown;
  String? authToken;

  Stream<AuthenticationStatus> get stream async* {
    yield _status;
    yield* _controller.stream.asBroadcastStream();
  }

  AuthenticationStatus get status => _status;

  Future<void> login() async {
    _status = AuthenticationStatus.authenticated;
    _controller.add(_status);
  }

  _clearInfo() async {
    _prefs.removeUser();
  }

  void logout() async {
    await _clearInfo();
    authToken = null;
    _status = AuthenticationStatus.unauthenticated;

    _controller.add(_status);
  }
}
