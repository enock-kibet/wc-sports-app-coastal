import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/utils/dotted.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required String id,
    required String name,
    required String locality,
    required String city,
    required String country,
    required String phone,
    required double? latitude,
    required double? longitude,
    required bool? isDefault,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}