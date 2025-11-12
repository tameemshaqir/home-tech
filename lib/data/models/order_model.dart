class OrderModel {
  String? status;
  String? message;
  OrderData? data;
  Map<String, dynamic>? errors;

  OrderModel({this.status, this.message, this.data, this.errors});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json['status'],
    message: json['message'],
    data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
    errors: json['errors'],
  );
}

class OrderData {
  List<Order>? orders;
  Pagination? pagination;

  OrderData({this.orders, this.pagination});

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orders: json['orders'] != null
        ? List<Order>.from(json['orders'].map((x) => Order.fromJson(x)))
        : [],
    pagination: json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null,
  );
}

class Order {
  int? id;
  String? name;
  String? orderDate;
  String? orderTime;
  double? amountTotal;
  double? amountTax;
  double? amountUntaxed;
  String? state;
  int? partnerId;
  String? partnerName;
  String? invoiceStatus;
  List<OrderLine>? orderLines;
  ShippingAddress? shippingAddress;
  String? deliveryStatus;
  String? paymentStatus;
  dynamic invoices;

  Order({
    this.id,
    this.name,
    this.orderDate,
    this.orderTime,
    this.amountTotal,
    this.amountTax,
    this.amountUntaxed,
    this.state,
    this.partnerId,
    this.partnerName,
    this.invoiceStatus,
    this.orderLines,
    this.shippingAddress,
    this.deliveryStatus,
    this.paymentStatus,
    this.invoices,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'],
    name: json['name'],
    orderDate: json['order_date'],
    orderTime: json['order_time'],
    amountTotal: (json['amount_total'] ?? 0).toDouble(),
    amountTax: (json['amount_tax'] ?? 0).toDouble(),
    amountUntaxed: (json['amount_untaxed'] ?? 0).toDouble(),
    state: json['state'],
    partnerId: json['partner_id'],
    partnerName: json['partner_name'],
    invoiceStatus: json['invoice_status'],
    orderLines: json['order_lines'] != null
        ? List<OrderLine>.from(
        json['order_lines'].map((x) => OrderLine.fromJson(x)))
        : [],
    shippingAddress: json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null,
    deliveryStatus: json['delivery_status'],
    paymentStatus: json['payment_status'],
    invoices: json['invoices'],
  );
}

class OrderLine {
  int? id;
  int? productId;
  double? quantity;
  double? priceUnit;
  double? priceSubtotal;
  double? priceTotal;
  String? productName;
  String? productDefaultCode;
  double? quantityDelivered;
  double? quantityInvoiced;
  dynamic taxes;
  String? imageUrl;

  OrderLine({
    this.id,
    this.productId,
    this.quantity,
    this.priceUnit,
    this.priceSubtotal,
    this.priceTotal,
    this.productName,
    this.productDefaultCode,
    this.quantityDelivered,
    this.quantityInvoiced,
    this.taxes,
    this.imageUrl,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
    id: json['id'],
    productId: json['product_id'],
    quantity: (json['quantity'] ?? 0).toDouble(),
    priceUnit: (json['price_unit'] ?? 0).toDouble(),
    priceSubtotal: (json['price_subtotal'] ?? 0).toDouble(),
    priceTotal: (json['price_total'] ?? 0).toDouble(),
    productName: json['product_name'],
    productDefaultCode: json['product_default_code'],
    quantityDelivered: (json['quantity_delivered'] ?? 0).toDouble(),
    quantityInvoiced: (json['quantity_invoiced'] ?? 0).toDouble(),
    taxes: json['taxes'],
    imageUrl: json['image_url'],
  );
}

class ShippingAddress {
  int? id;
  String? name;
  String? street;
  String? city;
  String? street2;
  String? zip;
  String? country;
  String? state;
  String? phone;

  ShippingAddress({
    this.id,
    this.name,
    this.street,
    this.city,
    this.street2,
    this.zip,
    this.country,
    this.state,
    this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json['id'],
        name: json['name'],
        street: json['street'],
        city: json['city'],
        street2: json['street2'],
        zip: json['zip'],
        country: json['country'],
        state: json['state'],
        phone: json['phone'],
      );
}

class Pagination {
  int? page;
  int? limit;
  int? totalCount;
  int? totalPages;
  bool? hasNext;
  bool? hasPrev;

  Pagination({
    this.page,
    this.limit,
    this.totalCount,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json['page'],
    limit: json['limit'],
    totalCount: json['total_count'],
    totalPages: json['total_pages'],
    hasNext: json['has_next'],
    hasPrev: json['has_prev'],
  );
}
