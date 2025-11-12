class CategoryProductsModel {
  final String status;
  final String message;
  final CategoryWithProductsData data;
  final Map<String, dynamic> errors;

  CategoryProductsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    return CategoryProductsModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: CategoryWithProductsData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
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

class CategoryWithProductsData {
  final int id;
  final String name;
  final String? imageUrl;
  final int? parentId;
  final List<Category> children;
  final Seo seo;
  final int productCount;
  final List<Product> products;
  final Pagination pagination;

  CategoryWithProductsData({
    required this.id,
    required this.name,
    this.imageUrl,
    this.parentId,
    required this.children,
    required this.seo,
    required this.productCount,
    required this.products,
    required this.pagination,
  });

  factory CategoryWithProductsData.fromJson(Map<String, dynamic> json) {
    return CategoryWithProductsData(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      parentId: json['parent_id'] as int?,
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      seo: Seo.fromJson(json['seo'] as Map<String, dynamic>? ?? {}),
      productCount: json['product_count'] as int? ?? 0,
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => Product.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'parent_id': parentId,
    'children': children.map((e) => e.toJson()).toList(),
    'seo': seo.toJson(),
    'product_count': productCount,
    'products': products.map((e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
  };
}

class Category {
  final int id;
  final String name;
  final String? imageUrl;
  final int? parentId;
  final List<Category> children;
  final Seo seo;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    this.parentId,
    required this.children,
    required this.seo,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      parentId: json['parent_id'] as int?,
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      seo: Seo.fromJson(json['seo'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'parent_id': parentId,
    'children': children.map((e) => e.toJson()).toList(),
    'seo': seo.toJson(),
  };
}

class Seo {
  final String metaTitle;
  final String metaDescription;

  Seo({
    required this.metaTitle,
    required this.metaDescription,
  });

  factory Seo.fromJson(Map<String, dynamic> json) {
    return Seo(
      metaTitle: json['meta_title'] as String? ?? '',
      metaDescription: json['meta_description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'meta_title': metaTitle,
    'meta_description': metaDescription,
  };
}

class Product {
  final int id;
  final String name;
  final String description;
  final List<List<Category>> categories;
  final Category mainCategory;
  final int productVariantId;
  final String metaTitle;
  final String metaDescription;
  final String metaKeywords;
  final int rating;
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
  final List<ProductVariant> variants;
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
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => (e as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList())
          .toList(),
      mainCategory: Category.fromJson(json['main_category'] as Map<String, dynamic>? ?? {}),
      productVariantId: json['product_variant_id'] as int? ?? 0,
      metaTitle: json['meta_title'] as String? ?? '',
      metaDescription: json['meta_description'] as String? ?? '',
      metaKeywords: json['meta_keywords'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      ratingCount: json['rating_count'] as int? ?? 0,
      tags: json['tags'] as List<dynamic>? ?? [],
      deliveryInfo: DeliveryInfo.fromJson(json['delivery_info'] as Map<String, dynamic>? ?? {}),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble() ?? 0.0,
      hasDiscount: json['has_discount'] as bool? ?? false,
      discountPercent: json['discount_percent'] as String? ?? '0%',
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>? ?? {}),
      inStock: json['in_stock'] as bool? ?? false,
      stockQuantity: (json['stock_quantity'] as num?)?.toDouble() ?? 0.0,
      inWishlist: json['in_wishlist'] as bool? ?? false,
      mainImage: json['main_image'] as String? ?? '',
      images: json['images'] as List<dynamic>? ?? [],
      attributes: json['attributes'] as List<dynamic>? ?? [],
      variants: (json['variants'] as List<dynamic>? ?? [])
          .map((e) => ProductVariant.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      hasVariants: json['has_variants'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'categories': categories
        .map((e) => e.map((e) => e.toJson()).toList())
        .toList(),
    'main_category': mainCategory.toJson(),
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
    'images': images,
    'attributes': attributes,
    'variants': variants.map((e) => e.toJson()).toList(),
    'has_variants': hasVariants,
  };
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
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'weight': weight,
    'volume': volume,
  };
}

class Currency {
  final String code;
  final String symbol;

  Currency({
    required this.code,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'symbol': symbol,
  };
}

class ProductVariant {
  final int id;
  final String sku;
  final String barcode;
  final String name;
  final double price;
  final bool inWishlist;
  final dynamic originalPrice;
  final dynamic hasDiscount;
  final int discountPercent;
  final bool inStock;
  final double stockQuantity;
  final double weight;
  final double volume;
  final List<VariantAttribute> attributes;
  final List<dynamic> images;

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
      id: json['id'] as int? ?? 0,
      sku: json['sku'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      inWishlist: json['in_wishlist'] as bool? ?? false,
      originalPrice: json['original_price'],
      hasDiscount: json['has_discount'],
      discountPercent: json['discount_percent'] as int? ?? 0,
      inStock: json['in_stock'] as bool? ?? false,
      stockQuantity: (json['stock_quantity'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0.0,
      attributes: (json['attributes'] as List<dynamic>? ?? [])
          .map((e) => VariantAttribute.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList(),
      images: json['images'] as List<dynamic>? ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
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
    'attributes': attributes.map((e) => e.toJson()).toList(),
    'images': images,
  };
}

class VariantAttribute {
  final int attributeId;
  final String attributeName;
  final int valueId;
  final String valueName;
  final dynamic htmlColor; // Can be bool or String
  final dynamic imageUrl; // Can be null or String

  VariantAttribute({
    required this.attributeId,
    required this.attributeName,
    required this.valueId,
    required this.valueName,
    this.htmlColor,
    this.imageUrl,
  });

  factory VariantAttribute.fromJson(Map<String, dynamic> json) {
    return VariantAttribute(
      attributeId: json['attribute_id'] as int? ?? 0,
      attributeName: json['attribute_name'] as String? ?? '',
      valueId: json['value_id'] as int? ?? 0,
      valueName: json['value_name'] as String? ?? '',
      htmlColor: json['html_color'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'attribute_id': attributeId,
    'attribute_name': attributeName,
    'value_id': valueId,
    'value_name': valueName,
    'html_color': htmlColor,
    'image_url': imageUrl,
  };
}

class Pagination {
  final int currentPage;
  final int perPage;
  final int total;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 12,
      total: json['total'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'per_page': perPage,
    'total': total,
    'total_pages': totalPages,
  };
}