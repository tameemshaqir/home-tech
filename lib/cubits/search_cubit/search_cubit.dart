import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/services/dio_api.dart';
import 'package:ecommerce/cubits/search_cubit/search_state.dart';
import 'package:ecommerce/data/models/search_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  bool showFilters = false;
  String? priceError;
  String? searchQuery = '' ;
  double priceMin = 0;
  double priceMax = 0;
  bool hasActiveFilters = false ;
  // void updateSearchQuery(String query) {
  //   emit(state.copyWith(searchQuery: query));
  // }


  void clearSearch() {
    searchQuery = '' ;
    emit(ClearSearchTextState());
  }

  void activeFilters(){
    if(!hasActiveFilters) {
      hasActiveFilters = !hasActiveFilters;
      emit(ChangeActiveFiltersState());
    }
  }

  void toggleFilters() {
    showFilters = !showFilters;
    emit(ShowSearchFilterState());
  }


  bool checkFilters(String minPrice , String maxPrice){
    final _minPrice = double.tryParse(minPrice) ?? 0;
    final _maxPrice = double.tryParse(maxPrice) ?? 0;
    if(_minPrice < 0){
      priceError = 'Min price must be greater than or equal to zero.'.tr();
      emit(PriceErrorState());
      return false;
    }else if (_maxPrice < _minPrice && _maxPrice != 0){
      priceError = 'The min price must be less than the max price.'.tr();
      emit(PriceErrorState());
      return false;
    }
    priceError = null;
    priceMin = _minPrice;
    priceMax = _maxPrice;
    return true;
  }



  Future<void> clearFilters() async {
    priceMax = 0;
    priceMin = 0;
    hasActiveFilters = false;
    emit(ClearFiltersState());
  }




  SearchProductListModel? searchProductListModel;

  Future<void> getSearchProduct ({
    required String q,
}) async {
    emit(LoadingGetSearchProductState());
    try {
      Response response = await DioHelper.getData(
        url: '/api/products?q=$q&price_max=$priceMax&price_min=$priceMin',
      );

      searchProductListModel = SearchProductListModel.fromJson(response.data);

      emit(SuccessGetSearchProductState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetSearchProductState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetSearchProductState());
    }
  }


  void sortProductsByPriceAscending() {
    searchProductListModel?.data?.products?.sort((a, b) {
      // التعامل مع null
      final priceA = a.price ?? double.infinity;
      final priceB = b.price ?? double.infinity;
      return priceA.compareTo(priceB);
    });
    emit(SortProductsByPriceAscendingState());
  }


  void sortProductsByPriceDescending() {
    searchProductListModel?.data?.products?.sort((a, b) {
      final priceA = a.price ?? double.negativeInfinity;
      final priceB = b.price ?? double.negativeInfinity;
      return priceB.compareTo(priceA);
    });
    emit(SortProductsByPriceDescendingState());
  }


}