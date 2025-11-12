import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/cubits/search_cubit/search_state.dart';
import 'package:ecommerce/features/home/components/products_section.dart';
import 'package:ecommerce/features/search/components/active_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if(state is LoadingGetSearchProductState){
          return const Center(child: CircularProgressIndicator(),);
        }
        return Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active Filters Display
              if (SearchCubit.get(context).hasActiveFilters) const ActiveFiltersWidget(),
              // Results Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: SearchCubit.get(context).searchProductListModel != null,
                    child: Text(
                      '${'Results'.tr()} (${SearchCubit.get(context).searchProductListModel?.data?.products?.length})',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Results Grid
              Expanded(
                child: HomeProductsSection(products: SearchCubit.get(context).searchProductListModel?.data?.products),
              ),
            ],
          ),
        );
      },
    );
  }
}