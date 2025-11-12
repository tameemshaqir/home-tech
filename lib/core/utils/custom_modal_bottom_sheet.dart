import 'package:ecommerce/core/constants/constants.dart';
import 'package:flutter/material.dart';


Future<dynamic> customModalBottomSheet(
  BuildContext context, {
  bool isDismissible = true,
  double? height,
  required Widget child,
}) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(defaultBorderRadious * 2),
        topEnd: Radius.circular(defaultBorderRadious * 2),
      ),
    ),
    builder: (context) => SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.75,
      child: child,
    ),
  );
}
