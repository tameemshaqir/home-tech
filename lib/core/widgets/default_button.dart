

import 'package:ecommerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultButton (
    {
      double width = double.infinity ,
      double height = 40 ,
      bool isBag = true,
      IconData? icon ,
      required Function()? function,
      required String text,
      Color? color  ,
      double? textSize ,
    }) {
  return Container(
    height: height.h,
    width:width.w ,
    decoration: BoxDecoration(
      color: color ?? readColor,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: const[
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 0.5,
          blurRadius: 0.5,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    ),
    child: MaterialButton(
      onPressed: function,
      child: Row(
        children: [
          Expanded(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                if(icon != null)
                  Icon(icon ,color: Colors.white,size: 23),

                SizedBox(width: 6.w,),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:textSize?.sp,
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