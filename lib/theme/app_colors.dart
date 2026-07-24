import 'package:flutter/material.dart';

class AppColors {
  static const Color _defaultBrandColor = Color(0xFF010060);

  static Color defaultAppRed = _defaultBrandColor;
  static Color defaultAppPurple = _defaultBrandColor;
  static Color primaryColor = _defaultBrandColor;
  static Color purpleColor = _defaultBrandColor;
  static Color pinkColor = _defaultBrandColor;
  static Color pink2Color = _defaultBrandColor;
  static Color inputFillColor = whiteColor;
  static Color greyColor = const Color(0xFFC7C7C7);
  static Color scaffoldBackground = const Color(0xFFF7F6F9);
  static Color darkColor = const Color(0xFF333333);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color greenColor = const Color(0xFF22BB33);
  static Color dangerColor = Colors.red;
  static Color warningColor = Colors.orange;
  static Color hintTextColor = const Color(0xFF4D4D4D);
  static Color blackColor = const Color(0xFF000000);

  static void applyBranding({
    String? primaryColorHex,
    String? secondaryColorHex,
    String? accentColorHex,
  }) {
    final primary = fromHex(primaryColorHex) ?? _defaultBrandColor;
    final secondary = fromHex(secondaryColorHex) ?? primary;
    final accent = fromHex(accentColorHex) ?? primary;

    defaultAppRed = primary;
    defaultAppPurple = primary;
    primaryColor = primary;
    purpleColor = secondary;
    pinkColor = accent;
    pink2Color = accent;
  }

  static Color? fromHex(String? value) {
    if (value == null) {
      return null;
    }

    final normalized = value.trim();
    if (normalized.isEmpty) {
      return null;
    }

    var hex = normalized.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    if (hex.length != 8) {
      return null;
    }

    final parsed = int.tryParse(hex, radix: 16);
    return parsed == null ? null : Color(parsed);
  }
}
