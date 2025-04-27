import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
class PlayerProfileData with _$PlayerProfileData {
  const factory PlayerProfileData({
    required String name,
    required String age,
    required String position,
    required String imageUrl,
    required String height,     // extracted from profile
    required String weight,     // extracted from profile
    required String experience,
    @JsonKey(name: 'jerseyNumber') required String jerseyNumber,
    @JsonKey(name: 'homeTown') required String homeTown,
  }) = _PlayerProfileData;

  factory PlayerProfileData.fromJson(Map<String, dynamic> json) => _$PlayerProfileDataFromJson(json);
}
