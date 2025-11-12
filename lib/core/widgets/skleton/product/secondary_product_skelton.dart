import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../skelton.dart';

class SeconderyProductSkelton extends StatelessWidget {
   SeconderyProductSkelton({
    super.key,
    this.isSmall = false,
  });

  final bool isSmall;
   final EdgeInsets padding =  EdgeInsets.all(defaultPadding / 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: 114,
      width: 256,
      child: Row(
        children: [
           AspectRatio(
            aspectRatio: 1.15,
            child: Skeleton(),
          ),
           SizedBox(width: defaultPadding / 2),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: 12,
                    width: 80,
                  ),
                  const Spacer(),
                  Skeleton(),
                  if (!isSmall) SizedBox(height: defaultPadding / 2),
                  if (!isSmall) Skeleton(),
                  const Spacer(),
                   Skeleton(
                    width: 40,
                    height: 12,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
