import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/common/dimens.dart';

import 'app_colors.dart';

//!TODO: add INTER FONT
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(),//.jetBrainsMonoTextTheme(),
  //fontFamily: 'Inter',
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    height: 50,
    minWidth: double.infinity,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kSmall),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.greyColor,
    filled: true,
    border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(kSmall)),
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
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide(
          color: AppColors.dangerColor,
        )),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall),
        borderSide: BorderSide(
          color: AppColors.dangerColor,
        )),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kSmall),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.greyColor.withOpacity(0.7),
    ),
    errorStyle: TextStyle(
      color: AppColors.dangerColor,
    ),
  ),
  colorScheme: ColorScheme.light(
    background: AppColors.whiteColor,
    primary: AppColors.primaryColor,
    secondary: AppColors.greyColor,
    tertiary: Colors.white,
  ),
);
