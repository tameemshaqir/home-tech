import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/services/ecash_payment_service.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/features/auth/signup_screen.dart';
import 'package:ecommerce/features/cart/components/product_section.dart';
import 'package:ecommerce/features/cart/components/top_bar.dart';
import 'package:ecommerce/features/payment_method/components/initil_payment.dart';
import 'package:ecommerce/features/payment_method/payment_method_screen.dart';
import 'package:ecommerce/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/bottom_checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if(token == null){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/oops.png'),
              const Text('You do not have an account!').tr(),
              const Text('Create an account.').tr(),
              TextButton(onPressed: (){navigateAndFinish(context, SignUpScreen());}, child: const Text('Sign up').tr())

            ],
          ),
        ),
      );
    }
    MainCubit.get(context).getCartItem();
    return BlocBuilder <MainCubit, MainState>(
      builder: (context, state) {
        var model = MainCubit.get(context).cartItemModel?.data ;
        if(model == null){
          return const Center(child: CircularProgressIndicator(),);
        }
        return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  // Top Status Bar
                  TopBar(itemCount: model.cart.itemCount,),

                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 20.h),

                          Stack(
                              children:[

                                ProductsSection(products: model.cart.items,),

                                if(state is LoadingGetCartItemState || state is LoadingUpdateCartItemQtyState || state is LoadingDeleteCartItemState)
                                  Positioned.fill(
                                    child: AbsorbPointer( // تمنع الضغط على ما تحتها
                                      absorbing: true,
                                      child: Container(
                                        color: Colors.black.withOpacity(0.2),
                                        child:const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                          ]),

                          SizedBox(height: 100.h), // Space for bottom button
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:  Visibility(
              visible: model.cart.itemCount != 0 ,
                child: GestureDetector(
                  onTap: () async{
                    // navigateTo(context, PaymentMethodScreen());
                    initiatePayment(context);
                    EcashUsageExample.example();
                  },
                    child: BottomCheckout(totalPrice: model.cart.amountTotal , currency:model.cart.currency.code))),
        );
      },

    );
    }


}




