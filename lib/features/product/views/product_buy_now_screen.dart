import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/cart_button.dart';
import 'package:ecommerce/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/features/product/views/added_to_cart_message_screen.dart';
import 'package:ecommerce/features/product/views/components/product_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/custom_modal_bottom_sheet.dart';
import 'components/product_quantity.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatelessWidget {
  const ProductBuyNowScreen({super.key, required this.title, required this.productVariantId, required this.code,  this.variants});

  final String title;
  final int productVariantId ;
  final String code;
  final variants;

  @override
  Widget build(BuildContext context) {
    MainCubit.get(context).quantity = 1;
    MainCubit.get(context).totalPrice = null;
    return BlocBuilder<MainCubit, MainState>(
  builder: (context, state) {
    return Scaffold(
      bottomNavigationBar: CartButton(
            price: MainCubit.get(context).totalPrice ?? variants[MainCubit.get(context).selectedAttributes].price,
            code: code,
            title: "Add to cart".tr(),
            subTitle: "Total price".tr(),
            press: () {
              MainCubit.get(context).addCartItem(id: variants[MainCubit.get(context).selectedAttributes].id);
              customModalBottomSheet(
                context,
                isDismissible: false,
                child: const AddedToCartMessageScreen(),
              );
            },
          ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding.w / 2, vertical: defaultPadding.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                BlocBuilder<FavoriteCubit, Map<int, bool>>(
                  builder: (context, state) {
                    final isFavorite = state[productVariantId] ?? false;
                    return IconButton(
                      onPressed: ()async {
                        await context.read<FavoriteCubit>().toggleFavorite(productVariantId ,context);
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                ProductImages(images: variants[MainCubit.get(context).selectedAttributes].images),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: variants[MainCubit.get(context).selectedAttributes].originalPrice ,
                            priceAfterDiscount: variants[MainCubit.get(context).selectedAttributes].price,
                            code: code,
                          ),
                        ),
                         ProductQuantity(
                              numOfItem: MainCubit.get(context).quantity,
                              onIncrement: () {
                                MainCubit.get(context).incrementQuantity(variants[MainCubit.get(context).selectedAttributes].stockQuantity);
                                MainCubit.get(context).calculateTotalPrice(variants[MainCubit.get(context).selectedAttributes].price);
                                },
                              onDecrement: () {
                                MainCubit.get(context).decrementQuantity();
                                MainCubit.get(context).calculateTotalPrice(variants[MainCubit.get(context).selectedAttributes].price);
                                },
                            ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverPadding(
                  padding: EdgeInsets.all(14.r),
                  sliver: SliverToBoxAdapter(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        List<Widget> rows = [];

                        for (int i = 0; i < variants.length; i += 2) {
                          List<Widget> rowChildren = [];

                          for (int j = i; j < i + 2 && j < variants.length; j++) {
                            bool isSelected = MainCubit.get(context).selectedAttributes == j;

                            rowChildren.add(
                              Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      MainCubit.get(context).changeAttribute(j);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected
                                          ? const Color(0xFF7C3AED)
                                          : const Color(0xFF2A2A2A),
                                      foregroundColor: isSelected
                                          ? Colors.white
                                          : const Color(0xFF9CA3AF),
                                      elevation: isSelected ? 8 : 2,
                                      shadowColor: isSelected
                                          ? const Color(0xFF7C3AED).withOpacity(0.5)
                                          : Colors.black.withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color: isSelected
                                              ? const Color(0xFF7C3AED)
                                              : const Color(0xFF404040),
                                          width: 2,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                    ),
                                    child: Text(
                                      '${variants[j].name}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );

                            // إضافة مسافة بين الأزرار في نفس الصف
                            if (j < i + 1 && j + 1 < variants.length) {
                              rowChildren.add(SizedBox(width: 16.w));
                            }
                          }

                          // إذا كان هناك زر واحد فقط في الصف الأخير
                          if (rowChildren.length == 1) {
                            rowChildren.add(const Expanded(child: SizedBox()));
                          }

                          rows.add(
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: rowChildren,
                              ),
                            ),
                          );

                          // إضافة مسافة بين الصفوف
                          if (i + 2 < variants.length) {
                            rows.add(SizedBox(height: 16.h));
                          }
                        }

                        return Column(children: rows);
                      },
                    ),
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    );
  },
);
  }
}

