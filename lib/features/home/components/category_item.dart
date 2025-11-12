import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage('assets/images/food.png'),
            radius: 30.r,

            backgroundColor:Colors.grey[800] ,
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color:Colors.white ,
            ),
          ),
        ],
      ),
    );
  }
}
