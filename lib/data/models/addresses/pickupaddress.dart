import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/utils/dotted.dart';

part 'pickupaddress.freezed.dart';
part 'pickupaddress.g.dart';

@freezed
class PickupAddress with _$PickupAddress {
  const factory PickupAddress({
    required String id,
    required String name,
    required String locality,
    required String city,
    required String country,
    required String phone,
    required double? latitude,
    required double? longitude,
    required bool? isDefault,
  }) = _PickupAddress;

  factory PickupAddress.fromJson(Map<String, dynamic> json) =>
      _$PickupAddressFromJson(json);
}
