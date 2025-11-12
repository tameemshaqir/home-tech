
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatelessWidget {
  final OrderLine? item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.grey[700],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                '$url${item?.imageUrl}',
                fit: BoxFit.fill,
              )
            ),
          ),

          SizedBox(width: 12.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity: ${item?.quantity}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${item?.productName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${item?.priceTotal}',
                      style: TextStyle(
                        color: Color(0xFF00C853),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // if (item.originalPrice != null) ...[
                    //   SizedBox(width: 8),
                    //   Text(
                    //     item.originalPrice!,
                    //     style: TextStyle(
                    //       color: Colors.grey[500],
                    //       fontSize: 12,
                    //       decoration: TextDecoration.lineThrough,
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}