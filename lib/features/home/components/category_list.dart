import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/features/category/category_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {

  final CategoryModel? categories ;
  final bool showAll;

  const CategoryList({super.key, required this.categories, required this.showAll });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(10.0.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: size.width * 0.20,
              mainAxisExtent: size.height * 0.13,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 10.h
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: (){
              MainCubit.get(context).getCategoryProducts(categoryId: categories!.data[index].id);
              navigateTo(context, CategoryProductsScreen());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network('$url${categories?.data[index].imageUrl}' ,fit: BoxFit.cover,height: size.height * 0.09),
                ),
                SizedBox(height: 10.h,),
                Text(
                    '${categories?.data[index].name}',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13.sp
                  )
                ),
              ],
            ),
          ),
          itemCount: showAll ? categories?.data.length : categories?.data.length != null
              ? (categories!.data.length <= 8 ? categories?.data.length : 8)
              : 0,
        ),
      ),
    );
  }
}
