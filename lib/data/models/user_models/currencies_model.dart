import 'dart:convert';

class CurrencyResponse {
  final String status;
  final String message;
  final CurrencyData data;
  final Map<String, dynamic> errors;

  CurrencyResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: CurrencyData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? {},
    );
  }

  // تحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
      'errors': errors,
    };
  }

  factory CurrencyResponse.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return CurrencyResponse.fromJson(json);
  }

  // تحويل من Object إلى String JSON
  String toJsonString() {
    return jsonEncode(toJson());
  }

  @override
  String toString() {
    return 'CurrencyResponse{status: $status, message: $message, data: $data, errors: $errors}';
  }
}

class CurrencyData {
  final List<Currency> currencies;

  CurrencyData({
    required this.currencies,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((item) => Currency.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencies': currencies.map((currency) => currency.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CurrencyData{currencies: $currencies}';
  }
}

class Currency {
  final int id;
  final String name;
  final String fullName;
  final String symbol;
  final int decimalPlaces;

  Currency({
    required this.id,
    required this.name,
    required this.fullName,
    required this.symbol,
    required this.decimalPlaces,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      symbol: json['symbol'] ?? '',
      decimalPlaces: json['decimal_places'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'symbol': symbol,
      'decimal_places': decimalPlaces,
    };
  }

  @override
  String toString() {
    return 'Currency{id: $id, name: $name, fullName: $fullName, symbol: $symbol, decimalPlaces: $decimalPlaces}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Currency && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
