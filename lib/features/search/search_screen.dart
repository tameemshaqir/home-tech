import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:ecommerce/features/search/components/filters_section.dart';
import 'package:ecommerce/features/search/components/results_section.dart';
import 'package:ecommerce/features/search/components/search_bar_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/sort_option.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(
          'Research and exploration'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        actions: [

            IconButton(onPressed: (){
              showSortOptions(context,['Price: Low to High'.tr(),
                'Price: High to Low'.tr(),] , '');

            }, icon: Icon(Icons.sort))
        ],
      ),
      body: Column(
        children: [
          SearchBarSection(),
          const FiltersSection(),
          const Expanded(child: ResultsSection()),
        ],
      ),
    );
  }
}