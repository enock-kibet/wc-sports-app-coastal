part of 'stripe_bloc.dart';

@freezed
class StripeEvent with _$StripeEvent {
  const factory StripeEvent.stripe({ required String email,
    required int price,}) = _StripeFetched;

}
