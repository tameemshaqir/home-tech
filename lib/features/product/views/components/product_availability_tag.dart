import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: isAvailable ? successColor : errorColor,
        borderRadius:  BorderRadius.all(
          Radius.circular(defaultBorderRadious / 2),
        ),
      ),
      child: Text(
        isAvailable ? "Available in stock".tr() : "Currently unavailable".tr(),
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
