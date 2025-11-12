import 'package:ecommerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class HomeItem extends StatelessWidget {
//   const HomeItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 5,
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: size.width * 0.45,
//           mainAxisExtent: size.height * 0.28,
//           crossAxisSpacing: 16.w,
//           mainAxisSpacing: 16.h,
//         ),
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 2,
//             color: Colors.grey[900],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16.r),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(8.r),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: AlignmentDirectional.topEnd,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12.r),
//                         child: Image.asset(
//                           'assets/images/phone.png',
//                           fit: BoxFit.cover,
//                           height: size.height * 0.16,
//                           width: double.infinity,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.favorite_border, color: whileColor40),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     '50 S.P',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     'Samsung Galaxy S23 Android smartphone.. Announced Feb 2023. Features 6.1″ display, Snapdragon 8 Gen 2 chipset, 3900 mAh battery, 512 GB storage, 8 GB RAM',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 11.sp,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
