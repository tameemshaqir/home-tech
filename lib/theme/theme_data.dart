import 'package:ecommerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


 AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: const IconThemeData(color: blackColor),
  titleTextStyle: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: blackColor,
  ),
);

 AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: scaffoldBackgroundColor,
  elevation: 0.0,
  iconTheme: const IconThemeData(color: Colors.white),
  titleTextStyle: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: MaterialStateProperty.all(primaryColor),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24.h,
  headingRowColor: MaterialStateProperty.all(Colors.black12),
  decoration: BoxDecoration(
    borderRadius:  BorderRadius.all(Radius.circular(defaultBorderRadious.r)),
    border: Border.all(color: Colors.black12),
  ),
  dataTextStyle:  TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: blackColor,
  ),
);

DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
  columnSpacing: 24.h,
  headingRowColor: MaterialStateProperty.all(Colors.white10),
  decoration: BoxDecoration(
    borderRadius:  BorderRadius.all(Radius.circular(defaultBorderRadious.r)),
    border: Border.all(color: Colors.white10),
  ),
  dataTextStyle:  TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 12.sp,
  ),
);
