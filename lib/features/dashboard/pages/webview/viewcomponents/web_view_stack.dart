part of '../paymentwebview.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;

  var loadingPercentage = 0;
  bool _verifyingCheckout = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // Providing TickerProviderStateMixin
    )..repeat(reverse: true);

    _colorTween = _controller.drive(
      ColorTween(
          begin: AppColors.defaultAppRed, end: AppColors.defaultAppPurple),
    );
    widget.controller
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }, onNavigationRequest: (navigation) async {
        final uri = Uri.tryParse(navigation.url);
        if (uri != null && _isCheckoutCompletionUri(uri)) {
          if (_verifyingCheckout) {
            return NavigationDecision.prevent;
          }

          final router = GoRouter.of(context);
          final cartBloc = context.read<CartBloc>();
          final pointsBloc = context.read<PointsBloc>();
          final notificationBloc = context.read<NotificationBloc>();

          final reference = _extractCheckoutReference(uri);
          final status = uri.queryParameters['status']?.toLowerCase();
          if (reference == null || reference.isEmpty) {
            router.pop();
            if (status == 'cancelled' ||
                status == 'canceled' ||
                status == 'failed') {
              SnackbarService.showError('Payment was not completed.');
            } else {
              SnackbarService.showError(
                'We could not confirm this payment yet. Please check your orders shortly.',
              );
            }
            return NavigationDecision.prevent;
          }

          _verifyingCheckout = true;
          final provider =
              uri.queryParameters['provider']?.trim().isNotEmpty == true
                  ? uri.queryParameters['provider']!.trim()
                  : 'paystack';
          final verification = await service<ProductService>()
              .verifyFrontendCheckout(provider, reference);
          if (!mounted) {
            return NavigationDecision.prevent;
          }

          verification.when(
            onError: (error) {
              router.pop();
              SnackbarService.showError(
                error.error.isEmpty
                    ? 'Payment verification failed. Please try again.'
                    : error.error,
              );
            },
            onSuccess: (_) async {
              var successMessage = 'Payment confirmed successfully';
              final ticketSummaryResult =
                  await service<TicketService>().getTicketSummary();
              ticketSummaryResult.when(
                onError: (_) {},
                onSuccess: (summary) {
                  if (summary.upcoming > 0) {
                    successMessage =
                        'Payment confirmed successfully. Upcoming tickets: ${summary.upcoming}';
                  }
                },
              );
              if (!mounted) {
                return;
              }

              cartBloc.add(
                const CartEvent.getCartItems(request: {}),
              );
              pointsBloc.add(const PointsEvent.points());
              notificationBloc.add(const NotificationEvent.notifications());
              router.pop();
              SnackbarService.showSuccess(successMessage);
            },
          );

          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('SnackBar', onMessageReceived: (message) {
        AnimatedOverlaySnackbar.show(
            context, "Error: No item has been added to cart",
            color: AppColors.defaultAppRed);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      });
  }

  bool _isCheckoutCompletionUri(Uri uri) {
    if (uri.scheme == 'sportsapp') {
      return uri.host == 'checkout' || uri.path.contains('checkout/complete');
    }

    return uri.path.contains('/checkout/complete');
  }

  String? _extractCheckoutReference(Uri uri) {
    final reference = uri.queryParameters['reference'] ??
        uri.queryParameters['trxref'] ??
        uri.queryParameters['transaction_id'];
    if (reference == null) {
      return null;
    }

    final trimmed = reference.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
            valueColor: _colorTween,
          ),
      ],
    );
  }
}
