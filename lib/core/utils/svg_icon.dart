import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture svgIcon(String src, {Color? color , required context}) {
  return SvgPicture.asset(
    src,
    height: 24.h,
    colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).iconTheme.color!.withOpacity(1),
        BlendMode.srcIn
    ),
  );
}