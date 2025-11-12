import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/constants.dart';



class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
    required this.numOfItem,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int numOfItem;
  final VoidCallback onIncrement, onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quantity".tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
         SizedBox(height: defaultPadding.h),
        Row(
          children: [
            SizedBox(
              height: 40.h,
              width: 40.w,
              child: OutlinedButton(
                onPressed: onDecrement,
                style: OutlinedButton.styleFrom(
                    padding:  EdgeInsets.all(defaultPadding.r / 2)),
                child: SvgPicture.asset(
                  "assets/icons/Minus.svg",
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            SizedBox(
              width: 40.w,
              child: Center(
                child: Text(
                  numOfItem.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500 ,color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
              width: 40.w,
              child: OutlinedButton(
                onPressed: onIncrement,
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(defaultPadding.r / 2),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Plus1.svg",
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
