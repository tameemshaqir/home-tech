import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/route_constants.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:ecommerce/features/user_info/components/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Set New Password'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              SizedBox(height: defaultPadding.h * 2),
              TextFormField(
                controller: currentPasswordController,
                validator: passwordValidator.call,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Current password".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Lock.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h),
              TextFormField(
                controller: newPasswordController,
                validator: passwordValidator.call,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "New password".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Lock.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h),
              TextFormField(
                controller: confirmNewPasswordController,
                validator: passwordValidator.call,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm new password".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Lock.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h,),
              BlocProvider(
                create: (context) => UserCubit(),
                child: BlocConsumer<UserCubit, UserStates>(
                  listener: (context, state) {
                    if(state is SuccessChangePasswordState){
                      navigateAndFinish(context, const SuccessScreen());
                    }
                  },
                  builder: (context, state) {
                    if(state is LoadingChangePasswordState){
                      return const Center(child: CircularProgressIndicator(),);
                    }else{
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            UserCubit.get(context).postChangePassword(context: context, currentPassword: currentPasswordController.text, newPassword: newPasswordController.text, confirmNewPassword: confirmNewPasswordController.text);
                          }
                          navigateTo(context, SuccessScreen());
                        },
                        child: const Text("Change Password").tr(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
