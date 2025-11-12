import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/features/user_info/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';

class ProfileField extends StatelessWidget {
  ProfileField( {super.key, required this.title, required this.value, this.notButton = true ,});
  final String title;
  final String value;
  final bool notButton ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: notButton,
              replacement: GestureDetector(
                onTap: (){
                  navigateTo(context, ChangePasswordScreen());
                },
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: primaryColor,
                    fontWeight:  FontWeight.w500 ,
                  ),
                ),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight:  FontWeight.w500 ,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Divider(height: 1.h, thickness: 1, color: darkGreyColor),

      ],
    );
  }
}
