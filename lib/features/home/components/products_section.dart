import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/features/product/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductsSection extends StatelessWidget {
  const HomeProductsSection({super.key, required this.products,  this.screen});
  final products;
  final String? screen;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.69,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
            ),
            itemCount: products == null ? 0 : products.length,
            itemBuilder: (context, index) {
              return _buildProductGridItem(products[index] , context);
            },
          ),
        ],
      ),
    );
  }


  Widget _buildProductGridItem(var product , BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            MainCubit.get(context).getProductDetails(id: product.id);
            navigateTo(context, const ProductDetailsScreen());
          },
          child: Container(
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
                  height: 160.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.r) , bottom: Radius.circular(10.r)),
                    image: DecorationImage(
                      image: NetworkImage('$url${product.mainImage}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Visibility(
                  visible: product.hasDiscount,
                  replacement: SizedBox(height: 10.h,),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 8.0.h, start: 8.0.w, end: 8.0.w),
                    child: Text(
                      '${product.discountPercent}',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Text(
                    '${product.metaTitle}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90.h,
                        child: Text(
                          '${product.price} ${product.currency.code}',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 40.w,
                        child: Visibility(
                          visible: product.hasDiscount,
                          replacement: const SizedBox(),
                          child: Text(
                            '${product.originalPrice}',
                            maxLines: 1,
                            style: TextStyle(
                              color:Colors.grey[500],
                              fontSize: 12.sp,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: EdgeInsetsDirectional.only(start: 8.0.w, end: 8.0.w, bottom: 8.0.h, top: 4.0.h),
                //   child: Row(
                //     children: [
                //       _buildRatingStars(product.rating),
                //       SizedBox(width: 4.w),
                //       Text(
                //         '${product.rating}',
                //         style: TextStyle(
                //           color: Colors.white70,
                //           fontSize: 12.sp,
                //         ),
                //       ),
                //       SizedBox(width: 4.w),
                //       Text(
                //         '(${product.ratingCount})',
                //         style: TextStyle(
                //           color: Colors.white70,
                //           fontSize: 12.sp,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: BlocBuilder<FavoriteCubit, Map<int, bool>>(
            builder: (context, state) {
              final isFavorite = state[product.productVariantId] ?? false;
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: ()async {
                   await context.read<FavoriteCubit>().toggleFavorite(product.productVariantId ,context);
                    if(screen == 'favorite'){
                      MainCubit.get(context).getFavoriteItem();
                    }
                  },
                );
            },
          ),
        ),
      ],
    );
  }



  Widget _buildRatingStars(var rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}
