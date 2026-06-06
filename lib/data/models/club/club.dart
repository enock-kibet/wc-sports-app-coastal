import 'package:freezed_annotation/freezed_annotation.dart';

part 'club.freezed.dart';
part 'club.g.dart';

@freezed
class ClubRoasterResponse with _$ClubRoasterResponse {
  const factory ClubRoasterResponse({
    required List<ClubRoasterData> data,
  }) = _ClubRoasterResponse;

  factory ClubRoasterResponse.fromJson(Map<String, dynamic> json) =>
      _$ClubRoasterResponseFromJson(json);
}

@freezed
class ClubRoasterData with _$ClubRoasterData {
  const factory ClubRoasterData({
    required String id,
    required String name,
    required String leagueId,
    String? imageUrl,
  }) = _ClubRoasterData;

  factory ClubRoasterData.fromJson(Map<String, dynamic> json) =>
      _$ClubRoasterDataFromJson(json);
}
