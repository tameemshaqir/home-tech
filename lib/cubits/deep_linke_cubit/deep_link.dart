import 'package:bloc/bloc.dart';

class DeepLinkState {
  final String? productId;
  final String? affiliateId;

  DeepLinkState({this.productId, this.affiliateId});
}

class DeepLinkCubit extends Cubit<DeepLinkState> {
  DeepLinkCubit() : super(DeepLinkState());

  void handleDeepLink(Uri uri) {
    if (uri.path == '/payment-result') {
      final productId = uri.queryParameters['prod uct'];
      final affiliateId = uri.queryParameters['ref'];
      emit(DeepLinkState(productId: productId, affiliateId: affiliateId));
    }
  }
}