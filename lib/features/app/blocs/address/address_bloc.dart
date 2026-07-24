import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/addresses/address.dart';
import 'package:sports_app/data/models/addresses/pickupaddress.dart';
import 'package:sports_app/data/models/multiple_results/multiple_result.dart'
    as result_model;

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
      }, onSuccess: (data) {
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
      if (recordResponse is result_model.Error<String>) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          failure: recordResponse.error,
        ));
        return;
      }

      final addressId = (recordResponse as result_model.Success<String>).data;
      final addressesResponse = await _addressService.getAddresses();
      if (emit.isDone) {
        return;
      }

      if (addressesResponse is result_model.Success<List<Address>>) {
        emit(state.copyWith(
          status: AddressStatus.success,
          addressId: addressId,
          data: addressesResponse.data,
          failure: null,
        ));
        return;
      }

      emit(state.copyWith(
        status: AddressStatus.success,
        addressId: addressId,
        failure: null,
      ));
    });

    on<_PickupAddressFetch>((event, emit) async {
      emit(state.copyWith(status: AddressStatus.loading));
      final recordResponse = await _pickupAddressService.getPickupAddresses();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) {
        emit(state.copyWith(
          status: AddressStatus.success,
          pickupAddresses: data,
          failure: null,
        ));
      });
    });
  }
}
