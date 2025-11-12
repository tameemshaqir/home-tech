import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:developer';

class EcashPaymentService {
  late Dio _dio;
  String? _bearerToken;

  // URLs للبيئات المختلفة
  static const String _stagingAuthHost = 'https://login.ecash-pay.co';
  static const String _liveAuthHost = 'https://login.ecash-pay.com';
  static const String _stagingApiHost = 'https://api.ecash-pay.co';
  static const String _liveApiHost = 'https://api.ecash-pay.com';

  final bool isLive;

  EcashPaymentService({this.isLive = false}) {
    _dio = Dio()..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// الحصول على Bearer Token
  ///
  /// [clientId] معرف العميل (مختلف عن بيانات رابط الدفع)
  /// [clientSecret] سر العميل (مختلف عن بيانات رابط الدفع)
  /// [username] اسم المستخدم لحساب التاجر
  /// [password] كلمة المرور لحساب التاجر
  Future<Map<String, dynamic>?> obtainBearerToken({
    required String clientId,
    required String clientSecret,
    required String username,
    required String password,
  }) async {
    try {
      final authHost = isLive ? _liveAuthHost : _stagingAuthHost;

      final response = await _dio.post(
        '$authHost/connect/token',
        data: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'password',
          'scope': 'TransactionManagementService',
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        // حفظ الـ Token للاستخدام في الطلبات اللاحقة
        _bearerToken = data['access_token'];

        return {
          'success': true,
          'data': data,
          'access_token': data['access_token'],
          'token_type': data['token_type'],
          'expires_in': data['expires_in'],
          'scope': data['scope'],
        };
      } else {
        return {
          'success': false,
          'error': 'فشل في الحصول على Token',
          'status_code': response.statusCode,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': _handleDioError(e),
        'dio_error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'حدث خطأ غير متوقع: ${e.toString()}',
      };
    }
  }

  /// جلب معلومات المعاملة
  ///
  /// [transactionNo] رقم المعاملة المطلوب الحصول على معلوماتها
  /// [bearerToken] الـ Token المطلوب للمصادقة (اختياري إذا تم الحصول عليه مسبقاً)
  Future<Map<String, dynamic>?> getTransactionInfo({
    required String transactionNo,
    String? bearerToken,
  }) async {
    try {
      final token = bearerToken ?? _bearerToken;

      if (token == null) {
        return {
          'success': false,
          'error': 'Bearer Token مطلوب. يرجى الحصول على Token أولاً.',
        };
      }

      final apiHost = isLive ? _liveApiHost : _stagingApiHost;

      final response = await _dio.get(
        '$apiHost/api/transaction-management-service/Public/MerchantTransaction/GetTransactionInfoAsync',
        data: {
          'transactionNo': transactionNo,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return {
          'success': true,
          'data': data,
          'transaction_info': {
            'store_name': data['storeName'],
            'channel_type': data['channelType'],
            'currency_code': data['currencyCode'],
            'amount': data['amount'],
            'description': data['description'],
            'callback_url': data['callbackURL'],
            'order_ref': data['orderRef'],
            'status': data['status'],
            'type': data['type'],
            'transaction_no': data['transactionNo'],
          },
        };
      } else {
        return {
          'success': false,
          'error': 'فشل في جلب معلومات المعاملة',
          'status_code': response.statusCode,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': _handleDioError(e),
        'dio_error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'حدث خطأ غير متوقع: ${e.toString()}',
      };
    }
  }

  /// إلغاء المعاملة
  ///
  /// [transactionNo] رقم المعاملة المطلوب إلغاؤها
  /// [bearerToken] الـ Token المطلوب للمصادقة (اختياري إذا تم الحصول عليه مسبقاً)
  Future<Map<String, dynamic>?> reverseTransaction({
    required int transactionNo,
    String? bearerToken,
  }) async {
    try {
      final token = bearerToken ?? _bearerToken;

      if (token == null) {
        return {
          'success': false,
          'error': 'Bearer Token مطلوب. يرجى الحصول على Token أولاً.',
        };
      }

      final apiHost = isLive ? _liveApiHost : _stagingApiHost;

      final response = await _dio.post(
        '$apiHost/api/transaction-management-service/Public/MerchantTransaction/ReverseTransaction',
        data: {
          'transactionNo': transactionNo,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 204) {
        return {
          'success': true,
          'message': 'تم إلغاء المعاملة بنجاح',
        };
      } else {
        return {
          'success': false,
          'error': 'فشل في إلغاء المعاملة',
          'status_code': response.statusCode,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': _handleDioError(e),
        'dio_error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'حدث خطأ غير متوقع: ${e.toString()}',
      };
    }
  }

  /// معالجة أخطاء Dio
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'انتهت مهلة الاتصال';
      case DioExceptionType.sendTimeout:
        return 'انتهت مهلة إرسال البيانات';
      case DioExceptionType.receiveTimeout:
        return 'انتهت مهلة استقبال البيانات';
      case DioExceptionType.badResponse:
        return 'استجابة خاطئة من الخادم: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'تم إلغاء الطلب';
      case DioExceptionType.connectionError:
        return 'خطأ في الاتصال بالخادم';
      default:
        return 'خطأ في الشبكة: ${e.message}';
    }
  }

  /// الحصول على الـ Token المحفوظ
  String? get bearerToken => _bearerToken;

  /// إعداد الـ Token يدوياً
  void setBearerToken(String token) {
    _bearerToken = token;
  }
}

// مثال على الاستخدام
class EcashUsageExample {
  static Future<void> example() async {
    // إنشاء خدمة ECash (staging environment)
    final ecashService = EcashPaymentService(isLive: false);

    try {
      // الحصول على Bearer Token
      final tokenResult = await ecashService.obtainBearerToken(
        username: 'Saria.zn.12@gmail.com',
        password: 'IDC=n1z\$625)',
        clientSecret: 'AB27dac8acaEF4954150bA4517C3206e4884DF00859f446FA4A813',
        clientId: 'HomeTech',
      );

      if (tokenResult?['success'] == true) {
        print('تم الحصول على Token بنجاح');
        print('Access Token: ${tokenResult?['access_token']}');
        log(tokenResult?['access_token']);

        // جلب معلومات المعاملة
        final transactionResult = await ecashService.getTransactionInfo(
          transactionNo: '265098405',
        );

        if (transactionResult?['success'] == true) {
          print('معلومات المعاملة:');
          print(transactionResult?['transaction_info']);
        } else {
          print('خطأ في جلب المعاملة: ${transactionResult?['error']}');
        }

        // إلغاء المعاملة (اختياري)
        final reverseResult = await ecashService.reverseTransaction(
          transactionNo: 0001
        );

        if (reverseResult?['success'] == true) {
          print('تم إلغاء المعاملة بنجاح');
        } else {
          print('خطأ في إلغاء المعاملة: ${reverseResult?['error']}');
        }
      } else {
        print('خطأ في الحصول على Token: ${tokenResult?['error']}');
      }
    } catch (e) {
      print('خطأ عام: $e');
    }
  }
}