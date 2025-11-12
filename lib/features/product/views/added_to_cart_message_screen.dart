import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/entry_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../core/constants/constants.dart';

class AddedToCartMessageScreen extends StatelessWidget {
  const AddedToCartMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if(state is LoadingAddCartItemState){
            return const Center(child: CircularProgressIndicator(),);
          }else if(state is SuccessAddCartItemState){
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding.w),
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      "assets/Illustration/success_dark.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    const Spacer(flex: 2),
                    Text(
                      "Added to cart".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: defaultPadding.h / 2),
                    const Text(
                      "Click the checkout button to complete the purchase process.",
                      textAlign: TextAlign.center,
                    ).tr(),
                    const Spacer(flex: 2),
                    OutlinedButton(
                      onPressed: () {
                        MainCubit.get(context).quantity = 1;
                        MainCubit.get(context).totalPrice = null;
                        MainCubit.get(context).currentIndex = 0;
                        navigateAndFinish(context, const EntryPoint());
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(color: Colors.grey.shade800, width: 1.5),
                        ),
                        foregroundColor: MaterialStateProperty.all(primaryColor),
                      ),
                      child: const Text(
                        "Continue shopping",
                        style: TextStyle(color: primaryColor),
                      ).tr(),
                    ),
                    SizedBox(height: defaultPadding.h),
                    ElevatedButton(
                      onPressed: () {
                        MainCubit.get(context).quantity = 1;
                        MainCubit.get(context).totalPrice = null;
                        MainCubit.get(context).currentIndex = 2;
                        navigateAndFinish(context, const EntryPoint());
                      },
                      child: const Text("Checkout"),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          }else{
            return const Center(child:Text('Try again'));
          }
        },
      ),
    );
  }
}
