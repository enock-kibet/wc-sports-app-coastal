import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/addresses/address.dart';
import 'package:sports_app/data/models/addresses/pickupaddress.dart';

import 'package:sports_app/data/services/service.dart';

part 'address_event.dart';
part 'address_state.dart';
part 'address_bloc.freezed.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  late AddressService _addressService;
  late PickupAddressService _pickupAddressService;
  AddressBloc() : super(const AddressState()) {
    _addressService = service<AddressService>();
    _pickupAddressService = service<PickupAddressService>();

    on<_AddressFetchedCart>((event, emit) async {
      emit(state.copyWith(status: AddressStatus.loading));
      final recordResponse = await _addressService.getAddresses();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: AddressStatus.success,
          data: data,
          failure: null,
        ));
      });
    });

    on<_AddressAdd>((event, emit) async {
      emit(state.copyWith(status: AddressStatus.loading));
      final recordResponse = await _addressService.addNewAddress(event.request);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: AddressStatus.success,
          addressId: data,
          failure: null,
        ));
      });
    });

    on<_PickupAddressFetch>((event, emit) async {
      emit(state.copyWith(status: AddressStatus.loading));
      final recordResponse = await _pickupAddressService.getPickupAddresses();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: AddressStatus.success,
          pickupAddresses: data,
          failure: null,
        ));
      });
    });
  }
}
