import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key, required this.products});

  final products;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Products List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductCard(
              product.productName.toString(),
              product.priceTotal.toString(),
              product.currency,
              product.imageUrl,
              product.quantity,
              index,
              product.id,
              context,
              product.productId
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
  Widget _buildProductCard(String title, String currentPrice, String currency, String image, double quantity, int index ,int id , BuildContext context , int productId) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsetsDirectional.symmetric( vertical: 14.r , horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network('$url$image' ,fit: BoxFit.cover,),
                ),
              ),

              SizedBox(width: 10.w),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80.w,
                          child: Text(
                            '$currentPrice $currency',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.sp,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                  ],
                ),
              ),

              SizedBox(width: 16.w),

              // Quantity Controls
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1.0) {
                          MainCubit.get(context).updateCartItemQty(id: id, newQuantity: quantity - 1 , context: context );
                        }
                      },
                      icon: Icon(Icons.remove, color: Colors.white, size: 16.r),
                      constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //TODO: شرط ما يقدر يضيفكية اكبرمن الموجود
                          MainCubit.get(context).updateCartItemQty(id: id, newQuantity: quantity + 1 , context: context);

                      },
                      icon: Icon(Icons.add, color: Colors.white, size: 16.r),
                      constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                    ),
                  ],
                ),
              ),

            ],
          ),

          // Delete Button
          PositionedDirectional(
            top: 0,
            start: 0,
            child: BlocConsumer<MainCubit, MainState>(
              listener: (context, state) {
                if(state is SuccessDeleteCartItemState){
                  MainCubit.get(context).getCartItem();
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    MainCubit.get(context).deleteCartItem(lineId: id);
                  },
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 16.r,
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }

}
