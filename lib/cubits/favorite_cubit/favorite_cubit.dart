import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/services/dio_api.dart';
import 'package:ecommerce/core/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/products_model.dart';

class FavoriteCubit extends Cubit<Map<int, bool>> {
  FavoriteCubit() : super({});

  /// تحميل حالة المفضلة من المنتج مباشرة عند بداية التطبيق أو عند تحميل المنتجات
  void initializeFavorites(List<Product> products) {
    final map = {
      for (var product in products) product.productVariantId: product.inWishlist
    };
    emit(map);
  }

  Future<void> toggleFavorite(int productId , context) async {
    if(token == null){
      showSignUpToast(context,);
      return;
    }
    final currentStatus = state[productId] ?? false;

    // Optimistic update
    emit({...state, productId: !currentStatus});

    try {
      if (!currentStatus) {
        await DioHelper.postData(url: "/api/wishlist/add", data: {'product_id': productId});
      } else {
        await DioHelper.deleteData(url: "/api/wishlist/remove", data: {'product_id': productId});
      }
    } catch (e) {
      // Revert back in case of error
      emit({...state, productId: currentStatus});
    }
  }
}
