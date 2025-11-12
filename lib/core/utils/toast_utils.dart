import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/features/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:easy_localization/easy_localization.dart';

void showErrorToast(BuildContext context, String title, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.minimal,
    icon: const Icon(Icons.error_outline),
    title: Text(title.tr()),
    description: Text(message.tr()),
    autoCloseDuration: const Duration(seconds: 5),
    showProgressBar: false,
  );
}

void showSuccessToast(BuildContext context, String title, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    icon: const Icon(Icons.task_alt_outlined),
    title: Text(title.tr()),
    description: Text(message.tr()),
    autoCloseDuration: const Duration(seconds: 5),
    showProgressBar: false,
  );
}

void showInfoToast(BuildContext context, String title, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.info,
    style: ToastificationStyle.minimal,
    icon: const Icon(Icons.info),
    title: Text(title.tr()),
    description: Row(
      children: [
        Text(message.tr()),
        TextButton(onPressed: (){
          navigateAndFinish(context, LoginScreen());
        },
            child: const Text('Sign up').tr()
        )
      ],
    ),
    autoCloseDuration: const Duration(seconds: 5),
    showProgressBar: false,
    showIcon: true
  );
}


void showSignUpToast(BuildContext context,) {
  toastification.show(
    context: context,
    type: ToastificationType.warning,
    style: ToastificationStyle.minimal,
    icon: const Icon(Icons.warning),
    title:  Text('You do not have an account!' , style: Theme.of(context).textTheme.titleMedium,).tr(),
    description: Row(
      children: [
         Text('Create an account.',style: TextStyle(
           fontSize: 12.sp,
           color: Colors.grey.shade600
         ),).tr(),
        TextButton(onPressed: (){
          navigateAndFinish(context, LoginScreen());
        },
            child: const Text('Sign up').tr()
        )
      ],
    ),
    autoCloseDuration: const Duration(seconds: 5),
    showProgressBar: false,
  );
}