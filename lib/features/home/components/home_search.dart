import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/features/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.95,
      height: 40.h,
      child: TextFormField(
        onTap: (){
          navigateTo(context, const SearchScreen());
        },
        readOnly: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            borderSide: BorderSide.none,
          ),
          hintText: "Search".tr(),
          prefixIcon: Icon(Icons.search, size: 30.r,),
        ),
      ),
    );
  }
}
