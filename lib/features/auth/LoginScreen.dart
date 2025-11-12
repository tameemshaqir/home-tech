import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_states.dart';
import 'package:ecommerce/entry_point.dart';
import 'package:ecommerce/features/auth/components/LogInForm.dart';
import 'package:ecommerce/features/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final phoneNumberController = TextEditingController();
   final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: (){
                   navigateAndFinish(context, EntryPoint());
                },
                child: Text(
                  'Skip'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp
                ),)
            )
          ],
        ),
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
                        "Welcome".tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                       SizedBox(height: defaultPadding.h / 2),
                       Text(
                        "Log in with your data that you intered during your registration.".tr(),
                      ),
                       SizedBox(height: defaultPadding.h),

                      LogInForm(formKey: _formKey ,phoneNumberController: phoneNumberController, passwordController: passwordController, ),

                      SizedBox(
                        height: size.height > 700
                            ? size.height * 0.1
                            : defaultPadding,
                      ),
                      BlocBuilder<AuthCubit, AuthStates>(
                        builder: (context, state) {
                          if(state is LoginLoadingState){
                            return const Center(child: CircularProgressIndicator(),);
                          }else{
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(phoneNumberController.text);
                                  AuthCubit.get(context).postLogin(phoneNumber: phoneNumberController.text, password: passwordController.text, context: context);
                                }
                              },
                              child: const Text("Login").tr(),
                            );
                          }
                          },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?").tr(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:(context) => SignUpScreen()
                                ),
                              );
                            },
                            child: const Text("Sign up").tr(),
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