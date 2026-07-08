import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/products/frontend_checkout.dart';
import 'package:sports_app/features/app/blocs/notifications/notification_bloc.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/app/blocs/products/cart_bloc.dart';
import 'package:sports_app/router/router.dart';

void refreshFrontendCheckoutContext(BuildContext context) {
  try {
    context.read<CartBloc>().add(
          const CartEvent.getCartItems(request: {}),
        );
  } catch (_) {}

  try {
    context.read<PointsBloc>().add(const PointsEvent.points());
  } catch (_) {}

  try {
    context
        .read<NotificationBloc>()
        .add(const NotificationEvent.notifications());
  } catch (_) {}
}

void handleFrontendCheckoutSuccess(
  BuildContext context,
  FrontendCheckoutResult checkout,
) {
  if (checkout.shouldOpenPaymentGateway) {
    context.goNamed(
      AppRoute.paymentWebView.name,
      extra: checkout.authorizationUrl!,
    );
    return;
  }

  refreshFrontendCheckoutContext(context);

  final orderId = checkout.orderId.trim();
  final message = _buildCheckoutSuccessMessage(checkout);

  if (orderId.isNotEmpty) {
    context.goNamed(
      AppRoute.profileOrderDetails.name,
      pathParameters: {'orderId': orderId},
      extra: orderId,
    );
  }

  SnackbarService.showSuccess(message);
}

String _buildCheckoutSuccessMessage(FrontendCheckoutResult checkout) {
  final usedPromotion = checkout.appliedPromotion?.discountAmount ?? 0;
  final usedPoints = checkout.pointsRedemption?.discountAmount ?? 0;

  if (usedPromotion > 0 && usedPoints > 0) {
    return 'Checkout completed with your promotion and points applied.';
  }

  if (usedPromotion > 0) {
    return 'Checkout completed with your promotion applied.';
  }

  if (usedPoints > 0) {
    return 'Checkout completed with your points applied.';
  }

  return 'Checkout completed successfully.';
}
