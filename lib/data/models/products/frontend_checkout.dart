class FrontendPromotionValidationResult {
  const FrontendPromotionValidationResult({
    required this.code,
    required this.name,
    required this.description,
    required this.type,
    required this.value,
    required this.status,
    required this.amount,
    required this.discountAmount,
    required this.finalAmount,
    required this.currency,
  });

  final String code;
  final String name;
  final String description;
  final String type;
  final double value;
  final String status;
  final double amount;
  final double discountAmount;
  final double finalAmount;
  final String currency;
}

class FrontendAppliedPromotion {
  const FrontendAppliedPromotion({
    required this.promotionId,
    required this.promotionCode,
    required this.promotionName,
    required this.discountAmount,
    required this.currency,
    required this.status,
  });

  final String promotionId;
  final String promotionCode;
  final String promotionName;
  final double discountAmount;
  final String currency;
  final String status;
}

class FrontendPointsRedemption {
  const FrontendPointsRedemption({
    required this.appliedPoints,
    required this.discountAmount,
    required this.status,
  });

  final int appliedPoints;
  final double discountAmount;
  final String status;
}

class FrontendCheckoutResult {
  const FrontendCheckoutResult({
    required this.orderId,
    required this.orderNumber,
    required this.subtotalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.authorizationUrl,
    required this.accessCode,
    required this.reference,
    required this.provider,
    required this.status,
    required this.requiresPayment,
    this.appliedPromotion,
    this.pointsRedemption,
  });

  final String orderId;
  final String orderNumber;
  final double subtotalAmount;
  final double discountAmount;
  final double taxAmount;
  final double totalAmount;
  final String? authorizationUrl;
  final String? accessCode;
  final String reference;
  final String provider;
  final String status;
  final bool requiresPayment;
  final FrontendAppliedPromotion? appliedPromotion;
  final FrontendPointsRedemption? pointsRedemption;

  bool get shouldOpenPaymentGateway {
    return requiresPayment &&
        status.toLowerCase() != 'completed' &&
        authorizationUrl != null &&
        authorizationUrl!.trim().isNotEmpty;
  }

  bool get isCompletedWithoutPayment => !shouldOpenPaymentGateway;
}
