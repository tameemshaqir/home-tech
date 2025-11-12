import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesItem extends StatelessWidget {
  const FavoritesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.r) , bottom: Radius.circular(10.r)),
              image: DecorationImage(
                image: AssetImage('assets/images/phone.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),


          Padding(
            padding: EdgeInsetsDirectional.only(top: 8.0.h, start: 8.0.w, end: 8.0.w),
            child: Text(
              '19%',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Text(
              'Iphone',
              style: TextStyle(
                color: Colors.white ,
                fontSize: 12.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              children: [
                Text(
                  '3500',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  '5000',
                  style: TextStyle(
                    color:Colors.grey[500],
                    fontSize: 12.sp,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsDirectional.only(start: 8.0.w, end: 8.0.w, bottom: 8.0.h, top: 4.0.h),
            child: Row(
              children: [
                // _buildRatingStars(product['rating']),
                SizedBox(width: 4.w),
                Text(
                  '3.5',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  '(3.5)',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
