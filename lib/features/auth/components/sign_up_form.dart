import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey, required this.userNameController, required this.phoneNumberController, required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: userNameController,
            validator: addressValidator.call,
            decoration: InputDecoration(
              hintText: "Name".tr(),
              prefixIcon: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: const Icon(Icons.person_2_outlined)
              ),
            ),
          ),
          SizedBox(height: defaultPadding.h),
          TextFormField(
            controller: phoneNumberController,
            validator: phoneValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              hintText: "Phone number".tr(),
              prefixIcon: Padding(
                padding:
                     EdgeInsets.symmetric(vertical: defaultPadding.h * 0.75),
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
                     EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
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
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
