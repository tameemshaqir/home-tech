import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';


class UnitPrice extends StatelessWidget {
  const UnitPrice({
    super.key,
    required this.price,
    this.priceAfterDiscount, this.code,
  });

  final double? price;
  final double? priceAfterDiscount;
  final String? code
  ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Unit price".tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: defaultPadding.h / 1),
        Text.rich(
          TextSpan(
            text: priceAfterDiscount == null || priceAfterDiscount == 0.0 || price == priceAfterDiscount
                ? "$code${price?.toStringAsFixed(2)}  "
                : "$code${priceAfterDiscount!.toStringAsFixed(2)}  ",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            children: [
              if (priceAfterDiscount != null && priceAfterDiscount != 0 && price != priceAfterDiscount )
                TextSpan(
                  text: "${price?.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      decoration: TextDecoration.lineThrough),
                ),
            ],
          ),
        )
      ],
    );
  }
}
