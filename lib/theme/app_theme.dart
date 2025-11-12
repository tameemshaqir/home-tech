import 'package:ecommerce/theme/button_theme.dart';
import 'package:ecommerce/theme/input_decoration_theme.dart';
import 'package:flutter/material.dart';
import '../core/constants/constants.dart';
import 'checkbox_themedata.dart';
import 'theme_data.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Cairo",
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      iconTheme: const IconThemeData(color: whiteColor),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: blackColor40),
        bodyLarge: TextStyle(color: blackColor40),
        headlineSmall: TextStyle(color: blackColor40),
        titleSmall: TextStyle(color: blackColor40),
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: darkInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: blackColor40),
      ),
      appBarTheme: appBarDarkTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableDarkThemeData,
    );
  }


}
