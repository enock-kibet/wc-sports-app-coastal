import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';

import 'package:sports_app/data/services/service.dart';

part 'stripe_event.dart';
part 'stripe_state.dart';
part 'stripe_bloc.freezed.dart';

class StripeBloc extends Bloc<StripeEvent, StripeState> {
  late StripeService _stripeService;

  StripeBloc() : super(const StripeState()) {
    _stripeService = service<StripeService>();

    on<_StripeFetched>((event, emit) async {
      emit(state.copyWith(status: StripeStatus.loading));
      final recordResponse = await _stripeService.getStripe(email: event.email,price:event.price);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: StripeStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: StripeStatus.success,
          stripe: data,
          failure: null,
        ));
      });
    });
  }
}
