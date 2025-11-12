// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../constants/constants.dart';
// import 'skleton/skelton.dart';
//
//
// class NetworkImageWithLoader extends StatelessWidget {
//   final BoxFit fit;
//
//    NetworkImageWithLoader(
//     this.src, {
//     super.key,
//     this.fit = BoxFit.cover,
//   });
//
//   final String src;
//   final double radius = defaultPadding.r;
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(radius)),
//       child: CachedNetworkImage(
//         fit: fit,
//         imageUrl: src,
//         imageBuilder: (context, imageProvider) => Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: imageProvider,
//               fit: fit,
//             ),
//           ),
//         ),
//         placeholder: (context, url) => Skeleton(),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       ),
//     );
//   }
// }
