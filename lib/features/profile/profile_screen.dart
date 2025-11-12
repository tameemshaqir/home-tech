import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/constants/route_constants.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/core/utils/toast_utils.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/features/affiliate/affiliate_screen.dart';
import 'package:ecommerce/features/auth/LoginScreen.dart';
import 'package:ecommerce/features/favorite/favorite_screen.dart';
import 'package:ecommerce/features/order/order_screen.dart';
import 'package:ecommerce/features/profile/address_screen.dart';
import 'package:ecommerce/features/profile/components/profile_card.dart';
import 'package:ecommerce/features/profile/components/profile_menu_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/widgets/language_dialog.dart';
import '../../te.dart';
import '../user_info/user_info.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ProfileCard(
            name: "Profile".tr(),
            email: "",
            imageSrc: 'https://images.app.goo.gl/eYw3PpB1N85YEw3K8',
            press: () {
              if(token == null){
                showSignUpToast(context);
              }else{
                navigateTo(context, const UserInfo());
              }
            },
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //       horizontal: defaultPadding, vertical: defaultPadding * 1.5),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: AspectRatio(
          //       aspectRatio: 1.8,
          //       child:
          //           NetworkImageWithLoader("https://i.imgur.com/dz0BBom.png"),
          //     ),
          //   ),
          // ),
          SizedBox(height: 20.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding.w),
            child: Text(
              "Account".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
           SizedBox(height: defaultPadding.h / 2),
          Visibility(
            visible: token == null,
              child: ProfileMenuListTile(
                text: "Login".tr(),
                svgSrc: "assets/icons/Logout.svg",
                press: () {
                  navigateAndFinish(context, LoginScreen());
                },
              ),
          ),
          ProfileMenuListTile(
            text: "Orders".tr(),
            svgSrc: "assets/icons/Order.svg",
            press: () {
              // MainCubit.get(context).getOrders();
              navigateTo(context, OrderScreen());
            },
          ),
          ProfileMenuListTile(
            text: "Favorite".tr(),
            svgSrc: "assets/icons/favorite.svg",
            press: () async{
              if(token == null){
                showSignUpToast(context);
              }else{
                await MainCubit.get(context).getFavoriteItem();
                navigateTo(context,const FavoriteScreen());
              }
            },
          ),
          ProfileMenuListTile(
            text: "Addresses".tr(),
            svgSrc: "assets/icons/Address.svg",
            press: () {
              if(token == null){
                showSignUpToast(context);
              }else {
                MainCubit.get(context).getAddresses();
                navigateTo(context, AddressScreen());
              }
            },
          ),

          SizedBox(height: defaultPadding.h ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding.w),
            child: Text(
              "Marketing".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),

          SizedBox(height: defaultPadding.h / 2),

          ProfileMenuListTile(
            text: "Affiliate".tr(),
            svgSrc: "assets/icons/affiliate.svg",
            press: () {
              // if(token == null){
              //   showSignUpToast(context);
              // }else {
              //   navigateTo(context, AffiliateScreen());
              // }
              UserCubit.get(context).getInfluencerDetails(context: context);
              navigateTo(context, SalesRepresentativePage());
            },
          ),

           SizedBox(height: defaultPadding.h),

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding.w, vertical: defaultPadding.h / 2),
            child: Text(
              "Settings".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Language".tr(),
            svgSrc: "assets/icons/Language.svg",
            press: () {
              showLanguageDialog(context);
            },
          ),
          // ProfileMenuListTile(
          //   text: "Location",
          //   svgSrc: "assets/icons/Location.svg",
          //   press: () {},
          // ),
          SizedBox(height: defaultPadding.h),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding.w, vertical: defaultPadding.h / 2),
            child: Text(
              "Help & Support".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Get Help".tr(),
            svgSrc: "assets/icons/Help.svg",
            press: () {
              Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "FAQ",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {},
            isShowDivider: false,
          ),
           SizedBox(height: defaultPadding.h),

          // Log Out
          ListTile(
            onTap: () {

              if(token == null){
                showSignUpToast(context);
              }else{
                AwesomeDialog(
                  dialogBackgroundColor: scaffoldBackgroundColor,
                  context: context,
                  dialogType: DialogType.noHeader,
                  body: Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Do you want to logout?',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ).tr(),
                        SizedBox(height: 7.h,),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              child: const Text('yes').tr(),
                              onPressed: ()async{
                                await AuthCubit.get(context).logout(context: context);
                              },
                            ),
                            SizedBox(width: 7.w,),
                            TextButton(
                              child: const Text('no').tr(),
                              onPressed: (){
                                Navigator.pop(
                                  context,
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ).show();
              }

            },
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              "assets/icons/Logout.svg",
              height: 24.h,
              width: 24.w,
              colorFilter: const ColorFilter.mode(
                errorColor,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              "Log Out".tr(),
              style: TextStyle(color: errorColor, fontSize: 14.sp, height: 1.h),
            ),
          )
        ],
      ),
    );
  }
}
