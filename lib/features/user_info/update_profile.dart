import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/constants.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key, required this.model});
  final model;
  final currencyController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final street2Controller = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => UserCubit()..getCurrencies(),
  child: BlocBuilder<UserCubit, UserStates>(
  builder: (context, state) {
    if(state is LoadingGetCurrencyState ){
      return const Center(child: CircularProgressIndicator(),);
    }
    var currency = UserCubit.get(context).currencyResponse;
    var selectedCurrency = UserCubit.get(context).selectedCurrency;
    var cubit = UserCubit.get(context);
    print(currency?.data.currencies.length);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(14.0.r),
        child: SingleChildScrollView(
          child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: model.name ?? "Name".tr(),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding.h * 0.75),
                            child: Icon(Icons.person_2_outlined, size: 25.r,),
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding.h,),
                      TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                          hintText: "${model.partner.city}" ?? "City".tr(),
                          prefixIcon: Padding(
                            padding:
                            EdgeInsets.symmetric(
                                vertical: defaultPadding.h * 0.75),
                            child: Icon(
                              Icons.location_city_outlined, size: 25.r,),
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding.h,),
                      TextFormField(
                        controller: streetController,
                        decoration: InputDecoration(
                          hintText: '${model.partner.street}' ?? "Street".tr(),
                          prefixIcon: Padding(
                            padding:
                            EdgeInsets.symmetric(
                                vertical: defaultPadding.h * 0.75),
                            child: Icon(
                              Icons.location_on_outlined, size: 25.r,),
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding.h,),
                      TextFormField(
                        controller: street2Controller,
                        decoration: InputDecoration(
                          hintText: '${model.partner.street2}' ?? "Street2".tr(),
                          prefixIcon: Padding(
                            padding:
                            EdgeInsets.symmetric(
                                vertical: defaultPadding.h * 0.75),
                            child: Icon(
                              Icons.location_on_outlined, size: 25.r,),
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding.h,),
                      TextFormField(
                        controller: currencyController,
                        readOnly: true, // Make it read-only so user can't type
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogBackgroundColor: Colors.transparent,
                            animType: AnimType.scale,
                            dialogType: DialogType.noHeader,
                            body:  Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Handle bar
                                  Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    width: 40.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),

                                  // Header
                                  Padding(
                                    padding: EdgeInsets.all(20.r),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Choose the currency'.tr(),
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => Navigator.pop(context),
                                          icon: const Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(height: 1.h),

                                  // Cities list
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: currency?.data.currencies.length,
                                      itemBuilder: (context, index) {
                                        final isSelected = currency?.data.currencies[index].id == selectedCurrency;
                                        return ListTile(
                                          title: Text(
                                            '${currency?.data.currencies[index].name}  ${currency?.data.currencies[index].fullName}',
                                            style: TextStyle(
                                              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                            ),
                                          ),
                                          trailing: isSelected
                                              ? Icon(
                                            Icons.check,
                                            color: Theme.of(context).primaryColor,
                                          )
                                              : null,
                                          onTap: () {
                                            cubit.changeCurrency(currency?.data.currencies[index].id);
                                            currencyController.text = currency!.data.currencies[index].name;
                                            // setState(() {
                                            //   selectedCity = city;
                                            //   widget.controller.text = city;
                                            // });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).show();
                        },
                        decoration: InputDecoration(
                          hintText: model.currency.name ?? "Currency".tr(),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Icon(
                              Icons.currency_exchange_outlined,
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.3),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_right,
                            color: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.3),
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding.h * 2,),
                      ElevatedButton(
                          onPressed: (){
                            cubit.updateProfile(
                                context: context,
                                name: nameController.text.isEmpty ? model.name : nameController.text,
                                currency: selectedCurrency,
                                street: streetController.text.isEmpty ? model.partner.street : streetController.text,
                                street2: street2Controller.text.isEmpty ? model.partner.street2 : street2Controller.text,
                                city: cityController.text.isEmpty ? model.partner.city : cityController.text,
                            );
                          },
                          child: Text('Done'.tr()),
                      )
                    ],
                  ),
  )
    )
    );
  },
),
    );
  }

}

