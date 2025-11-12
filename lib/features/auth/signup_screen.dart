import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_states.dart';
import 'package:ecommerce/features/auth/LoginScreen.dart';
import 'package:ecommerce/features/auth/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/route_constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let’s get started!".tr(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        SizedBox(height: defaultPadding.h / 2),
                        const Text(
                          "Please enter your valid data in order to create an account.",
                        ).tr(),
                        SizedBox(height: defaultPadding.h),
                        SignUpForm(formKey: _formKey,passwordController:passwordController ,phoneNumberController:phoneNumberController ,userNameController: userNameController,),
                        SizedBox(height: defaultPadding.h),

                        BlocBuilder<AuthCubit,AuthStates>(
                            builder: (context, state) {
                              if (state is RegisterLoadingState){
                                return const Center(child: CircularProgressIndicator(),);
                              }
                              else{
                                return ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    AuthCubit.get(context).postRegister(
                                        userName: userNameController.text,
                                        phoneNumber: phoneNumberController.text,
                                        password: passwordController.text,
                                        context: context
                                    );
                                  }
                                },
                                child: const Text("Continue").tr(),
                              );
                              }
                            },
                        ),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Do you have an account?").tr(),
                            TextButton(
                              onPressed: () {
                                navigateAndFinish(context, LoginScreen());
                              },
                              child: const Text("Login").tr(),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );

}
}
