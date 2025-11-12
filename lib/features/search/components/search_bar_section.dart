import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/cubits/search_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';

class SearchBarSection extends StatelessWidget {
  SearchBarSection({super.key});

  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          color: const Color(0xFF1E1E1E),
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              // Search Input
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: searchTextController,
                  onChanged: (value) {
                    SearchCubit.get(context).getSearchProduct(q: value);
                    SearchCubit.get(context).searchQuery = value;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search for products...'.tr(),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    suffixIcon: SearchCubit.get(context).searchQuery!.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey[400]),
                      onPressed: () {
                        context.read<SearchCubit>().clearSearch();
                        searchTextController.text = '';
                      }
                    )
                        : null,
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: const BorderSide(color: primaryColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: BorderSide(color: Colors.grey[600]!)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Filter Toggle Button
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.read<SearchCubit>().toggleFilters(),
                      icon: AnimatedRotation(
                        turns: SearchCubit.get(context).showFilters ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.tune),
                      ),
                      label: const Text('Filters').tr(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SearchCubit.get(context).showFilters
                            ? primaryMaterialColor[600]
                            : const Color(0xFF2D2D2D),
                        foregroundColor: SearchCubit.get(context).showFilters
                            ? Colors.white
                            : Colors.grey[300],
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  Container(
                    decoration: BoxDecoration(
                      color: primaryMaterialColor[900]?.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.read<SearchCubit>().clearFilters();
                        if(SearchCubit.get(context).searchProductListModel != null) {
                          SearchCubit.get(context).getSearchProduct(
                              q: SearchCubit
                                  .get(context)
                                  .searchQuery ?? '');
                        }
                        },
                      icon: Icon(Icons.refresh, color: primaryMaterialColor[400]),
                      tooltip: 'Clear filters'.tr(),
                    ),
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