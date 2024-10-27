// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_checkout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StripeCheckoutImpl _$$StripeCheckoutImplFromJson(Map<String, dynamic> json) =>
    _$StripeCheckoutImpl(
      paymentIntent: json['paymentIntent'] as String,
      ephemeralKey: json['ephemeralKey'] as String,
      customer: json['customer'] as String,
      publishableKey: json['publishableKey'] as String,
    );

Map<String, dynamic> _$$StripeCheckoutImplToJson(
        _$StripeCheckoutImpl instance) =>
    <String, dynamic>{
      'paymentIntent': instance.paymentIntent,
      'ephemeralKey': instance.ephemeralKey,
      'customer': instance.customer,
      'publishableKey': instance.publishableKey,
    };
