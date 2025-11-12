class SearchProductListModel {
  String? status;
  String? message;
  ProductData? data;
  Map<String, dynamic>? errors;

  SearchProductListModel({this.status, this.message, this.data, this.errors});

  factory SearchProductListModel.fromJson(Map<String, dynamic> json) {
    return SearchProductListModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class ProductData {
  List<Product>? products;
  Meta? meta;

  ProductData({this.products, this.meta});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      products: (json['products'] as List?)?.map((e) => Product.fromJson(e)).toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class Meta {
  int? currentPage;
  int? perPage;
  int? total;
  int? totalPages;

  Meta({this.currentPage, this.perPage, this.total, this.totalPages});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
    );
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  List<List<Category>>? categories;
  Category? mainCategory;
  int? productVariantId;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  double? rating;
  int? ratingCount;
  List<dynamic>? tags;
  DeliveryInfo? deliveryInfo;
  double? price;
  double? originalPrice;
  bool? hasDiscount;
  String? discountPercent;
  Currency? currency;
  bool? inStock;
  double? stockQuantity;
  bool? inWishlist;
  String? mainImage;
  List<ProductImage>? images;
  List<dynamic>? attributes;
  List<Variant>? variants;
  bool? hasVariants;

  Product({
    this.id,
    this.name,
    this.description,
    this.categories,
    this.mainCategory,
    this.productVariantId,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.rating,
    this.ratingCount,
    this.tags,
    this.deliveryInfo,
    this.price,
    this.originalPrice,
    this.hasDiscount,
    this.discountPercent,
    this.currency,
    this.inStock,
    this.stockQuantity,
    this.inWishlist,
    this.mainImage,
    this.images,
    this.attributes,
    this.variants,
    this.hasVariants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categories: (json['categories'] as List?)?.map((e) => (e as List).map((i) => Category.fromJson(i)).toList()).toList(),
      mainCategory: json['main_category'] != null ? Category.fromJson(json['main_category']) : null,
      productVariantId: json['product_variant_id'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: json['rating_count'],
      tags: json['tags'],
      deliveryInfo: json['delivery_info'] != null ? DeliveryInfo.fromJson(json['delivery_info']) : null,
      price: (json['price'] as num?)?.toDouble(),
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      hasDiscount: json['has_discount'],
      discountPercent: json['discount_percent']?.toString(),
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      inStock: json['in_stock'],
      stockQuantity: (json['stock_quantity'] as num?)?.toDouble(),
      inWishlist: json['in_wishlist'],
      mainImage: json['main_image'],
      images: (json['images'] as List?)?.map((e) => ProductImage.fromJson(e)).toList(),
      attributes: json['attributes'],
      variants: (json['variants'] as List?)?.map((e) => Variant.fromJson(e)).toList(),
      hasVariants: json['has_variants'],
    );
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DeliveryInfo {
  double? weight;
  double? volume;

  DeliveryInfo({this.weight, this.volume});

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      weight: (json['weight'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toDouble(),
    );
  }
}

class Currency {
  String? code;
  String? symbol;

  Currency({this.code, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      symbol: json['symbol'],
    );
  }
}

class ProductImage {
  int? id;
  String? url;
  String? thumbnail;
  String? altText;

  ProductImage({this.id, this.url, this.thumbnail, this.altText});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      url: json['url'],
      thumbnail: json['thumbnail'],
      altText: json['alt_text'],
    );
  }
}

class Variant {
  int? id;
  String? sku;
  String? barcode;
  String? name;
  double? price;
  bool? inWishlist;
  double? originalPrice;
  bool? hasDiscount;
  double? discountPercent;
  bool? inStock;
  double? stockQuantity;
  double? weight;
  double? volume;
  List<VariantAttribute>? attributes;
  List<ProductImage>? images;

  Variant({
    this.id,
    this.sku,
    this.barcode,
    this.name,
    this.price,
    this.inWishlist,
    this.originalPrice,
    this.hasDiscount,
    this.discountPercent,
    this.inStock,
    this.stockQuantity,
    this.weight,
    this.volume,
    this.attributes,
    this.images,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      sku: json['sku'],
      barcode: json['barcode'],
      name: json['name'],
      price: (json['price'] as num?)?.toDouble(),
      inWishlist: json['in_wishlist'],
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      hasDiscount: json['has_discount'],
      discountPercent: (json['discount_percent'] as num?)?.toDouble(),
      inStock: json['in_stock'],
      stockQuantity: (json['stock_quantity'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toDouble(),
      attributes: (json['attributes'] as List?)?.map((e) => VariantAttribute.fromJson(e)).toList(),
      images: (json['images'] as List?)?.map((e) => ProductImage.fromJson(e)).toList(),
    );
  }
}

class VariantAttribute {
  int? attributeId;
  String? attributeName;
  int? valueId;
  String? valueName;
  dynamic htmlColor;
  String? imageUrl;

  VariantAttribute({
    this.attributeId,
    this.attributeName,
    this.valueId,
    this.valueName,
    this.htmlColor,
    this.imageUrl,
  });

  factory VariantAttribute.fromJson(Map<String, dynamic> json) {
    return VariantAttribute(
      attributeId: json['attribute_id'],
      attributeName: json['attribute_name'],
      valueId: json['value_id'],
      valueName: json['value_name'],
      htmlColor: json['html_color'],
      imageUrl: json['image_url'],
    );
  }
}
