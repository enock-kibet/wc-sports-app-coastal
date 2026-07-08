import 'dart:convert';

class FrontendContextData {
  const FrontendContextData({
    this.activeLeagueId,
    this.activeLeagueName,
    this.activeSeasonId,
    this.activeSeasonName,
  });

  final String? activeLeagueId;
  final String? activeLeagueName;
  final String? activeSeasonId;
  final String? activeSeasonName;

  bool get hasActiveContext =>
      (activeLeagueId?.isNotEmpty ?? false) ||
      (activeSeasonId?.isNotEmpty ?? false);

  FrontendContextData copyWith({
    String? activeLeagueId,
    String? activeLeagueName,
    String? activeSeasonId,
    String? activeSeasonName,
  }) {
    return FrontendContextData(
      activeLeagueId: activeLeagueId ?? this.activeLeagueId,
      activeLeagueName: activeLeagueName ?? this.activeLeagueName,
      activeSeasonId: activeSeasonId ?? this.activeSeasonId,
      activeSeasonName: activeSeasonName ?? this.activeSeasonName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeLeagueId': activeLeagueId,
      'activeLeagueName': activeLeagueName,
      'activeSeasonId': activeSeasonId,
      'activeSeasonName': activeSeasonName,
    };
  }

  factory FrontendContextData.fromJson(Map<String, dynamic> json) {
    return FrontendContextData(
      activeLeagueId: json['activeLeagueId']?.toString(),
      activeLeagueName: json['activeLeagueName']?.toString(),
      activeSeasonId: json['activeSeasonId']?.toString(),
      activeSeasonName: json['activeSeasonName']?.toString(),
    );
  }

  factory FrontendContextData.fromEncoded(String raw) {
    return FrontendContextData.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  String encode() => jsonEncode(toJson());
}
