import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class MediaData with _$MediaData {
  const factory MediaData({
    required List<Highlight> recentHighlights,
    required List<SeasonHighlight> seasonHighlights,
  }) = _MediaData;

  factory MediaData.fromJson(Map<String, dynamic> json) => _$MediaDataFromJson(json);
}

@freezed
class Highlight with _$Highlight {
  const factory Highlight({
    required String title,
    required String image,
  }) = _Highlight;

  factory Highlight.fromJson(Map<String, dynamic> json) => _$HighlightFromJson(json);
}

@freezed
class SeasonHighlight with _$SeasonHighlight {
  const factory SeasonHighlight({
    required String title,
    required String image,
    required String time,
    required String date,
  }) = _SeasonHighlight;

  factory SeasonHighlight.fromJson(Map<String, dynamic> json) => _$SeasonHighlightFromJson(json);
}
