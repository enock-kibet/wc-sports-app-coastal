import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget appScaffold({
  double webAppWidth = 500.0,
  required Widget child,
}) {
  if (!kIsWeb) {
    return child;
  }
  return Center(
    child: ClipRect(
      child: SizedBox(
        width: webAppWidth,
        child: child,
      ),
    ),
  );
}
