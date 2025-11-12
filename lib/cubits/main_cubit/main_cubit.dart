import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/services/dio_api.dart';
import 'package:ecommerce/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce/data/models/address_model.dart';
import 'package:ecommerce/data/models/cart_item_model.dart';
import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/data/models/category_products_model.dart';
import 'package:ecommerce/data/models/favorite_item_model.dart';
import 'package:ecommerce/data/models/order_model.dart';
import 'package:ecommerce/data/models/price_list_model.dart';
import 'package:ecommerce/data/models/product_by_id_model.dart';
import 'package:ecommerce/data/models/products_model.dart';
import 'package:ecommerce/features/cart/cart_screen.dart';
import 'package:ecommerce/features/category/category_screen.dart';
import 'package:ecommerce/features/home/views/home_screen.dart';
import 'package:ecommerce/features/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../core/utils/toast_utils.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  final List pages =  [
    HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  void changeNavigationBarItem(int index){
    currentIndex = index;
    emit(ChangeNavigationBarItemState());
  }

  int selectedCategory = 0;

  void changeHomeCategory(){
    if(selectedCategory == 0){
      selectedCategory = 1;
    } else{
      selectedCategory = 0;
    }
    emit(ChangeHomeCategoryState());
  }

  int selectedAttributes = 0;

  void changeAttribute(int attribute){
    selectedAttributes = attribute;
    emit(ChangeAttributeState());
  }

  int quantity = 1;

  void incrementQuantity(double stockQuantity){
    if(quantity < stockQuantity){
      quantity++;
      emit(IncrementState());
    }
  }
  void decrementQuantity(){
    if(quantity > 1){
      quantity--;
      emit(DecrementState());
    }
  }

  double? totalPrice;
  void calculateTotalPrice(double price ){
    totalPrice = price * quantity ;
    emit(CalculateTotalPriceState());
  }

  String selectedPaymentMethod = 'cash';

  void changePaymentMethod(String value){
    selectedPaymentMethod = value;
    emit(selectedPaymentMethodState());
  }


  ProductsModel? productsModel;

  Future<void> getProducts({
    required BuildContext context,
  }) async
  {
    emit(LoadingGetProductsState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/products',
      );

      productsModel  = ProductsModel.fromJson(response.data);
      final products = productsModel?.data.products;
      context.read<FavoriteCubit>().initializeFavorites(products!);

      emit(SuccessGetProductsState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetProductsState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetProductsState());
    }
  }


  CategoryModel? categoryModel;

  Future<void> getCategories() async {
    emit(LoadingGetCategoriesState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/categories',
      );

      categoryModel  = CategoryModel.fromJson(response.data);

      emit(SuccessGetCategoriesState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetCategoriesState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetCategoriesState());
    }
  }


  CategoryProductsModel? categoryProductsModel;

  Future<void> getCategoryProducts({
    required int categoryId,
  }) async
  {
    emit(LoadingGetCategoryProductsState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/categories/$categoryId?include_products=true',
      );

      categoryProductsModel  = CategoryProductsModel.fromJson(response.data);
      print('test ${categoryProductsModel?.data.productCount}');

      emit(SuccessGetCategoryProductsState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetCategoryProductsState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetCategoryProductsState());
    }
  }


  CartItemModel? cartItemModel;

  Future<void> getCartItem() async {
    emit(LoadingGetCartItemState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/cart',
      );

      cartItemModel  = CartItemModel.fromJson(response.data);

      emit(SuccessGetCartItemState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetCartItemState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetCartItemState());
    }
  }


  FavoriteItemModel? favoriteItemModel;

  Future<void> getFavoriteItem() async {
    emit(LoadingFavoriteItemState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/wishlist',
      );

      favoriteItemModel  = FavoriteItemModel.fromJson(response.data);

      emit(SuccessGetFavoriteItemState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetFavoriteItemState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetFavoriteItemState());
    }
  }

  Future<void> deleteFavoriteItem({
    required int id,
  })async
  {
    emit(LoadingDeleteFavoriteItemState()); // Emit loading state
    try {
      await DioHelper.deleteData(
          url: '/api/wishlist/remove',
          data: {
            'product_id': id,
          }
      );
      emit(SuccessDeleteFavoriteItemState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorDeleteFavoriteItemState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorDeleteFavoriteItemState());
    }
  }

  Future<void> deleteCartItem({
    required int lineId,
  })async
  {
    emit(LoadingDeleteCartItemState()); // Emit loading state
    try {
      await DioHelper.deleteData(
        url: '/api/cart/remove',
        data: {
          'line_id': lineId,
        }
      );
      emit(SuccessDeleteCartItemState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorDeleteCartItemState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorDeleteCartItemState());
    }
  }

  Future<void> addCartItem({
    required int id,
  }) async
  {
    emit(LoadingAddCartItemState()); // Emit loading state

    try {

      await DioHelper.postData(
        url: '/api/cart/add',
        data: {
          "product_id": id,
          "quantity": quantity
        },
      );

      emit(SuccessAddCartItemState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorAddCartItemState());
    } catch (error) {
      print('Unexpected Error: $error');
      emit(ErrorAddCartItemState());
    }
  }


  Future<void> updateCartItemQty({
    required int id,
    required double newQuantity,
    required BuildContext context,
  }) async
  {
    emit(LoadingUpdateCartItemQtyState()); // Emit loading state

    try {

      await DioHelper.postData(
        url: '/api/cart/update_quantity',
        data: {
          "line_id": id,
          "new_quantity": newQuantity
        },
      );
      MainCubit.get(context).getCartItem();
      emit(SuccessUpdateCartItemQtyState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorUpdateCartItemQtyState());
    } catch (error) {
      print('Unexpected Error: $error');
      emit(ErrorUpdateCartItemQtyState());
    }
  }


  Future<void> postLang({
    required int langId,
    required Locale appLanguage,
    required BuildContext context,
  }) async
  {
    emit(LoadingPostLangState()); // Emit loading state

    try {


      // Make the login request
      await DioHelper.postData(
        url: '/api/user/profile/update',
        data: {
          "lang": langId,
        },
      );
      showSuccessToast(context, 'success', 'Chang language successfully.');

      await context.setLocale(appLanguage);
      Phoenix.rebirth(context);

      // Emit success state with login response
      emit(SuccessPostLangState());
    } on DioException catch (error) {
      // Handle Dio-specific errors
      showErrorToast(context, 'Error', '$error');
      print('Login Error: ${error.toString()}');
      emit(ErrorPostLangState());
    } catch (error) {
      // Handle unexpected errors
      showErrorToast(context, 'Error', '$error');
      print('Unexpected Error: $error');
      emit(ErrorPostLangState());
    }
  }

  ProductByIdModel? productByIdModel;

  Future<void> getProductDetails({
    required int id,
  }) async
  {
    emit(LoadingGetProductDetailsState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/products/$id',
      );

      productByIdModel  = ProductByIdModel.fromJson(response.data);

      emit(SuccessGetProductDetailsState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetProductDetailsState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetProductDetailsState());
    }
  }

  Future<void> addAddress({
    required String name,
    required String street,
    required String street2,
    required String city,
    required String phone,
    required BuildContext context,
  }) async
  {
    emit(LoadingAddAddressState()); // Emit loading state

    try {
      await DioHelper.postData(
        url: '/api/user/address/create',
        data: {
          "name": name,
          "street": street,
          "street2": street2,
          "city": city,
          "phone": phone,
          "country_id": 211
        },
      );
      showSuccessToast(context, 'success', 'Add address successfully.');
      MainCubit.get(context).getAddresses();
      emit(SuccessAddAddressState());
    } on DioException catch (error) {
      // Handle Dio-specific errors
      showErrorToast(context, 'Error', '${error.response?.data['message']}');
      print('Login Error: ${error.toString()}');
      emit(ErrorAddAddressState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorAddAddressState());
    }
  }



  AddressModel? addressModel;

  Future<void> getAddresses() async {
    emit(LoadingGetAddressState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/user/addresses',
      );

      addressModel  = AddressModel.fromJson(response.data);

      emit(SuccessGetAddressState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetAddressState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetAddressState());
    }
  }



  PriceListModel? priceListModel;

  Future<void> getPriceList() async {
    emit(LoadingGetPriceListState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/pricelists',
      );

      priceListModel  = PriceListModel.fromJson(response.data);

      emit(SuccessGetPriceListState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetPriceListState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetPriceListState());
    }
  }


  OrderModel? orderModel;

  Future<void> getOrders() async {
    emit(LoadingGetOrdersState());
    try {
      Response response = await DioHelper.getData(
        url: '/api/sale/orders',
      );

      orderModel  = OrderModel.fromJson(response.data);

      emit(SuccessGetOrdersState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetOrdersState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetOrdersState());
    }
  }


}
