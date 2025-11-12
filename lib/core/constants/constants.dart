import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';



Locale? appLanguage;

// On color 80, 60.... those means opacity

const Color primaryColor = Color(0xffec2c38);

const MaterialColor primaryMaterialColor =
MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFFFFEBED),
  100: Color(0xFFFFCDD0),
  200: Color(0xFFFFABAF),
  300: Color(0xFFFF888E),
  400: Color(0xFFFF6F76),
  500: Color(0xFFEC2C38),
  600: Color(0xFFD62832),
  700: Color(0xFFBA232B),
  800: Color(0xFF9F1D25),
  900: Color(0xFF80171D),
});

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color scaffoldBackgroundColor = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xff2f2e2f);

const Color readColor = Color(0xffec2c38);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

 const double defaultPadding = 16.0;
 double defaultBorderRadious = 12.0;
 Duration defaultDuration = const Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'.tr()),
  MinLengthValidator(8, errorText: 'Password must be at least 8 characters long'.tr()),
  PatternValidator(r'(?=.*?[A-Z])', errorText: 'Must contain at least one uppercase letter'.tr()),
  PatternValidator(r'(?=.*?[a-z])', errorText: 'Must contain at least one lowercase letter'.tr()),
  PatternValidator(r'(?=.*?[0-9])', errorText: 'Must contain at least one number'.tr()),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Must contain at least one special character'.tr()),
]);


final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Phone number is required'.tr()),
  MinLengthValidator(10, errorText: 'Phone number must be at least 10 digits long'.tr()),
  PatternValidator(r'^0[0-9]+$', errorText: 'Phone number must start with 0 and contain digits only'.tr()),
]);


final addressValidator = MultiValidator([
  RequiredValidator(errorText: 'Address is required'.tr()),
]);


String? phone;

String? token;

String? refreshToken;
String? berereToken;

String url = 'http://191.101.81.32:8269';





