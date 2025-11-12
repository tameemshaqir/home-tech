class UserDataModel {
  final String status;
  final String message;
  final UserData data;
  final Map<String, dynamic> errors;

  UserDataModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: UserData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
      errors: json['errors'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
    'errors': errors,
  };
}

class UserData {
  final int id;
  final String name;
  final String login;
  final bool verified;
  final dynamic email; // Can be bool or String
  final String lang;
  final Currency currency;
  final Partner partner;

  UserData({
    required this.id,
    required this.name,
    required this.login,
    required this.verified,
    this.email,
    required this.lang,
    required this.currency,
    required this.partner,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      login: json['login'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
      email: json['email'],
      lang: json['lang'] as String? ?? '1',
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>? ?? {}),
      partner: Partner.fromJson(json['partner'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'login': login,
    'verified': verified,
    'email': email,
    'lang': lang,
    'currency': currency.toJson(),
    'partner': partner.toJson(),
  };
}

class Currency {
  final int id;
  final String name;
  final String symbol;

  Currency({
    required this.id,
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'symbol': symbol,
  };
}

class Partner {
  final int id;
  final dynamic street; // Can be bool or String
  final dynamic street2; // Can be bool or String
  final dynamic city; // Can be bool or String
  final dynamic zip; // Can be bool or String
  final dynamic country; // Can be null or object
  final String lang;
  final String imageUrl;

  Partner({
    required this.id,
    this.street,
    this.street2,
    this.city,
    this.zip,
    this.country,
    required this.lang,
    required this.imageUrl,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as int? ?? 0,
      street: json['street'],
      street2: json['street2'],
      city: json['city'],
      zip: json['zip'],
      country: json['country'],
      lang: json['lang'] as String? ?? '1',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'street': street,
    'street2': street2,
    'city': city,
    'zip': zip,
    'country': country,
    'lang': lang,
    'image_url': imageUrl,
  };
}