import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/constants.dart';

Future<void> pickImage(BuildContext context ,) async {
  final userCubit = UserCubit.get(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  Container(
                    height: 4.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: whileColor20,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Select Image'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildImageOption(
                        icon: Icons.photo_camera,
                        title: 'Camera'.tr(),
                        onTap: () async {
                          Navigator.pop(context);
                          final image = await userCubit.picker.pickImage(source: ImageSource.camera);
                          if (image != null) {

                            userCubit.changeSelectedImage(File(image.path));

                          }
                        },
                      ),
                      buildImageOption(
                        icon: Icons.photo_library,
                        title: 'Gallery'.tr(),
                        onTap: () async {
                          Navigator.pop(context);
                          final image = await userCubit.picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            userCubit.base64Image = image.name ;
                            userCubit.changeSelectedImage(File(image.path));

                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildImageOption({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: primaryMaterialColor.shade600),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    ),
  );
}