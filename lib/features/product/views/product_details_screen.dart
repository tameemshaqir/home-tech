import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/cart_button.dart';
import 'package:ecommerce/core/utils/custom_modal_bottom_sheet.dart';
import 'package:ecommerce/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/constants.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, this.isProductAvailable = true});

  final bool isProductAvailable;


  @override
  Widget build(BuildContext context) {
    MainCubit.get(context).selectedAttributes = 0;
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {

        var data = MainCubit.get(context).productByIdModel?.data;

        if(data == null || state is LoadingGetProductDetailsState){
          return const Center(child: CircularProgressIndicator(),);
        }else{
          return Scaffold(
            bottomNavigationBar: data.inStock && token != null
                ? CartButton(
              price: data.price ,
              code: data.currency!.code,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: ProductBuyNowScreen(title: data.name, productVariantId: data.productVariantId!, code: data.currency!.code,  variants: data.variants,),
                );
              },
            )
                :const SizedBox(),
            /// If profuct is not available then show [NotifyMeCard]
            // NotifyMeCard(
            //   isNotify: false,
            //   onChanged: (value) {},
            // ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    actions: [
                      BlocBuilder<FavoriteCubit, Map<int, bool>>(
                        builder: (context, state) {
                          final isFavorite = state[data.productVariantId] ?? false;
                          return IconButton(
                            onPressed: ()async {
                              await context.read<FavoriteCubit>().toggleFavorite(data.productVariantId!  ,context);
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
                  ProductImages(
                    images: data.images ,
                  ),
                  ProductInfo(
                    title: data.metaTitle,
                    isAvailable: data.inStock,
                    description: data.metaDescription,
                    numOfReviews: data.ratingCount,
                  ),
                  // ProductListTile(
                  //   svgSrc: "assets/icons/Product.svg",
                  //   title: "Product Details",
                  //   press: () {
                  //     // customModalBottomSheet(
                  //     //   context,
                  //     //   height: MediaQuery.of(context).size.height * 0.92,
                  //     //   child: ProductDetailsPage(),
                  //     // );
                  //   },
                  // ),
                  // ProductListTile(
                  //   svgSrc: "assets/icons/Delivery.svg",
                  //   title: "Shipping Information",
                  //   press: () {
                  //     customModalBottomSheet(
                  //       context,
                  //       height: MediaQuery.of(context).size.height * 0.92,
                  //       child: const BuyFullKit(
                  //         images: ["assets/screens/Shipping information.png"],
                  //       ),
                  //     );
                  //   },
                  // ),
                  // ProductListTile(
                  //   svgSrc: "assets/icons/Return.svg",
                  //   title: "Returns",
                  //   isShowBottomBorder: true,
                  //   press: () {
                  //     customModalBottomSheet(
                  //       context,
                  //       height: MediaQuery.of(context).size.height * 0.92,
                  //       child: const ProductReturnsScreen(),
                  //     );
                  //   },
                  // ),
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: EdgeInsets.all(defaultPadding.r),
                  //     child: const ReviewCard(
                  //       rating: 0,
                  //       numOfReviews: 0,
                  //       numOfFiveStar: 0,
                  //       numOfFourStar: 0,
                  //       numOfThreeStar: 0,
                  //       numOfTwoStar: 0,
                  //       numOfOneStar: 0,
                  //     ),
                  //   ),
                  // ),
                  // ProductListTile(
                  //   svgSrc: "assets/icons/Chat.svg",
                  //   title: "Reviews",
                  //   isShowBottomBorder: true,
                  //   press: () {
                  //     Navigator.pushNamed(context, productReviewsScreenRoute);
                  //   },
                  // ),
                  SliverPadding(
                    padding: EdgeInsets.all(defaultPadding.r),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "You may also like".tr(),
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding.h),
                  )
                ],
              ),
            ),
          );
        }


      },
);
  }
}







// class ProductDetailsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1a1a1a),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             _buildHeader(context),
//
//             // Content
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2a2a2a),
//                   borderRadius: BorderRadiusDirectional.only(
//                     topStart: Radius.circular(24.r),
//                     topEnd: Radius.circular(24.r),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(24.r),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildStorySection(),
//                       SizedBox(height: 32.h),
//                       _buildDetailsSection(),
//                       SizedBox(height: 32.h),
//                       _buildStyleNotesSection(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               width: 40.w,
//               height: 40.h,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF333333),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//                 size: 20.r,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 'Product details',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStorySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Story',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         Text(
//           'A cool gray cap in soft corduroy. Watch me.\' By buying cotton products from Lindex, you\'re supporting more responsibly...',
//           style: TextStyle(
//             color: Colors.grey[400],
//             fontSize: 16,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDetailsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Details',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         _buildDetailItem('Materials: 100% cotton, and lining Structured'),
//         _buildDetailItem('Adjustable cotton strap closure'),
//         _buildDetailItem('High quality embroidery stitching'),
//         _buildDetailItem('Head circumference: 21" - 24" / 54-62 cm'),
//         _buildDetailItem('Embroidery stitching'),
//         _buildDetailItem('One size fits most'),
//       ],
//     );
//   }
//
//   Widget _buildDetailItem(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 6,
//             height: 6,
//             margin: EdgeInsets.only(top: 8, right: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey[400],
//               shape: BoxShape.circle,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: Colors.grey[400],
//                 fontSize: 16,
//                 height: 1.5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStyleNotesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Style Notes',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         _buildStyleNote('Style: Summer Hat'),
//         _buildStyleNote('Design: Plain'),
//         _buildStyleNote('Fabric: Jersey'),
//       ],
//     );
//   }
//
//   Widget _buildStyleNote(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: Colors.grey[400],
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
// }
