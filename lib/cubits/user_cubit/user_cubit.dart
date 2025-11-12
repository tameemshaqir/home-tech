import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/services/dio_api.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:ecommerce/data/models/affiliate_register_model.dart';
import 'package:ecommerce/data/models/inf_model.dart';
import 'package:ecommerce/data/models/user_models/currencies_model.dart';
import 'package:ecommerce/data/models/user_models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/toast_utils.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);


  int? selectedCurrency;

  void changeCurrency(int? cur){
    selectedCurrency = cur;
    emit(ChangeCurrencyState());
  }

  UserDataModel? userDataModel;

  Future<void> getUserData({
    required BuildContext context,
  }) async {
    emit(LoadingGetUserDataState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/me',
      );

      userDataModel  = UserDataModel.fromJson(response.data);

      emit(SuccessGetUserDataState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetUserDataState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetUserDataState());
    }
  }



  Future<void> postChangePassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(LoadingChangePasswordState()); // Emit loading state
    try {
      await DioHelper.postData(
        url: '/api/auth/update_password',
        refreshToken: refreshToken,
        data: {
          "old_password": currentPassword,
          "new_password": newPassword,
          "confirm_password": confirmNewPassword
        }
      );
      emit(SuccessChangePasswordState());
    } on DioException catch (error) {

      showErrorToast(context, 'Error', '${error.response?.data['message']['confirm_password'][0]}');
      print('Login Error: ${error.toString()}');
      emit(ErrorChangePasswordState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorChangePasswordState());
    }
  }

  Future<void> updateProfile({
    required BuildContext context,
    required String name,
    required int? currency,
    required String street,
    required String street2,
    required String city,
  }) async {
    emit(LoadingUpdateProfileState()); // Emit loading state
    try {
      await DioHelper.postData(
          url: '/api/user/profile/update',
          data: {
            "name": name,
            "currency": currency,
            "street": street,
            "street2": street2,
            "city": city
          }
      );
      showSuccessToast(context, 'Success', 'Profile information update completed successfully');
      emit(SuccessUpdateProfileState());
    } on DioException catch (error) {
      showErrorToast(context, 'Error', '${error.response?.data['message']}');
      print('Login Error: ${error.toString()}');
      emit(ErrorUpdateProfileState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorUpdateProfileState());
    }
  }


  CurrencyResponse? currencyResponse;

  Future<void> getCurrencies () async {
    emit(LoadingGetCurrencyState()); // Emit loading state
    try {
      Response response = await DioHelper.getData(
        url: '/api/currencies',
      );

      currencyResponse  = CurrencyResponse.fromJson(response.data);
      emit(SuccessGetCurrencyState());
    } on DioException catch (error) {
      print('Login Error: ${error.toString()}');
      emit(ErrorGetCurrencyState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorGetCurrencyState());
    }
  }


  Future<void> updateAddress({
    required BuildContext context,
    required String street,
    required String street2,
    required String city,
  }) async {
    emit(LoadingUpdateAddressState()); // Emit loading state
    try {
      await DioHelper.postData(
          url: '/api/user/profile/update',
          data: {
            "street": street,
            "street2": street2,
            "city": city
          }
      );
      getUserData(context: context);
      emit(SuccessUpdateAddressState());
    } on DioException catch (error) {
      showErrorToast(context, 'Error', '${error.response?.data['message']}');
      print('Login Error: ${error.toString()}');
      emit(ErrorUpdateAddressState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorUpdateAddressState());
    }
  }

  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  String? base64Image;

  Future<void> convertFileToBase64(File imageFile) async {

    List<int> imageBytes = await imageFile.readAsBytes();

     base64Image = base64Encode(imageBytes);
  }


  Future<void> changeSelectedImage(File newImage) async {
    selectedImage = newImage;
    convertFileToBase64(selectedImage!);
    emit(ChangeSelectedImageState());
  }


  AffiliateRegisterModel? affiliateRegisterModel;

  Future<void> influencerRegister({
    required BuildContext context,
    required String name,
    required String email,
    required String phone,
    required String instagram,
  }) async {
    emit(LoadingUpdateAddressState()); // Emit loading state
    try {
      print(base64Image);
     Response? response = await DioHelper.postData(
          url: '/influencer_api/register',
          data: {
            "name": name,
            "phone": phone,
            "email": email,
            "instagram_username": instagram,
            "instagram_screenshot":  selectedImage?.path != null ? base64Image  : false  ,
     }
      );

      affiliateRegisterModel = AffiliateRegisterModel.fromJson(response?.data);
      emit(SuccessUpdateAddressState());
    } on DioException catch (error) {
      showErrorToast(context, 'Error', '${error.response?.data['message']}');
      print('Login Error: ${error.toString()}');
      emit(ErrorUpdateAddressState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorUpdateAddressState());
    }

  }

  InfModel? infModel;

  Future<void> getInfluencerDetails({
    required BuildContext context,
  }) async {
    emit(LoadingInfluencerDetailsState()); // Emit loading state
    try {

      Response? response = await DioHelper.postData(
          url: '/influencer_api/influencer_details',
          data: {
            "influencer_id":735
          }
      );

      infModel = InfModel.fromJson(response?.data);
      emit(SuccessInfluencerDetailsState());
    } on DioException catch (error) {
      showErrorToast(context, 'Error', '${error.response?.data['message']}');
      print('Login Error: ${error.toString()}');
      emit(ErrorInfluencerDetailsState());
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected Error: $error');
      emit(ErrorInfluencerDetailsState());
    }

  }
}