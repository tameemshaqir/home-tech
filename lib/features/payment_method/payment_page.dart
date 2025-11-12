import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/services/ecash_payment_service.dart';
import 'package:ecommerce/data/models/ecash_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



class PaymentResult {
  final bool success;
  final String message;
  final String? transactionId;
  final String? orderRef;

  PaymentResult({
    required this.success,
    required this.message,
    this.transactionId,
    this.orderRef,
  });

  factory PaymentResult.fromUrl(String url) {
    final uri = Uri.parse(url);
    return PaymentResult(
      success: uri.queryParameters['success']?.toLowerCase() == 'true',
      message: uri.queryParameters['message'] ?? '',
      transactionId: uri.queryParameters['transactionId'],
      orderRef: uri.queryParameters['orderRef'],
    );
  }
}







class EcashPaymentPage extends StatefulWidget {
  final EcashPaymentModel paymentModel;
  final Function(PaymentResult result) onPaymentResult;

  const EcashPaymentPage({
    Key? key,
    required this.paymentModel,
    required this.onPaymentResult,
  }) : super(key: key);

  @override
  State<EcashPaymentPage> createState() => _EcashPaymentPageState();
}

class _EcashPaymentPageState extends State<EcashPaymentPage> {
  late final WebViewController controller;
  bool isLoading = true;
  String? errorMessage;
  double loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _validateAndInitialize();
  }

  void _validateAndInitialize() {
    if (!EcashPaymentService.validatePaymentData(widget.paymentModel)) {
      setState(() {
        errorMessage = 'بيانات الدفع غير صحيحة';
        isLoading = false;
      });
      return;
    }
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // إنشاء WebViewController مع المعاملات المحسّنة
      late final PlatformWebViewControllerCreationParams params;

      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      controller = WebViewController.fromPlatformCreationParams(params);

      // إعدادات JavaScript
      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);

      // إعدادات خاصة بـ Android
      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        final androidController = controller.platform as AndroidWebViewController;

        await androidController.setMediaPlaybackRequiresUserGesture(false);
        await androidController.setGeolocationPermissionsPromptCallbacks(
          onShowPrompt: (request) async {
            return GeolocationPermissionsResponse(
              allow: false,
              retain: false,
            );
          },
        );
      }

      // إعداد NavigationDelegate
      await controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                loadingProgress = progress / 100.0;
                isLoading = progress < 100;
              });
            }
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            if (mounted) {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });
            }
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }

            _checkForPaymentResult(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
            if (mounted) {
              setState(() {
                isLoading = false;
                errorMessage = 'خطأ في تحميل الصفحة: ${error.description}';
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigation requested to: ${request.url}');


            final url = request.url;

            if (url.startsWith('https://myapp.com/payment-success')) {
              final uri = Uri.parse(url);
              final status = uri.queryParameters['status'] ?? 'unknown';
              final transactionNo = uri.queryParameters['transactionNo'] ?? 'N/A';
              final orderRef = uri.queryParameters['orderRef'] ?? 'N/A';

              print(transactionNo);

              Navigator.pop(context); // إغلاق WebView بعد الدفع
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;


            // فحص إذا كان الرابط يحتوي على نتيجة الدفع
            // if (request.url.contains(widget.paymentModel.redirectUrl) ||
            //     request.url.contains('payment-result') ||
            //     request.url.contains('success') ||
            //     request.url.contains('failed')) {
            //   print('finishhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
            //   _checkForPaymentResult(request.url);
            // }

            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            print('URL changed to: ${change.url}');
            if (change.url != null) {
              _checkForPaymentResult(change.url!);
            }
          },
        ),
      );

      // تحميل صفحة الدفع
      final paymentUrl = EcashPaymentService.buildPaymentUrl(widget.paymentModel);
      await controller.loadRequest(Uri.parse(paymentUrl));

    } catch (e) {
      print('Error initializing WebView: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'خطأ في تحميل صفحة الدفع: $e';
        });
      }
    }
  }

  void _checkForPaymentResult(String url) {
    // فحص عدة أنماط للروابط
    if (url.contains(widget.paymentModel.redirectUrl) ||
        url.contains('success=') ||
        url.contains('failed=') ||
        url.contains('payment-result')) {

      final result = PaymentResult.fromUrl(url);
      widget.onPaymentResult(result);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _reloadPage() async {
    try {
      await controller.reload();
    } catch (e) {
      _initializeWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع الإلكتروني - ecash'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: errorMessage != null ? _initializeWebView : _reloadPage,
            tooltip: 'إعادة تحميل',
          ),
        ],
      ),
      body: Column(
        children: [
          if (isLoading && loadingProgress > 0)
            LinearProgressIndicator(
              value: loadingProgress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          Expanded(
            child: errorMessage != null
                ? _buildErrorWidget()
                : _buildWebViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              'حدث خطأ',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _initializeWebView,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة المحاولة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onPaymentResult(
                      PaymentResult(
                        success: false,
                        message: 'تم إلغاء العملية',
                      ),
                    );
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('إلغاء'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebViewWidget() {
    if (errorMessage != null) {
      return const SizedBox.shrink();
    }

    return WebViewWidget(controller: controller);
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('إلغاء العملية'),
          content: const Text('هل أنت متأكد من إلغاء عملية الدفع؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('لا'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق الحوار
                Navigator.pop(context); // إغلاق صفحة الدفع
                widget.onPaymentResult(
                  PaymentResult(
                    success: false,
                    message: 'تم إلغاء العملية من قبل المستخدم',
                  ),
                );
              },
              child: const Text('نعم'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   double selectedAmount = 1500;
//   bool isProcessing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('الدفع'),
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'تفاصيل الدفع',
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'المبلغ: ${selectedAmount.toStringAsFixed(0)} ل.س',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'العملة: الليرة السورية (SYP)',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'طريقة الدفع: ecash',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Card(
//               color: Colors.blue[50],
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'بيانات الاختبار:',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text('رقم البطاقة: 9760000020600002'),
//                     Text('تاريخ الانتهاء: 31/12/2026'),
//                     Text('CVV: 206'),
//                     Text('OTP: 1234'),
//                   ],
//                 ),
//               ),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: isProcessing ? null : () => _initiatePayment(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 textStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               child: isProcessing
//                   ? const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Text('جاري المعالجة...'),
//                 ],
//               )
//                   : Text('ادفع ${selectedAmount.toStringAsFixed(0)} ل.س'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _initiatePayment(BuildContext context) {
//     setState(() {
//       isProcessing = true;
//     });
//
//     final payment = EcashPaymentModel(
//       terminalKey: 'DA3EXC',
//       merchantKey: 'UFBIB8',
//       merchantSecret: 'IQN2ZJLM5AUODMMKUTWD5M4WVXLYSH92P9KGF0W68IV1FC6E72DVZEY7YK1I1KVZ',
//       amount: selectedAmount,
//       orderRef: 'ORDER_${DateTime.now().millisecondsSinceEpoch}',
//       callbackUrl: 'https://your-server.com/ecash-callback',
//       redirectUrl: 'https://your-app.com/payment-result',
//       language: 'AR',
//     );
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EcashPaymentPage(
//           paymentModel: payment,
//           onPaymentResult: (PaymentResult result) {
//             setState(() {
//               isProcessing = false;
//             });
//             _handlePaymentResult(result);
//           },
//         ),
//       ),
//     ).then((_) {
//       setState(() {
//         isProcessing = false;
//       });
//     });
//   }
//
//   void _handlePaymentResult(PaymentResult result) {
//     final color = result.success ? Colors.green : Colors.red;
//     final icon = result.success ? Icons.check_circle : Icons.error;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(icon, color: color),
//               const SizedBox(width: 8),
//               Text(result.success ? 'نجح الدفع' : 'فشل الدفع'),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(result.message),
//               if (result.transactionId != null) ...[
//                 const SizedBox(height: 8),
//                 Text('رقم المعاملة: ${result.transactionId}'),
//               ],
//               if (result.orderRef != null) ...[
//                 const SizedBox(height: 4),
//                 Text('رقم الطلب: ${result.orderRef}'),
//               ],
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('موافق'),
//             ),
//           ],
//         );
//       },
//     );
//
//     // عرض SnackBar أيضاً
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(result.success ? 'تم الدفع بنجاح!' : 'فشل في الدفع: ${result.message}'),
//         backgroundColor: color,
//         duration: const Duration(seconds: 3),
//         action: result.success
//             ? SnackBarAction(
//           label: 'عرض التفاصيل',
//           textColor: Colors.white,
//           onPressed: () {
//             // يمكن إضافة صفحة تفاصيل المعاملة هنا
//           },
//         )
//             : null,
//       ),
//     );
//   }
// }