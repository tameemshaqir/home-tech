import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';


class ProductImages extends StatefulWidget {
  const ProductImages({
    super.key,
    required this.images,
  });

  final images;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  late PageController _controller;

  int _currentPage = 0;

  @override
  void initState() {
    _controller =
        PageController(viewportFraction: 0.9, initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              onPageChanged: (pageNum) {
                setState(() {
                  _currentPage = pageNum;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(end: defaultPadding),
                child: ClipRRect(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(defaultBorderRadious.r * 2),
                  ),
                  child: Image.network('$url${widget.images[index].url }', fit: BoxFit.fill,),
                  // child: NetworkImageWithLoader(widget.images[index]),
                ),
              ),
            ),
            if (widget.images.length > 1)
              PositionedDirectional(
                height: 20.h,
                bottom: 24.h,
                end: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding.w * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  ),
                  child: Row(
                    children: List.generate(
                      widget.images.length,
                      (index) => Padding(
                        padding: EdgeInsetsDirectional.only(
                            end: index == (widget.images.length - 1)
                                ? 0
                                : defaultPadding.r / 4),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(index == _currentPage ? 1 : 0.2),
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
