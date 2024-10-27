import 'package:flutter/material.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/theme/theme.dart';

class ToastContainer extends StatelessWidget {
  const ToastContainer({super.key, this.bgColor, required this.msg});
  final Color? bgColor;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kSmall, vertical: kSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSmall),
          color: bgColor ?? AppColors.dangerColor,
        ),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.whiteColor),
        ));
  }
}
