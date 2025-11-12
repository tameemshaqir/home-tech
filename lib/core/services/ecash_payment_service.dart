import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecommerce/core/services/dio_api.dart';
import 'package:ecommerce/data/models/ecash_model.dart';

class EcashPaymentService {
  static const String stagingUrl = 'https://checkout.ecash-pay.co';
  static const String liveUrl = 'https://checkout.ecash-pay.com';
  static const String stagingMerchantUrl = 'https://merchants.ecash-pay.co';
  static const String liveMerchantUrl = 'https://merchants.ecash-pay.com';

  // اختر البيئة المناسبة
  static const String baseUrl = stagingUrl; // غيّر إلى liveUrl للإنتاج
  static const String merchantBaseUrl = stagingMerchantUrl;

  /// توليد كود التحقق VerificationCode
  static String generateVerificationCode({
    required String merchantKey,
    required String merchantSecret,
    required double amount,
    required String orderRef,
  }) {
    final data = '$merchantKey$merchantSecret${amount.toStringAsFixed(0)}$orderRef';
    final bytes = utf8.encode(data);
    final digest = md5.convert(bytes);
    return digest.toString().toUpperCase();
  }

  /// بناء رابط الدفع
  static String buildPaymentUrl(EcashPaymentModel payment) {
    final verificationCode = generateVerificationCode(
      merchantKey: payment.merchantKey,
      merchantSecret: payment.merchantSecret,
      amount: payment.amount,
      orderRef: payment.orderRef,
    );

    final encodedRedirectUrl = Uri.encodeComponent(payment.redirectUrl);
    final encodedCallbackUrl = Uri.encodeComponent(payment.callbackUrl);

    return '$baseUrl/Checkout/CardCheckout'
        '?tk=${payment.terminalKey}'
        '&mid=${payment.merchantKey}'
        '&vc=$verificationCode'
        '&c=${payment.currency}'
        '&a=${payment.amount.toStringAsFixed(0)}'
        '&lang=${payment.language}'
        '&or=${payment.orderRef}'
        '&ru=$encodedRedirectUrl'
        '&cu=$encodedCallbackUrl';
  }

  /// التحقق من صحة بيانات الدفع
  static bool validatePaymentData(EcashPaymentModel payment) {
    return payment.terminalKey.isNotEmpty &&
        payment.merchantKey.isNotEmpty &&
        payment.merchantSecret.isNotEmpty &&
        payment.amount > 0 &&
        payment.orderRef.isNotEmpty;
  }

  /// جلب Bearer Token
  static Future<String?> getBearerToken({
    required String clientId,
    required String clientSecret,
    required String username,
    required String password,
  }) async {
    try {
      final data = {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'password',
        'scope': 'TransactionManagementService',
        'username': username,
        'password': password,
      };

      final response = await DioHelper.postDataAuth(
        url: '$merchantBaseUrl/connect/token',
        data: data,
      );

      return response.data['access_token'];
    } catch (e) {
      print('❌ Failed to get bearer token: $e');
      return null;
    }
  }

  /// Reverse Transaction
  static Future<bool> reverseTransaction({
    required String bearerToken,
    required String transactionNo,
  }) async {
    try {
      final response = await DioHelper.postDataAuth(
        url: '$merchantBaseUrl/api/transaction-management-service/Public/MerchantTransaction/ReverseTransaction',
        data: {'transactionNo': transactionNo},
      );

      return response.statusCode == 204;
    } catch (e) {
      print('❌ Reverse transaction failed: $e');
      return false;
    }
  }

  /// Get Transaction Info
  static Future<Map<String, dynamic>?> getTransactionInfo({
    required String transactionNo,
  }) async {
    try {
      final response = await DioHelper.getData(
        url: '$merchantBaseUrl/api/transaction-management-service/Public/MerchantTransaction/GetTransactionInfoAsync',
        queryParameters: {'transactionNo': transactionNo},
      );
      return response.data;
    } catch (e) {
      print('❌ Get transaction info failed: $e');
      return null;
    }
  }
}
