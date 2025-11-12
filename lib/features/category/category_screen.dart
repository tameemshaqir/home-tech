import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/features/home/components/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category'.tr(),style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),centerTitle: true,),
      body: BlocConsumer<MainCubit,MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          CategoryModel? categories = MainCubit.get(context).categoryModel;
          return CategoryList(
              categories: categories,
            showAll: true,
          );
        },
      )
    );
  }
}
