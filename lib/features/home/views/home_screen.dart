import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/features/home/components/address_bottonm.dart';
import 'package:ecommerce/features/home/components/carousel.dart';
import 'package:ecommerce/features/home/components/category_list.dart';
import 'package:ecommerce/features/home/components/category_tab.dart';
import 'package:ecommerce/features/home/components/home_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/products_section.dart';



class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900] ,
      appBar: AppBar(
        backgroundColor:Colors.grey[900] ,
        title: BlocBuilder<UserCubit, UserStates>(
          builder: (context, state) {
            if(UserCubit.get(context).userDataModel?.data.partner.country == null){
              return Text('');
            }
            return Text(
              '${UserCubit.get(context).userDataModel?.data.partner.country},${UserCubit.get(context).userDataModel?.data.partner.city},${UserCubit.get(context).userDataModel?.data.partner.street},${UserCubit.get(context).userDataModel?.data.partner.street2}',
              style: TextStyle(
                  fontSize: 18.sp,
                overflow: TextOverflow.ellipsis
              ),
            );
          },
        ),
        actions: [
          IconButton(onPressed: (){
            MainCubit.get(context).getAddresses();
            addressBottomSheet(context);
          },
        icon: Icon(Icons.keyboard_arrow_down_outlined)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const HomeSearch(),

              SizedBox(height: 15.h,),

              BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  CategoryModel? categories = MainCubit.get(context).categoryModel;
                  return CategoryList(categories: categories , showAll: false,);
                },
              ),

              SizedBox(height: 15.h),

              Visibility(
                visible: MainCubit.get(context).priceListModel != null,
                  child: Carousel(priceList: MainCubit.get(context).priceListModel?.data ,),
              ),

              SizedBox(height: 40.h),

              // قسم التصنيفات
              BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CategoryTab(index: 0,title: 'All products'.tr(), selectedCategory: MainCubit.get(context).selectedCategory,),
                        CategoryTab(index: 1,title: 'Most popular'.tr() , selectedCategory: MainCubit.get(context).selectedCategory,),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

              // عرض المنتجات حسب التصنيف
              BlocBuilder<MainCubit,MainState>(
                builder: (context, state) {
                  var products = MainCubit.get(context).productsModel;
                return  MainCubit.get(context).selectedCategory == 0
                      ? HomeProductsSection(products: products?.data.products,screen: 'Home',)
                      : HomeProductsSection(products: products?.data.products,screen: 'Home',);
              },
              )

            ],
          ),
        ),
      ),

    );
  }
}
