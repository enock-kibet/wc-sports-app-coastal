import 'package:freezed_annotation/freezed_annotation.dart';

part 'roaster.freezed.dart';
part 'roaster.g.dart';

@freezed
class RoasterResponse with _$RoasterResponse {
  const factory RoasterResponse({
    required List<RoasterData> data,
  }) = _RoasterResponse;

  factory RoasterResponse.fromJson(Map<String, dynamic> json) =>
      _$RoasterResponseFromJson(json);
}

@freezed
class RoasterData with _$RoasterData {
  const factory RoasterData({
    required String playerId,
    required String playerName,
    required String position,
    required String imageUrl,
    required String playerHeight,
    required String playerWeight,
    required String playerNumber,
    required Map<String, dynamic> stats,
  }) = _RoasterData;

  factory RoasterData.fromJson(Map<String, dynamic> json) =>
      _$RoasterDataFromJson(json);
}
