import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(
             child: Column(
               children: [
                 Image.asset(
                   "assets/Illustration/Password_dark.png",
                   height: 400,
                   width: 300,

                 ),
       
                 Text(
                     'Your password has been \n changed successfully',
                   style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 35.sp),
                 ),

                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 15.0.w , vertical: 20.h),
                   child: ElevatedButton(

                     onPressed: () {
                       Navigator.pop(context);
                     },
                     child: const Text("d").tr(),
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
    );
  }
}
