import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.index, required this.title, required this.selectedCategory});
  final int index;
  final String title;
  final int selectedCategory;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedCategory == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          MainCubit.get(context).changeHomeCategory();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ?  Colors.blue[800]
                : Colors.transparent,
            borderRadius: index == 0
                ? BorderRadiusDirectional.horizontal(start: Radius.circular(10.r))
                : BorderRadiusDirectional.horizontal(end: Radius.circular(10.r)),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
