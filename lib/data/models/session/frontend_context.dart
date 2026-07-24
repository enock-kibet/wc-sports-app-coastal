import 'dart:convert';

class FrontendContextData {
  const FrontendContextData({
    this.activeLeagueId,
    this.activeLeagueName,
    this.activeLeagueSport,
    this.activeLeagueCountry,
    this.activeSeasonId,
    this.activeSeasonName,
    this.activeClubId,
    this.activeClubName,
    this.activeClubLocation,
    this.activeClubWebsite,
    this.activeClubDescription,
    this.activeClubContactNumber,
    this.activeClubEmail,
    this.activeClubHeadCoachName,
    this.activeClubLogoUrl,
    this.brandingName,
    this.brandingPrimaryColor,
    this.brandingSecondaryColor,
    this.brandingAccentColor,
    this.brandingLogoUrl,
  });

  final String? activeLeagueId;
  final String? activeLeagueName;
  final String? activeLeagueSport;
  final String? activeLeagueCountry;
  final String? activeSeasonId;
  final String? activeSeasonName;
  final String? activeClubId;
  final String? activeClubName;
  final String? activeClubLocation;
  final String? activeClubWebsite;
  final String? activeClubDescription;
  final String? activeClubContactNumber;
  final String? activeClubEmail;
  final String? activeClubHeadCoachName;
  final String? activeClubLogoUrl;
  final String? brandingName;
  final String? brandingPrimaryColor;
  final String? brandingSecondaryColor;
  final String? brandingAccentColor;
  final String? brandingLogoUrl;

  bool get hasActiveContext =>
      (activeLeagueId?.isNotEmpty ?? false) ||
      (activeSeasonId?.isNotEmpty ?? false);

  bool get hasBranding =>
      (_normalized(brandingPrimaryColor)?.isNotEmpty ?? false) ||
      (_normalized(brandingSecondaryColor)?.isNotEmpty ?? false) ||
      (_normalized(brandingAccentColor)?.isNotEmpty ?? false) ||
      (_normalized(brandingName)?.isNotEmpty ?? false);

  String get resolvedBrandName =>
      _normalized(brandingName) ??
      _normalized(activeClubName) ??
      _normalized(activeLeagueName) ??
      'Coastal Kings';

  String get resolvedLogoUrl =>
      _normalized(brandingLogoUrl) ??
      _normalized(activeClubLogoUrl) ??
      '';

  FrontendContextData copyWith({
    String? activeLeagueId,
    String? activeLeagueName,
    String? activeLeagueSport,
    String? activeLeagueCountry,
    String? activeSeasonId,
    String? activeSeasonName,
    String? activeClubId,
    String? activeClubName,
    String? activeClubLocation,
    String? activeClubWebsite,
    String? activeClubDescription,
    String? activeClubContactNumber,
    String? activeClubEmail,
    String? activeClubHeadCoachName,
    String? activeClubLogoUrl,
    String? brandingName,
    String? brandingPrimaryColor,
    String? brandingSecondaryColor,
    String? brandingAccentColor,
    String? brandingLogoUrl,
  }) {
    return FrontendContextData(
      activeLeagueId: activeLeagueId ?? this.activeLeagueId,
      activeLeagueName: activeLeagueName ?? this.activeLeagueName,
      activeLeagueSport: activeLeagueSport ?? this.activeLeagueSport,
      activeLeagueCountry: activeLeagueCountry ?? this.activeLeagueCountry,
      activeSeasonId: activeSeasonId ?? this.activeSeasonId,
      activeSeasonName: activeSeasonName ?? this.activeSeasonName,
      activeClubId: activeClubId ?? this.activeClubId,
      activeClubName: activeClubName ?? this.activeClubName,
      activeClubLocation: activeClubLocation ?? this.activeClubLocation,
      activeClubWebsite: activeClubWebsite ?? this.activeClubWebsite,
      activeClubDescription:
          activeClubDescription ?? this.activeClubDescription,
      activeClubContactNumber:
          activeClubContactNumber ?? this.activeClubContactNumber,
      activeClubEmail: activeClubEmail ?? this.activeClubEmail,
      activeClubHeadCoachName:
          activeClubHeadCoachName ?? this.activeClubHeadCoachName,
      activeClubLogoUrl: activeClubLogoUrl ?? this.activeClubLogoUrl,
      brandingName: brandingName ?? this.brandingName,
      brandingPrimaryColor:
          brandingPrimaryColor ?? this.brandingPrimaryColor,
      brandingSecondaryColor:
          brandingSecondaryColor ?? this.brandingSecondaryColor,
      brandingAccentColor: brandingAccentColor ?? this.brandingAccentColor,
      brandingLogoUrl: brandingLogoUrl ?? this.brandingLogoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeLeagueId': activeLeagueId,
      'activeLeagueName': activeLeagueName,
      'activeLeagueSport': activeLeagueSport,
      'activeLeagueCountry': activeLeagueCountry,
      'activeSeasonId': activeSeasonId,
      'activeSeasonName': activeSeasonName,
      'activeClubId': activeClubId,
      'activeClubName': activeClubName,
      'activeClubLocation': activeClubLocation,
      'activeClubWebsite': activeClubWebsite,
      'activeClubDescription': activeClubDescription,
      'activeClubContactNumber': activeClubContactNumber,
      'activeClubEmail': activeClubEmail,
      'activeClubHeadCoachName': activeClubHeadCoachName,
      'activeClubLogoUrl': activeClubLogoUrl,
      'brandingName': brandingName,
      'brandingPrimaryColor': brandingPrimaryColor,
      'brandingSecondaryColor': brandingSecondaryColor,
      'brandingAccentColor': brandingAccentColor,
      'brandingLogoUrl': brandingLogoUrl,
    };
  }

  factory FrontendContextData.fromJson(Map<String, dynamic> json) {
    return FrontendContextData(
      activeLeagueId: json['activeLeagueId']?.toString(),
      activeLeagueName: json['activeLeagueName']?.toString(),
      activeLeagueSport: json['activeLeagueSport']?.toString(),
      activeLeagueCountry: json['activeLeagueCountry']?.toString(),
      activeSeasonId: json['activeSeasonId']?.toString(),
      activeSeasonName: json['activeSeasonName']?.toString(),
      activeClubId: json['activeClubId']?.toString(),
      activeClubName: json['activeClubName']?.toString(),
      activeClubLocation: json['activeClubLocation']?.toString(),
      activeClubWebsite: json['activeClubWebsite']?.toString(),
      activeClubDescription: json['activeClubDescription']?.toString(),
      activeClubContactNumber: json['activeClubContactNumber']?.toString(),
      activeClubEmail: json['activeClubEmail']?.toString(),
      activeClubHeadCoachName: json['activeClubHeadCoachName']?.toString(),
      activeClubLogoUrl: json['activeClubLogoUrl']?.toString(),
      brandingName: json['brandingName']?.toString(),
      brandingPrimaryColor: json['brandingPrimaryColor']?.toString(),
      brandingSecondaryColor: json['brandingSecondaryColor']?.toString(),
      brandingAccentColor: json['brandingAccentColor']?.toString(),
      brandingLogoUrl: json['brandingLogoUrl']?.toString(),
    );
  }

  factory FrontendContextData.fromEncoded(String raw) {
    return FrontendContextData.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  String encode() => jsonEncode(toJson());

  static String? _normalized(String? value) {
    if (value == null) {
      return null;
    }

    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
