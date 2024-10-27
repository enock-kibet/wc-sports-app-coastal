import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_checkout.freezed.dart';
part 'stripe_checkout.g.dart';

@freezed
abstract class StripeCheckout with _$StripeCheckout {
  const factory StripeCheckout({
    required String paymentIntent,
    required String ephemeralKey,
    required String customer,
    required String publishableKey,
  }) = _StripeCheckout;

  factory StripeCheckout.fromJson(Map<String, dynamic> json) =>
      _$StripeCheckoutFromJson(json);
}
