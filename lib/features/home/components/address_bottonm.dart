import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/features/profile/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PersistentBottomSheetController addressBottomSheet(BuildContext context){
  return showBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 400.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A), // خلفية داكنة
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 10.h),
                height: 4.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              SizedBox(height: 20.h),

              // العنوان الحالي
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'current address'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              // عنوان البيت
              Visibility(
                visible: UserCubit.get(context).userDataModel?.data.partner.country != null,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          '${UserCubit.get(context).userDataModel?.data.partner.country},${UserCubit.get(context).userDataModel?.data.partner.city},${UserCubit.get(context).userDataModel?.data.partner.street},${UserCubit.get(context).userDataModel?.data.partner.street2}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // مواقعي
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'My Sites'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              // أضف عنوان جديد
              GestureDetector(
                onTap: (){
                  navigateTo(context, AddressScreen());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Text(
                        'Add a new address'.tr(),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              BlocBuilder<MainCubit , MainState>(
                builder:(context, state) {
                  if(MainCubit.get(context).addressModel == null){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          UserCubit.get(context).updateAddress(context: context,  street: '${MainCubit.get(context).addressModel?.data?.addresses?[index].street}', street2: '${MainCubit.get(context).addressModel?.data?.addresses?[index].street2}', city: '${MainCubit.get(context).addressModel?.data?.addresses?[index].city}');
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                            color: Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${MainCubit.get(context).addressModel?.data?.addresses?[index].name}'),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      '${MainCubit.get(context).addressModel?.data?.addresses?[index].city},${MainCubit.get(context).addressModel?.data?.addresses?[index].street},${MainCubit.get(context).addressModel?.data?.addresses?[index].street2}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15.h,),
                    itemCount: MainCubit.get(context).addressModel!.data!.addresses!.length,
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
    },
  );
}