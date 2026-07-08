import 'package:sports_app/data/models/session/frontend_context.dart';
import 'package:sports_app/data/models/user/user.dart';

class AuthenticatedUserPayload {
  const AuthenticatedUserPayload({
    required this.user,
    this.context,
  });

  final User user;
  final FrontendContextData? context;
}

class RefreshTokenPayload {
  const RefreshTokenPayload({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;
}
