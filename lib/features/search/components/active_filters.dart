import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/cubits/search_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveFiltersWidget extends StatelessWidget {
  const ActiveFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Applied filters:'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (SearchCubit.get(context).priceMin >= 0 )
                    Chip(
                      label: Text(
                        '${SearchCubit.get(context).priceMin}-${SearchCubit.get(context).priceMax}',
                        style: TextStyle(fontSize: 12.sp, color: Colors.deepPurple[100]),
                      ),
                      deleteIcon: Icon(Icons.close, size: 16.r, color: Colors.deepPurple[300]),
                      onDeleted: () async{
                        await SearchCubit.get(context).clearFilters();
                        SearchCubit.get(context).getSearchProduct(q: SearchCubit.get(context).searchQuery ?? '');
                      },
                      backgroundColor: Colors.deepPurple,
                      side: BorderSide(color: Colors.deepPurple[600]!),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}