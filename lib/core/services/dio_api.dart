
import 'package:dio/dio.dart';
import 'package:ecommerce/core/services/cache_helper.dart';
import 'package:ecommerce/core/utils/toast_utils.dart';
import 'package:ecommerce/data/models/auth_models/refresh_token_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: '', // Set default base URL or configure it dynamically
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 15), // Connection timeout
      receiveTimeout: const Duration(seconds: 15), // Response timeout
      headers: {
        'Content-Type': 'application/json', // Default header
        'Accept': 'application/json',

      },
    ),
  )..interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  )..interceptors.add(
    InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401) {
          print('🔐 Token expired, attempting refresh...');

          final newToken = await getRefresh();

          if (newToken != null) {
            // Update the failed request with new token
            final options = e.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';

            try {
              final clonedResponse = await dio.fetch(options);
              return handler.resolve(clonedResponse);
            } catch (fetchError) {
              return handler.reject(fetchError as DioException);
            }
          } else {
            print('⚠️ Refresh token failed, logging out...');
            // يمكنك هنا حذف التوكنات وتوجيه المستخدم لتسجيل الدخول
          }
        }

        return handler.next(e);
      },
    ),
  );


  /// Initialize Dio with a custom base URL (optional)
  static void init({required String baseUrl}) {
    dio.options.baseUrl = baseUrl;
  }

  /// GET request with error handling
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      token != null ? dio.options.headers["Authorization"] = "Bearer $token" :null ;
      return await dio.get(
        url,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }


  static Future<Response> logout() async {
    try {
      token != null ? dio.options.headers["Authorization"] = "Bearer $refreshToken" :null ;
      return await dio.get(
        '/api/logout',
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// POST request with error handling
  static Future<Response?> postData({
    required String url,
    required dynamic data,
    refreshToken
  }) async {
    try {
      if(token == null){
        return null;
      }
      if(refreshToken == null){
        token != null ? dio.options.headers["Authorization"] = "Bearer $token" :null ;
      }else{
        token != null ? dio.options.headers["Authorization"] = "Bearer $refreshToken" :null ;
      }
      return await dio.post(
        url,
        data: data,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  static Future<Response> postDataAuth({
    required String url,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  static Future<Response> deleteData({
    required String url,
    required dynamic data,
}) async {
    try {
      token != null ? dio.options.headers["Authorization"] = "Bearer $token" :null ;
      return await dio.delete(
        url,
        data: data,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  static Future<String?> getRefresh() async {
    try {
      dio.options.headers["Authorization"] = "Bearer $refreshToken";
      final response = await dio.get('/api/refresh-token');

      final refreshTokenModel = RefreshTokenModel.fromJson(response.data);
      final newToken = refreshTokenModel.data?.accessToken;
      final newRefreshToken = refreshTokenModel.data?.refreshToken;

      if (newToken != null) {
        token = newToken;
        refreshToken = newRefreshToken;
        await CacheHelper.saveData(key: 'token', value: newToken);
        await CacheHelper.saveData(key: 'refresh_token', value: newRefreshToken);
        print('🔄 Token refreshed: $token');
        return newToken;
      }
    } catch (e) {
      print('❌ Failed to refresh token: $e');
    }
    return null;
  }


  /// Generic error handler
  static void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        print('Connection Timeout: ${error.message}');
        break;
      case DioExceptionType.receiveTimeout:
        print('Receive Timeout: ${error.message}');
        break;
      case DioExceptionType.badResponse:
        print('Error Response: ${error.response?.data}');
        break;
      case DioExceptionType.sendTimeout:
        print('Send Timeout: ${error.message}');
        break;
      case DioExceptionType.cancel:
        print('Request Cancelled: ${error.message}');
        break;
      case DioExceptionType.unknown:
        print('Unexpected Error: ${error.message}');
        break;
      default:
        print('Unhandled Dio Error Type: ${error.message}');
    }
  }
}
