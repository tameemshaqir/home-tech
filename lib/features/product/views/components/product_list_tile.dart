// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../../core/constants/constants.dart';
//
// class ProductListTile extends StatelessWidget {
//   const ProductListTile({
//     super.key,
//     required this.svgSrc,
//     required this.title,
//     this.isShowBottomBorder = false,
//     required this.press,
//   });
//
//   final String svgSrc, title;
//   final bool isShowBottomBorder;
//   final VoidCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           const Divider(height: 1 , color: darkGreyColor,),
//           ListTile(
//             onTap: press,
//             minLeadingWidth: 24,
//             leading: SvgPicture.asset(
//               svgSrc,
//               height: 24.h,
//               color: Colors.white,
//             ),
//             title: Text(title , style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
//             trailing: SvgPicture.asset(
//               "assets/icons/miniRight.svg",
//               color: Theme.of(context).textTheme.bodyMedium!.color,
//             ),
//           ),
//           if (isShowBottomBorder) const Divider(height: 1 , color: darkGreyColor,),
//         ],
//       ),
//     );
//   }
// }
