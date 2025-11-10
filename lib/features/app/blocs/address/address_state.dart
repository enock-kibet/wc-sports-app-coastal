part of 'address_bloc.dart';

enum AddressStatus {
  initial,
  loading,
  success,
  failure,
  ;

  bool get isInitial => this == AddressStatus.initial;
  bool get isLoading => this == AddressStatus.loading;
  bool get isSuccess => this == AddressStatus.success;
  bool get isFailure => this == AddressStatus.failure;
}

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default(AddressStatus.initial) AddressStatus status,
    Failure? failure,
    String? authorizationUrl,
    String? addressId,
    @Default([]) List<Address> data,
    @Default([]) List<PickupAddress> pickupAddresses,
  }) = _AddressState;
}
