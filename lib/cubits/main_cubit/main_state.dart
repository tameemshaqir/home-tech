part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class ChangeNavigationBarItemState extends MainState {}

final class ChangeHomeCategoryState extends MainState {}

final class ChangeAttributeState extends MainState {}

final class IncrementState extends MainState {}

final class DecrementState extends MainState {}

final class CalculateTotalPriceState extends MainState {}

final class selectedPaymentMethodState extends MainState {}

final class LoadingGetProductsState extends MainState {}

final class SuccessGetProductsState extends MainState {}

final class ErrorGetProductsState extends MainState {}

final class LoadingGetCategoriesState extends MainState {}

final class SuccessGetCategoriesState extends MainState {}

final class ErrorGetCategoriesState extends MainState {}

final class LoadingGetCategoryProductsState extends MainState {}

final class SuccessGetCategoryProductsState extends MainState {}

final class ErrorGetCategoryProductsState extends MainState {}

final class LoadingGetCartItemState extends MainState {}

final class SuccessGetCartItemState extends MainState {}

final class ErrorGetCartItemState extends MainState {}

final class LoadingDeleteCartItemState extends MainState {}

final class SuccessDeleteCartItemState extends MainState {}

final class ErrorDeleteCartItemState extends MainState {}

final class LoadingFavoriteItemState extends MainState {}

final class SuccessGetFavoriteItemState extends MainState {}

final class ErrorGetFavoriteItemState extends MainState {}

final class LoadingDeleteFavoriteItemState extends MainState {}

final class SuccessDeleteFavoriteItemState extends MainState {}

final class ErrorDeleteFavoriteItemState extends MainState {}

final class LoadingPostLangState extends MainState {}

final class SuccessPostLangState extends MainState {}

final class ErrorPostLangState extends MainState {}

final class LoadingGetProductDetailsState extends MainState {}

final class SuccessGetProductDetailsState extends MainState {}

final class ErrorGetProductDetailsState extends MainState {}

final class LoadingGetPriceListState extends MainState {}

final class SuccessGetPriceListState extends MainState {}

final class ErrorGetPriceListState extends MainState {}

final class LoadingAddCartItemState extends MainState {}

final class SuccessAddCartItemState extends MainState {}

final class ErrorAddCartItemState extends MainState {}

final class LoadingUpdateCartItemQtyState extends MainState {}

final class SuccessUpdateCartItemQtyState extends MainState {}

final class ErrorUpdateCartItemQtyState extends MainState {}

final class LoadingAddAddressState extends MainState {}

final class SuccessAddAddressState extends MainState {}

final class ErrorAddAddressState extends MainState {}

final class LoadingGetAddressState extends MainState {}

final class SuccessGetAddressState extends MainState {}

final class ErrorGetAddressState extends MainState {}

final class LoadingGetOrdersState extends MainState {}

final class SuccessGetOrdersState extends MainState {}

final class ErrorGetOrdersState extends MainState {}