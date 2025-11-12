import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/pick_image.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:ecommerce/features/affiliate/components/affiliat_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/constants.dart';

class AffiliateScreen extends StatelessWidget {
  AffiliateScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _instagramController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Register for the affiliate marketing program'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // حقول الإدخال
              buildTextField(
                controller: _nameController,
                label: 'full_name'.tr(),
                hint: 'enter_full_name'.tr(),
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name_required'.tr();
                  }
                  return null;
                },
              ),

              buildTextField(
                controller: _emailController,
                label: 'email'.tr(),
                hint: 'email_hint'.tr(),
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email_required'.tr();
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'email_invalid'.tr();
                  }
                  return null;
                },
              ),

              buildTextField(
                controller: _phoneController,
                label: 'phone_number'.tr(),
                hint: 'phone_hint'.tr(),
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'phone_required'.tr();
                  }
                  return null;
                },
              ),

              buildTextField(
                controller: _instagramController,
                label: 'instagram_link'.tr(),
                hint: 'instagram_hint'.tr(),
                icon: Icons.link_outlined,
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'instagram_required'.tr();
                  }
                  if (!value.contains('instagram.com/')) {
                    return 'instagram_invalid'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              // لقطة شاشة لحساب الانستغرام
              BlocBuilder<UserCubit, UserStates>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: primaryMaterialColor.shade600,
                            width: 2.w,
                          ),
                        ),
                        child: UserCubit.get(context).selectedImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            UserCubit.get(context).selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : InkWell(
                          onTap: (){
                            pickImage(context);
                            },
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 40,
                                color: primaryMaterialColor.shade600,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'add_instagram_screenshot'.tr(),
                                style: TextStyle(
                                  color: primaryMaterialColor.shade600,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'tap_to_add_image'.tr(),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (UserCubit.get(context).selectedImage != null)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: TextButton.icon(
                            onPressed: (){
                              pickImage(context);
                            },
                            icon: Icon(Icons.edit, size: 18),
                            label: Text('change_image'.tr()),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.deepPurple[600],
                            ),
                          ),
                        ),

                      SizedBox(height: 40.h),

                      // زر الحفظ
                      BlocBuilder<UserCubit , UserStates>(
                        builder: (context, state) {
                          if(State is LoadingInfluencerRegisterState){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return Container(
                            width: double.infinity,
                            height: 55.h,
                            child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  UserCubit.get(context).influencerRegister(
                                      context: context,
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
                                      instagram: _instagramController.text
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryMaterialColor.shade600,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'save_info'.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              // زر تغيير الصورة إذا كانت موجودة


              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
