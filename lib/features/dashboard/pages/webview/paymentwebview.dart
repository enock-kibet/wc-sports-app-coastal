import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'viewcomponents/web_view_stack.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;
  const PaymentWebView({super.key, required this.paymentUrl});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure payment')),
      body: WebViewStack(controller: controller),
    );
  }
}
