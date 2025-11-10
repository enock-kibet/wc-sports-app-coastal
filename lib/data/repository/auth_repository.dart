import 'dart:async';

import 'package:sports_app/localization/app_prefs_manager.dart';
import '../services/service.dart';

class AuthRepository {
  final AuthService _authService;
  final AppPreferencesManager _prefs;

  Timer? _refreshTimer;

  AuthRepository(this._authService, this._prefs) {
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      final expiryMillis = await _prefs.getTokenExpiry();
      final now = DateTime.now().millisecondsSinceEpoch;

      if (expiryMillis != null && now >= expiryMillis - 60000) {
        await refreshToken();
      }
    });
  }

  bool _isRefreshing = false;

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
    } finally {
      _isRefreshing = false;
    }
  }
}
