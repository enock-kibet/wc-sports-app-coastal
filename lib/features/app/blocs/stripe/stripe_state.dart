part of 'stripe_bloc.dart';

enum StripeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == StripeStatus.initial;
  bool get isLoading => this == StripeStatus.loading;
  bool get isSuccess => this == StripeStatus.success;
  bool get isFailure => this == StripeStatus.failure;
}

@freezed
class StripeState with _$StripeState {
  const factory StripeState({
    @Default(StripeStatus.initial) StripeStatus status,
    Failure? failure,
   Map<String,dynamic>? stripe,
  }) = _StripeState;
}
