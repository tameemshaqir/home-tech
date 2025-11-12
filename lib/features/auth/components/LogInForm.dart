import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/constants.dart';

class LogInForm extends StatelessWidget {
   LogInForm({
    super.key,
    required this.formKey, required this.phoneNumberController, required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
   final TextEditingController phoneNumberController;
   final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: phoneNumberController,
            validator: phoneValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration:  InputDecoration(
              hintText: "Phone number".tr(),
              prefixIcon: Padding(
                padding:  EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                child:const Icon(Icons.phone,),
              ),
            ),
          ),
           SizedBox(height: defaultPadding.h),
          TextFormField(
            controller: passwordController,
            validator: passwordValidator.call,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password".tr(),
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
        ],
      ),
    );
  }
}