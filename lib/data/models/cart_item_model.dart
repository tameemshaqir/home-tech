class CartItemModel {
  final String status;
  final String message;
  final CartData data;
  final Map<String, dynamic> errors;

  CartItemModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: CartData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
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

class CartData {
  final Cart cart;

  CartData({
    required this.cart,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cart: Cart.fromJson(json['cart'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'cart': cart.toJson(),
  };
}

class Cart {
  final int id;
  final double amountTotal;
  final double amountUntaxed;
  final TaxInformation taxInformation;
  final Currency currency;
  final List<CartItem> items;
  final int itemCount;

  Cart({
    required this.id,
    required this.amountTotal,
    required this.amountUntaxed,
    required this.taxInformation,
    required this.currency,
    required this.items,
    required this.itemCount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int? ?? 0,
      amountTotal: (json['amount_total'] as num?)?.toDouble() ?? 0.0,
      amountUntaxed: (json['amount_untaxed'] as num?)?.toDouble() ?? 0.0,
      taxInformation:
      TaxInformation.fromJson(json['tax_information'] as Map<String, dynamic>? ?? {}),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>? ?? {}),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      itemCount: json['item_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount_total': amountTotal,
    'amount_untaxed': amountUntaxed,
    'tax_information': taxInformation.toJson(),
    'currency': currency.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'item_count': itemCount,
  };
}

class TaxInformation {
  final double totalTax;
  final List<TaxBreakdown> taxBreakdown;
  final String taxPercentageOverSubtotal;

  TaxInformation({
    required this.totalTax,
    required this.taxBreakdown,
    required this.taxPercentageOverSubtotal,
  });

  factory TaxInformation.fromJson(Map<String, dynamic> json) {
    return TaxInformation(
      totalTax: (json['total_tax'] as num?)?.toDouble() ?? 0.0,
      taxBreakdown: (json['tax_breakdown'] as List<dynamic>? ?? [])
          .map((e) => TaxBreakdown.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      taxPercentageOverSubtotal: json['tax_percentage_over_subtotal'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'total_tax': totalTax,
    'tax_breakdown': taxBreakdown.map((e) => e.toJson()).toList(),
    'tax_percentage_over_subtotal': taxPercentageOverSubtotal,
  };
}

class TaxBreakdown {
  final String name;
  final double rate;
  final double amount;
  final String percentage;
  final String percentageOfTotal;

  TaxBreakdown({
    required this.name,
    required this.rate,
    required this.amount,
    required this.percentage,
    required this.percentageOfTotal,
  });

  factory TaxBreakdown.fromJson(Map<String, dynamic> json) {
    return TaxBreakdown(
      name: json['name'] as String? ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      percentage: json['percentage'] as String? ?? '',
      percentageOfTotal: json['percentage_of_total'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'rate': rate,
    'amount': amount,
    'percentage': percentage,
    'percentage_of_total': percentageOfTotal,
  };
}

class Currency {
  final String code;
  final String symbol;
  final String position;
  final int decimalPlaces;

  Currency({
    required this.code,
    required this.symbol,
    required this.position,
    required this.decimalPlaces,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      position: json['position'] as String? ?? '',
      decimalPlaces: json['decimal_places'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'symbol': symbol,
    'position': position,
    'decimal_places': decimalPlaces,
  };
}

class CartItem {
  final int id;
  final int productId;
  final String productName;
  final double quantity;
  final double priceUnit;
  final double priceTotal;
  final TaxDetails taxDetails;
  final String currency;
  final String imageUrl;
  final List<VariantAttribute> variantAttributes;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.priceUnit,
    required this.priceTotal,
    required this.taxDetails,
    required this.currency,
    required this.imageUrl,
    required this.variantAttributes,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int? ?? 0,
      productId: json['product_id'] as int? ?? 0,
      productName: json['product_name'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      priceUnit: (json['price_unit'] as num?)?.toDouble() ?? 0.0,
      priceTotal: (json['price_total'] as num?)?.toDouble() ?? 0.0,
      taxDetails: TaxDetails.fromJson(json['tax_details'] as Map<String, dynamic>? ?? {}),
      currency: json['currency'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      variantAttributes: (json['variant_attributes'] as List<dynamic>? ?? [])
          .map((e) => VariantAttribute.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'product_name': productName,
    'quantity': quantity,
    'price_unit': priceUnit,
    'price_total': priceTotal,
    'tax_details': taxDetails.toJson(),
    'currency': currency,
    'image_url': imageUrl,
    'variant_attributes': variantAttributes.map((e) => e.toJson()).toList(),
  };
}

class TaxDetails {
  final double taxAmount;
  final String taxRate;
  final bool taxIncluded;
  final List<ItemTaxBreakdown> taxBreakdown;

  TaxDetails({
    required this.taxAmount,
    required this.taxRate,
    required this.taxIncluded,
    required this.taxBreakdown,
  });

  factory TaxDetails.fromJson(Map<String, dynamic> json) {
    return TaxDetails(
      taxAmount: (json['tax_amount'] as num?)?.toDouble() ?? 0.0,
      taxRate: json['tax_rate'] as String? ?? '',
      taxIncluded: json['tax_included'] as bool? ?? false,
      taxBreakdown: (json['tax_breakdown'] as List<dynamic>? ?? [])
          .map((e) => ItemTaxBreakdown.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tax_amount': taxAmount,
    'tax_rate': taxRate,
    'tax_included': taxIncluded,
    'tax_breakdown': taxBreakdown.map((e) => e.toJson()).toList(),
  };
}

class ItemTaxBreakdown {
  final String name;
  final String rate;
  final double amount;

  ItemTaxBreakdown({
    required this.name,
    required this.rate,
    required this.amount,
  });

  factory ItemTaxBreakdown.fromJson(Map<String, dynamic> json) {
    return ItemTaxBreakdown(
      name: json['name'] as String? ?? '',
      rate: json['rate'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'rate': rate,
    'amount': amount,
  };
}

class VariantAttribute {
  final int attributeId;
  final String name;
  final String value;

  VariantAttribute({
    required this.attributeId,
    required this.name,
    required this.value,
  });

  factory VariantAttribute.fromJson(Map<String, dynamic> json) {
    return VariantAttribute(
      attributeId: json['attribute_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'attribute_id': attributeId,
    'name': name,
    'value': value,
  };
}