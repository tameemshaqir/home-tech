class EcashPaymentModel {
  final String terminalKey;
  final String merchantKey;
  final String merchantSecret;
  final double amount;
  final String currency;
  final String orderRef;
  final String callbackUrl;
  final String redirectUrl;
  final String language;

  EcashPaymentModel({
    required this.terminalKey,
    required this.merchantKey,
    required this.merchantSecret,
    required this.amount,
    this.currency = 'SYP',
    required this.orderRef,
    required this.callbackUrl,
    required this.redirectUrl,
    this.language = 'AR',
  });

  Map<String, dynamic> toJson() {
    return {
      'terminalKey': terminalKey,
      'merchantKey': merchantKey,
      'amount': amount,
      'currency': currency,
      'orderRef': orderRef,
      'callbackUrl': callbackUrl,
      'redirectUrl': redirectUrl,
      'language': language,
    };
  }
}
