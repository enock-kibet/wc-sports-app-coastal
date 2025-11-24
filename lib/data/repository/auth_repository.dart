import 'dart:async';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import '../services/service.dart';

class AuthRepository with WidgetsBindingObserver {
  final AuthService _authService;
  final AppPreferencesManager _prefs;

  Timer? _refreshTimer;
  bool _isRefreshing = false;

  AuthRepository(this._authService, this._prefs) {
    WidgetsBinding.instance.addObserver(this);
  }

  void startAutoRefresh() {
    _refreshTimer?.cancel();

    const refreshInterval = Duration(seconds: 10);
    final randomOffset = Duration(seconds: Random().nextInt(5));

    _refreshTimer = Timer.periodic(refreshInterval + randomOffset, (_) async {
      try {
        final expiryMillis = await _prefs.getTokenExpiry();
        final now = DateTime.now().millisecondsSinceEpoch;

        if (expiryMillis == null) return;
        if (now >= expiryMillis) {
          return;
        }
        if (now >= expiryMillis - 60000) {
          await refreshToken();
        }
      } catch (_) {}
    });
  }

  Future<void> refreshOnAppStart() async {
    final expiryMillis = await _prefs.getTokenExpiry();
    final now = DateTime.now().millisecondsSinceEpoch;

    if (expiryMillis == null || now >= expiryMillis - 20 * 60 * 1000) {
      await refreshToken();
    }
    // await refreshToken();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _refreshTimer?.cancel();
  }

  // --- 🔄 Refresh Logic ----------------------------------------------------

  Future<bool> refreshToken() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;

    try {
      final refreshToken = _prefs.currentUserValue?.refreshToken;
      if (refreshToken == null || refreshToken.isEmpty) return false;

      final result =
          await _authService.refreshToken(Uri.encodeComponent(refreshToken));

      return await result.when(
        onError: (_) => false,
        onSuccess: (token) async {
          await _prefs.updateUserToken(token);
          return true;
        },
      );
    } catch (_) {
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshOnAppStart();
    }
  }
}
