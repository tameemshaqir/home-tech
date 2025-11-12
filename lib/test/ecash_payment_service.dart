// ecash_payment_service.dart
// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
//
// class EcashPaymentService {
//   final String terminalKey;
//   final String merchantKey;
//   final String merchantSecret;
//   final String checkoutBaseUrl; // e.g. https://checkout.ecash-pay.com/Checkout/CardCheckout
//   final String connectTokenUrl; // e.g. https://merchants.ecash-pay.com/connect/token
//
//   EcashPaymentService({
//     required this.terminalKey,
//     required this.merchantKey,
//     required this.merchantSecret,
//     this.checkoutBaseUrl = 'https://checkout.ecash-pay.com/Checkout/CardCheckout',
//     this.connectTokenUrl = 'https://merchants.ecash-pay.com/connect/token',
//   });
//
//   /// حساب MD5 مع تحويل النتيجة إلى Uppercase hex string
//   String _md5Upper(String input) {
//     final bytes = utf8.encode(input);
//     final digest = md5.convert(bytes);
//     return digest.toString().toUpperCase();
//   }
//
//   /// بناء رابط الدفع
//   /// orderRef يمكن أن يكون فاضيًا، لكن إن استخدمته يجب أن تدرجه في الهاش.
//   String buildCheckoutUrl({
//     required String amount, // مثال "1500" (لا تضع فواصل)
//     required String lang, // "EN" أو "AR"
//     String orderRef = '',
//     required String redirectUrl, // ru
//     required String callbackUrl, // cu
//   }) {
//     // وثائق ecash تقول: VerificationCode = MD5(MerchantKey + MerchantSecret + Amount + OrderRef)
//     final raw = '$merchantKey$merchantSecret$amount$orderRef';
//     final vc = _md5Upper(raw);
//
//     // تأكد من ترميز الروابط (URL encode)
//     final ru = Uri.encodeComponent(redirectUrl);
//     final cu = Uri.encodeComponent(callbackUrl);
//     final params = [
//       'tk=${Uri.encodeQueryComponent(terminalKey)}',
//       'mid=${Uri.encodeQueryComponent(merchantKey)}',
//       'vc=${Uri.encodeQueryComponent(vc)}',
//       'c=SYP', // كما في التوثيق
//       'a=${Uri.encodeQueryComponent(amount)}',
//       'lang=${Uri.encodeQueryComponent(lang)}',
//     ];
//
//     if (orderRef.isNotEmpty) {
//       params.add('or=${Uri.encodeQueryComponent(orderRef)}');
//     }
//
//     params.add('ru=$ru');
//     params.add('cu=$cu');
//
//     return '$checkoutBaseUrl?${params.join('&')}';
//   }
//
//   /// مثال: الحصول على Bearer token لاستخدامه في Reverse/GetTransactionInfo
//   Future<String> getBearerToken({
//     required String clientId,
//     required String clientSecret,
//     required String username,
//     required String password,
//   }) async {
//     final body = {
//       'client_id': clientId,
//       'client_secret': clientSecret,
//       'grant_type': 'password',
//       'scope': 'TransactionManagementService',
//       'username': username,
//       'password': password,
//     };
//
//     final resp = await http.post(
//       Uri.parse(connectTokenUrl),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: body,
//     );
//
//     if (resp.statusCode == 200) {
//       final map = json.decode(resp.body);
//       return map['access_token'] as String;
//     } else {
//       throw Exception('Failed to get token: ${resp.statusCode} ${resp.body}');
//     }
//   }
//
//   /// توليد Token للتحقق من Callback (التحقق على السيرفر عادة)
//   /// token = MD5(MerchantId + MerchantSecret + TransactionNo + Amount + OrderRef)
//   String computeCallbackVerificationToken({
//     required String merchantId,
//     required String transactionNo,
//     required String amount,
//     String orderRef = '',
//   }) {
//     final raw = '$merchantId$merchantSecret$transactionNo$amount$orderRef';
//     return _md5Upper(raw);
//   }
// }
