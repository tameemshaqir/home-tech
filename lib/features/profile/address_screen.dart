import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/utils/custom_modal_bottom_sheet.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/features/profile/components/add_address.dart';
import 'package:ecommerce/features/profile/components/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var model =  MainCubit.get(context).addressModel?.data;
        if(state is LoadingGetAddressState && model == null){
          return const Center(child: CircularProgressIndicator(),);
        }
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(14.0.r),
            child: ElevatedButton(
              onPressed: (){
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: AddAddress(),
                );
              },
              child: Text(
                'Add address'.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          appBar: AppBar(title: Text(
            'Addresses'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model?.addresses?.length,
                    itemBuilder: (context, index) {
                      return AddressCard(
                        icon: Icons.location_on_outlined,
                        iconColor: const Color(0xFF7C3AED),
                        title: '${model?.addresses?[index].name}',
                        address: '${model?.addresses?[index].street}, ${model?.addresses?[index].street2},\n${model?.addresses?[index].city}, ${model?.addresses?[index].countryId?.name},',
                        phone: '${model?.addresses?[index].phone}',
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }


}
