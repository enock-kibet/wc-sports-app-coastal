class AppConfig {
  const AppConfig._();

  static const String leagueHeaderName = 'X-League-Id';
  static const String seasonHeaderName = 'X-Season-Id';

  // Preserve the league the legacy app was already hard-coded to use until a
  // different value is supplied by auth context or build-time configuration.
  static const String _defaultLeagueId = String.fromEnvironment(
    'SPORTS_APP_DEFAULT_LEAGUE_ID',
    defaultValue: '',
  );

  static const String _defaultSeasonId = String.fromEnvironment(
    'SPORTS_APP_DEFAULT_SEASON_ID',
    defaultValue: '',
  );

  static String? get defaultLeagueId => _normalize(_defaultLeagueId);
  static String? get defaultSeasonId => _normalize(_defaultSeasonId);

  static String? _normalize(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
