import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/cubits/search_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceFilterWidget extends StatelessWidget {
  PriceFilterWidget({super.key,});

  final _minPriceController = TextEditingController(text: '0');
  final _maxPriceController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price range'.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Min price'.tr(), style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
                      SizedBox(height: 4.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: TextFormField(
                          controller: _minPriceController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r),borderSide: BorderSide(color: Colors.grey[600]!)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r),borderSide: const BorderSide(color: primaryColor)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  height: 2.h,
                  width: 16.w,
                  color: Colors.grey[600],
                  margin: EdgeInsets.only(top: 20.h),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Max price'.tr(), style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
                      SizedBox(height: 4.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: TextFormField(
                          controller: _maxPriceController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r),borderSide: BorderSide(color: Colors.grey[600]!)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r),borderSide: const BorderSide(color: primaryColor)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (SearchCubit.get(context).priceError != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  SearchCubit.get(context).priceError!,
                  style: TextStyle(color: Colors.red[400], fontSize: 12.sp),
                ),
              ),

            SizedBox(height:  15.h,),

            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
                onPressed: (){
                if(SearchCubit.get(context).checkFilters(_minPriceController.text, _maxPriceController.text)) {
                  SearchCubit.get(context).toggleFilters();
                  SearchCubit.get(context).activeFilters();
                  if(SearchCubit.get(context).searchProductListModel != null){
                    SearchCubit.get(context).getSearchProduct(q:SearchCubit.get(context).searchQuery ?? '');
                  }
                }
                },
                child: Text('Done'.tr(), style: TextStyle(fontSize: 14.sp),),
            )
          ],
        );
      },
    );
  }
}