import 'package:flutter/material.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/utils/utils.dart';

import 'app_colors.dart';

ThemeData buildLightTheme() {
  return _buildTheme(
    _buildColorScheme(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
    ),
  );
}

ThemeData buildDarkTheme() {
  return _buildTheme(
    _buildColorScheme(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
    ),
  );
}

ColorScheme _buildColorScheme({
  required Brightness brightness,
  required Color primaryColor,
}) {
  final isDark = brightness == Brightness.dark;

  return ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: brightness,
  ).copyWith(
    primary: primaryColor,
    onPrimary: AppColors.darkColor,
    onPrimaryContainer: AppColors.darkColor,
    secondary: isDark ? const Color(0xFF9AA7BF) : const Color(0xFF7D8AA3),
    surface: isDark ? const Color(0xFF151824) : const Color(0xFFFFFFFF),
    onSurface: isDark ? const Color(0xFFF5F7FB) : const Color(0xFF1B1F28),
    error: AppColors.dangerColor,
  );
}

ThemeData _buildTheme(ColorScheme colorScheme) {
  final isDark = colorScheme.brightness == Brightness.dark;
  final baseTextTheme = createTextTheme().apply(
    bodyColor: colorScheme.onSurface,
    displayColor: colorScheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    fontFamily: 'Inter',
    textTheme: baseTextTheme,
    scaffoldBackgroundColor:
        isDark ? const Color(0xFF090B11) : const Color(0xFFF6F7FB),
    canvasColor: colorScheme.surface,
    cardColor: colorScheme.surface,
    dividerColor: isDark ? Colors.white12 : Colors.black12,
    disabledColor: isDark ? Colors.white38 : Colors.black38,
    splashColor: AppColors.primaryColor.withValues(alpha: 0.12),
    highlightColor: AppColors.primaryColor.withValues(alpha: 0.08),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      modalBackgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: isDark ? 0 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      height: 50,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kSmall),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.darkColor,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSmall),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.darkColor,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSmall),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSmall),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: isDark ? const Color(0xFF1B2030) : const Color(0xFFF0F2F7),
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(kSmall),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kMedium,
        vertical: kXLMedium * 0.9,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide(color: AppColors.dangerColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide(color: AppColors.dangerColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide.none,
      ),
      hintStyle: baseTextTheme.bodyMedium?.copyWith(
        color: isDark ? Colors.white54 : const Color(0xFF818898),
      ),
      errorStyle: baseTextTheme.bodySmall?.copyWith(
        color: AppColors.dangerColor,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return isDark ? Colors.white70 : Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor.withValues(alpha: 0.45);
        }
        return isDark ? Colors.white24 : Colors.black12;
      }),
    ),
  );
}

ThemeData buildSystemTheme() => buildLightTheme();
