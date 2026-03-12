import 'package:flutter/material.dart';
import 'package:sports_app/theme/app_colors.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show(
    String message, {
    Color? backgroundColor,
    int seconds = 3,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: seconds),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: Colors.white,
                onPressed: onAction ?? messenger.removeCurrentSnackBar,
              )
            : null,
      ),
    );
  }

  static void showSuccess(
    String message, {
    int seconds = 3,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      message,
      backgroundColor: AppColors.greenColor,
      seconds: seconds,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showError(
    String message, {
    int seconds = 3,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      message,
      backgroundColor: AppColors.dangerColor,
      seconds: seconds,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void hide() {
    messengerKey.currentState?.removeCurrentSnackBar();
  }
}
