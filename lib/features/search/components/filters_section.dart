import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/cubits/search_cubit/search_state.dart';
import 'package:ecommerce/features/search/components/price_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: SearchCubit.get(context).showFilters ? 200.h : 0,
          child: SingleChildScrollView(
            child: Container(
              color:const Color(0xFF1E1E1E),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (SearchCubit.get(context).showFilters) ...[
                    Divider(height: 1.h, color: Colors.grey[600]),
                    SizedBox(height: 16.h),
                    PriceFilterWidget(),
                    SizedBox(height: 16.h),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}