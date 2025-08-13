import 'package:json_annotation/json_annotation.dart';

class StringOrIntConverter implements JsonConverter<String, Object?> {
  const StringOrIntConverter();

  @override
  String fromJson(Object? json) {
    if (json == null) return '';
    if (json is num) return json.toString();
    return json as String;
  }

  @override
  Object? toJson(String object) => object;
}
