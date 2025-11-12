import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/services/cache_helper.dart';
import 'package:ecommerce/core/services/dio_api.dart';
import 'package:ecommerce/core/utils/navigation_helper.dart';
import 'package:ecommerce/cubits/auth_cubit/auth_states.dart';
import 'package:ecommerce/data/models/auth_models/login_model.dart';
import 'package:ecommerce/entry_point.dart';
import 'package:ecommerce/features/auth/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/toast_utils.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);


  LoginModel? loginModel;

  Future<void> postLogin({
    required String phoneNumber,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState()); // Emit loading state

    try {


      // Make the login request
      Response response = await DioHelper.postDataAuth(
        url: '/api/login',
        data: {
          "login": phoneNumber,
          "password": password,
        },
      );

      loginModel = LoginModel.fromJson(response.data);
      token = loginModel?.data?.accessToken;
      refreshToken = loginModel?.data?.refreshToken;
      await CacheHelper.saveData(key: 'token', value: loginModel?.data?.accessToken);
      await CacheHelper.saveData(key: 'refresh_token', value: loginModel?.data?.refreshToken);

      print('First Activity Start Date: ${loginModel?.data?.name}');

      navigateAndFinish(context, const EntryPoint());
      // Emit success state with login response
      emit(LoginSuccessState());
    } on DioException catch (error) {
      // Handle Dio-specific errors
      _getDioErrorMessage(error, context);
      print('Login Error: ${error.toString()}');
      emit(LoginErrorState());
    } catch (error) {
      // Handle unexpected errors
      showErrorToast(context, 'Error', '$error');
      print('Unexpected Error: $error');
      emit(LoginErrorState());
    }
  }

  Future<void> postRegister({
    required String userName,
    required String phoneNumber,
    required String password,
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState()); // Emit loading state

    try {


      // Make the login request
      Response response = await DioHelper.postDataAuth(
        url: '/api/register',
        data: {
          "name": userName,
          "login": phoneNumber,
          "password": password,
        },
      );
      showSuccessToast(context, 'success', 'User registered successfully.');

      navigateAndFinish(context, LoginScreen());

      // Emit success state with login response
      emit(RegisterSuccessState());
    } on DioException catch (error) {
      // Handle Dio-specific errors
      _getDioErrorMessage(error, context);
      print('Login Error: ${error.toString()}');
      emit(RegisterErrorState());
    } catch (error) {
      // Handle unexpected errors
      showErrorToast(context, 'Error', '$error');
      print('Unexpected Error: $error');
      emit(RegisterErrorState());
    }
  }


  Future<void> logout({
    required BuildContext context
  }) async {
    emit(LogoutLoadingState()); // Emit loading state
    try {

       await DioHelper.logout();

      showSuccessToast(context, 'success', 'User logout successfully.');

       await CacheHelper.removeData(key:'token');
       await CacheHelper.removeData(key: 'refresh_token');

      navigateAndFinish(context, LoginScreen());

      // Emit success state with login response
      emit(LogoutSuccessState());
    } on DioException catch (error) {
      // Handle Dio-specific errors
      _getDioErrorMessage(error, context);
      print('Logout Error: ${error.toString()}');
      emit(LogoutErrorState());
    } catch (error) {
      // Handle unexpected errors
      showErrorToast(context, 'Error', '$error');
      print('Unexpected Error: $error');
      emit(LogoutErrorState());
    }
  }





  void _getDioErrorMessage(DioException error , BuildContext context) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        showErrorToast(context, 'Connection Error', 'Check your internet connection');
      case DioExceptionType.badResponse:
        showErrorToast(context, 'Input error', '${error.response?.data['message']}');
        break;
      case DioExceptionType.connectionError:
        showErrorToast(context, 'Connection Error', 'Check your internet connection');
        print('Unexpected Error: ${error.message}');
        break;
      default:
        print('Unhandled Dio Error Type: ${error.message}');

    }
  }

}