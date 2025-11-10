part of 'address_bloc.dart';

@freezed
class AddressEvent with _$AddressEvent {
  const factory AddressEvent.getAddresses({required dynamic request}) =
      _AddressFetchedCart;
  const factory AddressEvent.getPickupAddresses() = _PickupAddressFetch;
  const factory AddressEvent.addAddress({required dynamic request}) =
      _AddressAdd;
}
