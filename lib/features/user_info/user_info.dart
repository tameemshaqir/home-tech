import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:ecommerce/data/models/user_models/user_data_model.dart';
import 'package:ecommerce/features/user_info/components/profile_field.dart';
import 'package:ecommerce/features/user_info/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUserData(context: context),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if(state is LoadingGetUserDataState){
            return const Center(child: CircularProgressIndicator(),);
          }
          UserDataModel? model = UserCubit.get(context).userDataModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile'.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: () {
                      navigateTo(context, UpdateProfileScreen(model: model?.data));
                    },
                    child: Text(
                      'Edit'.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ))
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35.r,
                          backgroundImage: const AssetImage(
                              'assets/images/man-avatar.png'),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model?.data.name}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            // Text(
                            //   'Tameem@gmail.com',
                            //   style: TextStyle(
                            //     fontSize: 13.sp,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 24.h),

                    ProfileField(title: 'Name'.tr(), value: '${model?.data.name}',),
                    SizedBox(height: 7.h,),
                    ProfileField(
                      title: 'currency'.tr(), value: '${model?.data.currency.name}',),
                    SizedBox(height: 7.h,),
                    ProfileField(title: 'City'.tr(), value: '${model?.data.partner.city}',),
                    SizedBox(height: 7.h,),
                    ProfileField(
                      title: 'Street'.tr(), value: '${model?.data.partner.street}',),
                    SizedBox(height: 7.h,),
                    ProfileField(
                      title: 'Street2'.tr(), value: '${model?.data.partner.street2}',),
                    SizedBox(height: 7.h,),
                    ProfileField(
                      title: 'Phone number'.tr(), value: '${model?.data.login}',),
                    SizedBox(height: 7.h,),
                    ProfileField(
                      title: 'Password'.tr(),
                      value: 'Change Password'.tr(),
                      notButton: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
