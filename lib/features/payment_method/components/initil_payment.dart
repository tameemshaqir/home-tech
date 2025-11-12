import 'package:ecommerce/data/models/ecash_model.dart';
import 'package:ecommerce/features/payment_method/payment_page.dart';
import 'package:flutter/material.dart';

void initiatePayment(BuildContext context) {

  final payment = EcashPaymentModel(
    terminalKey: 'DA3EXC',
    merchantKey: 'UFBIB8',
    merchantSecret: 'IQN2ZJLM5AUODMMKUTWD5M4WVXLYSH92P9KGF0W68IV1FC6E72DVZEY7YK1I1KVZ',
    amount: 2000.0,
    orderRef: 'ORDER_0.23',
    callbackUrl: 'https://your-server.com/ecash-callback',
    redirectUrl: 'https://myapp.com/payment-success',
    language: 'AR',
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EcashPaymentPage(
        paymentModel: payment,
        onPaymentResult: (PaymentResult result) {
          // عرض النتيجة للمستخدم
          final status = result.success ;
          final transactionNo = result.transactionId ?? 'N/A';
          final orderRef = result.message ?? 'N/A';
          print('ddddssssssssssssssssssssssggggggggggggggggggg: $status}');
          print(transactionNo);
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Payment Result'),
              content: Text(
                'Status: $status\nTransaction No: $transactionNo\nOrderRef: $orderRef',
              ),
            ),
          );
          // _handlePaymentResult(result , context);
        },
      ),
    ),
  ).then((_) {

  });
}

void _handlePaymentResult(PaymentResult result , BuildContext context) {
  final color = result.success ? Colors.green : Colors.red;
  final icon = result.success ? Icons.check_circle : Icons.error;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(result.success ? 'نجح الدفع' : 'فشل الدفع'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.message),
            if (result.transactionId != null) ...[
              const SizedBox(height: 8),
              Text('رقم المعاملة: ${result.transactionId}'),
            ],
            if (result.orderRef != null) ...[
              const SizedBox(height: 4),
              Text('رقم الطلب: ${result.orderRef}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      );
    },
  );

  // // عرض SnackBar أيضاً
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(result.success ? 'تم الدفع بنجاح!' : 'فشل في الدفع: ${result.message}'),
  //     backgroundColor: color,
  //     duration: const Duration(seconds: 3),
  //     action: result.success
  //         ? SnackBarAction(
  //       label: 'عرض التفاصيل',
  //       textColor: Colors.white,
  //       onPressed: () {
  //         // يمكن إضافة صفحة تفاصيل المعاملة هنا
  //       },
  //     )
  //         : null,
  //   ),
  // );
}


