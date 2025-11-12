import 'package:ecommerce/features/home/components/products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/main_cubit/main_cubit.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            if (state is LoadingGetCategoryProductsState) {
              return const Center(child: CircularProgressIndicator(),);
            } else {
              var products = MainCubit
                  .get(context)
                  .categoryProductsModel;
              print('dddddddddddddd${products?.data.productCount}');
              return SingleChildScrollView(
                  child: HomeProductsSection(products: products?.data.products,)
              );
            }
          },
        ),
      ),
    );
  }
}
