import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final countryIdController = TextEditingController();
  final streetController = TextEditingController();
  final street2Controller = TextEditingController();
  final addressNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.0.r),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: addressNameController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Address name is required'.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Address name".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: Icon(
                      Icons.edit_location_alt_outlined ,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h),
              TextFormField(
                controller: streetController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Street is required'.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Street".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: Icon(
                      Icons.location_on_outlined ,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h),
              TextFormField(
                controller: street2Controller,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Street2 is required'.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Street2".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: Icon(
                      Icons.location_on_outlined ,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'City is required'.tr();
                  }
                  return null;
                },
                controller: cityController,
                decoration: InputDecoration(
                  hintText: "City".tr(),
                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: Icon(Icons.location_city_outlined , color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding.h),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                validator: phoneValidator.call,
                decoration: InputDecoration(
                  hintText: "Phone number".tr(),

                  prefixIcon: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: defaultPadding.r * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Call.svg",
                      height: 24.h,
                      width: 24.w,
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
              BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  if(state is LoadingAddAddressState){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        MainCubit.get(context).addAddress(name: addressNameController.text, street: streetController.text, street2: street2Controller.text, city: cityController.text, phone: phoneNumberController.text, context: context);
                      }
                    },
                    child: const Text("Save Address").tr(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
