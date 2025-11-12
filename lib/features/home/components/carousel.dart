import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/data/models/price_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key, required this.priceList,});

  final List<Data>? priceList;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> imageSliders = priceList!
        .where((item) => item.imageUrl != null)
        .map((item) => Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 2.5.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          url + item.imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) =>
          const Center(child: Icon(Icons.broken_image)),
        ),
      ),
    ))
        .toList();
    return CarouselSlider(
      items: imageSliders,
      options:CarouselOptions(
        height: size.height * 0.17,
        initialPage: 0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ) ,
    );
  }
}
