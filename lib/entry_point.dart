import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/utils/svg_icon.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class EntryPoint extends StatelessWidget {
   const EntryPoint({super.key});
   
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      var cubit = MainCubit.get(context) ;
      return Scaffold(
         body:  cubit.categoryModel != null ?
         cubit.pages[cubit.currentIndex] : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: SizedBox(
          child: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              if (index != cubit.currentIndex) {
                   cubit.changeNavigationBarItem(index);
              }
            },
            backgroundColor: const Color(0xFF101015),
            type: BottomNavigationBarType.fixed,
            // selectedLabelStyle: TextStyle(color: primaryColor),
            selectedFontSize: 12.sp,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/icons/home.png'),size: 25.r,),
                activeIcon: ImageIcon(const AssetImage('assets/icons/home.png'),size: 25.r,color: primaryColor,),
                label: "Home".tr(),
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Category.svg", context: context),
                activeIcon:
                    svgIcon("assets/icons/Category.svg", color: primaryColor ,context: context),
                label: "Category".tr(),
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Bag.svg", context: context),
                activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor, context: context),
                label: "Cart".tr(),
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Profile.svg", context: context),
                activeIcon:
                    svgIcon("assets/icons/Profile.svg", color: primaryColor, context: context),
                label: "Profile".tr(),
              ),
            ],
          ),
        ),
      );
    },
    );
  }
}
