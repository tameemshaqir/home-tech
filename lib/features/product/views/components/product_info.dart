import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/constants.dart';
import 'product_availability_tag.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.description,
    // required this.rating,
    required this.numOfReviews,
    required this.isAvailable,
  });

  final String? title, description;
  // final int rating;
  final int numOfReviews;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
             SizedBox(height: defaultPadding.h),
            Row(
              children: [
                ProductAvailabilityTag(isAvailable: isAvailable),
                const Spacer(),

              ],
            ),
             SizedBox(height: defaultPadding.h),
            Text(
              "Product info".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500 ,color: Colors.white),
            ),
             SizedBox(height: defaultPadding.h / 2),
            Text(
              '$description',
              style: TextStyle(height: 1.4.h ,color:Colors.white),
            ),
             SizedBox(height: defaultPadding.h / 2),
          ],
        ),
      ),
    );
  }
}
