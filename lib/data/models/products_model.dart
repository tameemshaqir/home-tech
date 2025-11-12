// Main API Response Model
import 'dart:convert';

class ProductsModel {
  final String status;
  final String message;
  final ProductData data;
  final Map<String, dynamic> errors;

  ProductsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: ProductData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
      'errors': errors,
    };
  }
}

// Product Data Container
class ProductData {
  final List<Product> products;
  final Meta meta;

  ProductData({
    required this.products,
    required this.meta,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item))
          .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

// Meta Information
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
      currentPage: json['current_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
    };
  }
}

// Product Model
class Product {
  final int id;
  final String name;
  final String description;
  final List<List<Category>> categories;
  final Category? mainCategory;
  final int productVariantId;
  final String metaTitle;
  final String metaDescription;
  final String metaKeywords;
  final double rating;
  final int ratingCount;
  final List<String> tags;
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
  final List<ProductImage> images;
  final List<ProductAttribute> attributes;
  final List<ProductVariant> variants;
  final bool hasVariants;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categories,
    this.mainCategory,
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((categoryGroup) => (categoryGroup as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList())
          .toList() ??
          [],
      mainCategory: json['main_category'] != null
          ? Category.fromJson(json['main_category'])
          : null,
      productVariantId: json['product_variant_id'] ?? 0,
      metaTitle: json['meta_title'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      metaKeywords: json['meta_keywords'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      deliveryInfo: DeliveryInfo.fromJson(json['delivery_info'] ?? {}),
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      hasDiscount: json['has_discount'] ?? false,
      discountPercent: json['discount_percent'] ?? '0.0%',
      currency: Currency.fromJson(json['currency'] ?? {}),
      inStock: json['in_stock'] ?? false,
      stockQuantity: (json['stock_quantity'] ?? 0).toDouble(),
      inWishlist: json['in_wishlist'] ?? false,
      mainImage: json['main_image'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => ProductImage.fromJson(image))
          .toList() ??
          [],
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((attribute) => ProductAttribute.fromJson(attribute))
          .toList() ??
          [],
      variants: (json['variants'] as List<dynamic>?)
          ?.map((variant) => ProductVariant.fromJson(variant))
          .toList() ??
          [],
      hasVariants: json['has_variants'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categories': categories
          .map((categoryGroup) =>
          categoryGroup.map((category) => category.toJson()).toList())
          .toList(),
      'main_category': mainCategory?.toJson(),
      'product_variant_id': productVariantId,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_keywords': metaKeywords,
      'rating': rating,
      'rating_count': ratingCount,
      'tags': tags,
      'delivery_info': deliveryInfo.toJson(),
      'price': price,
      'original_price': originalPrice,
      'has_discount': hasDiscount,
      'discount_percent': discountPercent,
      'currency': currency.toJson(),
      'in_stock': inStock,
      'stock_quantity': stockQuantity,
      'in_wishlist': inWishlist,
      'main_image': mainImage,
      'images': images.map((image) => image.toJson()).toList(),
      'attributes': attributes.map((attr) => attr.toJson()).toList(),
      'variants': variants.map((variant) => variant.toJson()).toList(),
      'has_variants': hasVariants,
    };
  }
}

// Category Model
class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// Delivery Info Model
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

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'volume': volume,
    };
  }
}

// Currency Model
class Currency {
  final String code;
  final String symbol;

  Currency({
    required this.code,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] ?? '',
      symbol: json['symbol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'symbol': symbol,
    };
  }
}

// Product Image Model
class ProductImage {
  final int id;
  final String url;
  final String thumbnail;
  final String altText;

  ProductImage({
    required this.id,
    required this.url,
    required this.thumbnail,
    required this.altText,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      altText: json['alt_text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'thumbnail': thumbnail,
      'alt_text': altText,
    };
  }
}

// Product Attribute Model
class ProductAttribute {
  final int attributeId;
  final String attributeName;
  final int valueId;
  final String valueName;
  final String? htmlColor;
  final String? imageUrl;

  ProductAttribute({
    required this.attributeId,
    required this.attributeName,
    required this.valueId,
    required this.valueName,
    this.htmlColor,
    this.imageUrl,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      attributeId: json['attribute_id'] ?? 0,
      attributeName: json['attribute_name'] ?? '',
      valueId: json['value_id'] ?? 0,
      valueName: json['value_name'] ?? '',
      htmlColor: json['html_color'] is String ? json['html_color'] : null,
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribute_id': attributeId,
      'attribute_name': attributeName,
      'value_id': valueId,
      'value_name': valueName,
      'html_color': htmlColor,
      'image_url': imageUrl,
    };
  }
}

// Product Variant Model
class ProductVariant {
  final int id;
  final String sku;
  final String barcode;
  final String name;
  final double price;
  final bool inWishlist;
  final double? originalPrice;
  final bool? hasDiscount;
  final int discountPercent;
  final bool inStock;
  final double stockQuantity;
  final double weight;
  final double volume;
  final List<ProductAttribute> attributes;
  final List<ProductImage> images;

  ProductVariant({
    required this.id,
    required this.sku,
    required this.barcode,
    required this.name,
    required this.price,
    required this.inWishlist,
    this.originalPrice,
    this.hasDiscount,
    required this.discountPercent,
    required this.inStock,
    required this.stockQuantity,
    required this.weight,
    required this.volume,
    required this.attributes,
    required this.images,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] ?? 0,
      sku: json['sku'] ?? '',
      barcode: json['barcode'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      inWishlist: json['in_wishlist'] ?? false,
      originalPrice: json['original_price']?.toDouble(),
      hasDiscount: json['has_discount'],
      discountPercent: json['discount_percent'] ?? 0,
      inStock: json['in_stock'] ?? false,
      stockQuantity: (json['stock_quantity'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      volume: (json['volume'] ?? 0).toDouble(),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((attr) => ProductAttribute.fromJson(attr))
          .toList() ??
          [],
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => ProductImage.fromJson(image))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'barcode': barcode,
      'name': name,
      'price': price,
      'in_wishlist': inWishlist,
      'original_price': originalPrice,
      'has_discount': hasDiscount,
      'discount_percent': discountPercent,
      'in_stock': inStock,
      'stock_quantity': stockQuantity,
      'weight': weight,
      'volume': volume,
      'attributes': attributes.map((attr) => attr.toJson()).toList(),
      'images': images.map((image) => image.toJson()).toList(),
    };
  }
}

