import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/features/home/components/products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
   const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MainCubit, MainState>(
  builder: (context, state) {
    if(state is LoadingFavoriteItemState){
      return const Center(child: CircularProgressIndicator(),);
    }
    var products = MainCubit.get(context).favoriteItemModel?.data;
    return HomeProductsSection(products: products?.products,screen: 'favorite',);
  },
),
    );
  }
}
