class FavoriteItemModel {
  final String status;
  final String message;
  final ProductData data;
  final Map<String, dynamic> errors;

  FavoriteItemModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      status: json['status'],
      message: json['message'],
      data: ProductData.fromJson(json['data']),
      errors: Map<String, dynamic>.from(json['errors'] ?? {}),
    );
  }
}

class ProductData {
  final List<Product> products;
  final Meta meta;

  ProductData({
    required this.products,
    required this.meta,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      products: List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final List<dynamic> categories;
  final dynamic mainCategory;
  final int productVariantId;
  final String metaTitle;
  final String metaDescription;
  final String metaKeywords;
  final double rating;
  final int ratingCount;
  final List<dynamic> tags;
  final DeliveryInfo deliveryInfo;
  final double price;
  final double originalPrice;
  final bool hasDiscount;
  final String discountPercent;
  final Currency currency;
  final bool inStock;
  final double stockQuantity;
  final bool inWishlist;
  final String mainImage;
  final List<dynamic> images;
  final List<dynamic> attributes;
  final List<Variant> variants;
  final bool hasVariants;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categories,
    required this.mainCategory,
    required this.productVariantId,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaKeywords,
    required this.rating,
    required this.ratingCount,
    required this.tags,
    required this.deliveryInfo,
    required this.price,
    required this.originalPrice,
    required this.hasDiscount,
    required this.discountPercent,
    required this.currency,
    required this.inStock,
    required this.stockQuantity,
    required this.inWishlist,
    required this.mainImage,
    required this.images,
    required this.attributes,
    required this.variants,
    required this.hasVariants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categories: List<dynamic>.from(json['categories']),
      mainCategory: json['main_category'],
      productVariantId: json['product_variant_id'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      rating: (json['rating'] ?? 0).toDouble(),
      ratingCount: json['rating_count'],
      tags: List<dynamic>.from(json['tags']),
      deliveryInfo: DeliveryInfo.fromJson(json['delivery_info']),
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      hasDiscount: json['has_discount'],
      discountPercent: json['discount_percent'],
      currency: Currency.fromJson(json['currency']),
      inStock: json['in_stock'],
      stockQuantity: (json['stock_quantity'] ?? 0).toDouble(),
      inWishlist: json['in_wishlist'],
      mainImage: json['main_image'],
      images: List<dynamic>.from(json['images']),
      attributes: List<dynamic>.from(json['attributes']),
      variants: List<Variant>.from(json['variants'].map((x) => Variant.fromJson(x))),
      hasVariants: json['has_variants'],
    );
  }
}

class DeliveryInfo {
  final double weight;
  final double volume;

  DeliveryInfo({
    required this.weight,
    required this.volume,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      weight: (json['weight'] ?? 0).toDouble(),
      volume: (json['volume'] ?? 0).toDouble(),
    );
  }
}

class Currency {
  final dynamic code;
  final dynamic symbol;

  Currency({
    required this.code,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      symbol: json['symbol'],
    );
  }
}

class Variant {
  final int id;
  final String sku;
  final String barcode;
  final String name;
  final double price;
  final bool inWishlist;
  final double? originalPrice;
  final bool? hasDiscount;
  final double discountPercent;
  final bool inStock;
  final double stockQuantity;
  final double weight;
  final double volume;
  final List<dynamic> attributes;
  final List<dynamic> images;

  Variant({
    required this.id,
    required this.sku,
    required this.barcode,
    required this.name,
    required this.price,
    required this.inWishlist,
    required this.originalPrice,
    required this.hasDiscount,
    required this.discountPercent,
    required this.inStock,
    required this.stockQuantity,
    required this.weight,
    required this.volume,
    required this.attributes,
    required this.images,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      sku: json['sku'],
      barcode: json['barcode'],
      name: json['name'],
      price: (json['price'] ?? 0).toDouble(),
      inWishlist: json['in_wishlist'],
      originalPrice: json['original_price'] != null ? (json['original_price'] as num?)?.toDouble() : null,
      hasDiscount: json['has_discount'],
      discountPercent: (json['discount_percent'] ?? 0).toDouble(),
      inStock: json['in_stock'],
      stockQuantity: (json['stock_quantity'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      volume: (json['volume'] ?? 0).toDouble(),
      attributes: List<dynamic>.from(json['attributes']),
      images: List<dynamic>.from(json['images']),
    );
  }
}

class Meta {
  final int currentPage;
  final int perPage;
  final int total;
  final int totalPages;

  Meta({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
    );
  }
}
