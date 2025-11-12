
class ProductByIdModel {
  final String status;
  final String message;
  final ProductData? data;
  final Map<String, dynamic>? errors;

  ProductByIdModel({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  factory ProductByIdModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductByIdModel(
        status: json["status"] as String? ?? '',
        message: json["message"] as String? ?? '',
        data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
        errors: json["errors"] as Map<String, dynamic>? ?? {},
      );
    } catch (e) {
      print('Error parsing ProductByIdModel: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "errors": errors,
  };
}

class ProductData {
  final int id;
  final String name;
  final String description;
  final List<List<Category>> categories;
  final Category? mainCategory;
  final int? productVariantId;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final int rating;
  final int ratingCount;
  final List<dynamic> tags;
  final DeliveryInfo? deliveryInfo;
  final double price;
  final double? originalPrice;
  final bool hasDiscount;
  final String? discountPercent;
  final Currency? currency;
  final bool inStock;
  final double stockQuantity;
  final bool inWishlist;
  final String? mainImage;
  final List<ProductImage> images;
  final List<dynamic> attributes;
  final List<Variant> variants;
  final bool hasVariants;
  final RelatedProducts? relatedProducts;

  ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.categories,
    this.mainCategory,
    this.productVariantId,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.rating = 0,
    this.ratingCount = 0,
    this.tags = const [],
    this.deliveryInfo,
    required this.price,
    this.originalPrice,
    this.hasDiscount = false,
    this.discountPercent,
    this.currency,
    this.inStock = false,
    this.stockQuantity = 0,
    this.inWishlist = false,
    this.mainImage,
    this.images = const [],
    this.attributes = const [],
    this.variants = const [],
    this.hasVariants = false,
    this.relatedProducts,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    try {
      return ProductData(
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? '',
        description: json["description"] as String? ?? '',
        categories: json["categories"] == null
            ? []
            : List<List<Category>>.from((json["categories"] as List).map((x) =>
        List<Category>.from(
            (x as List).map((x) => Category.fromJson(x))))),
        mainCategory: json["main_category"] == null
            ? null
            : Category.fromJson(json["main_category"]),
        productVariantId: json["product_variant_id"] as int?,
        metaTitle: json["meta_title"] as String?,
        metaDescription: json["meta_description"] as String?,
        metaKeywords: json["meta_keywords"] as String?,
        rating: json["rating"] as int? ?? 0,
        ratingCount: json["rating_count"] as int? ?? 0,
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"] as List),
        deliveryInfo: json["delivery_info"] == null
            ? null
            : DeliveryInfo.fromJson(json["delivery_info"]),
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        originalPrice: (json["original_price"] as num?)?.toDouble(),
        hasDiscount: json["has_discount"] as bool? ?? false,
        discountPercent: json["discount_percent"] as String?,
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        inStock: json["in_stock"] as bool? ?? false,
        stockQuantity: (json["stock_quantity"] as num?)?.toDouble() ?? 0.0,
        inWishlist: json["in_wishlist"] as bool? ?? false,
        mainImage: json["main_image"] as String?,
        images: json["images"] == null
            ? []
            : List<ProductImage>.from(
            (json["images"] as List).map((x) => ProductImage.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"] as List),
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
            (json["variants"] as List).map((x) => Variant.fromJson(x))),
        hasVariants: json["has_variants"] as bool? ?? false,
        relatedProducts: json["related_products"] == null
            ? null
            : RelatedProducts.fromJson(json["related_products"]),
      );
    } catch (e) {
      print('Error parsing ProductData: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "categories": List<dynamic>.from(categories.map((x) =>
    List<dynamic>.from(x.map((x) => x.toJson())))),
    "main_category": mainCategory?.toJson(),
    "product_variant_id": productVariantId,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "rating": rating,
    "rating_count": ratingCount,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "delivery_info": deliveryInfo?.toJson(),
    "price": price,
    "original_price": originalPrice,
    "has_discount": hasDiscount,
    "discount_percent": discountPercent,
    "currency": currency?.toJson(),
    "in_stock": inStock,
    "stock_quantity": stockQuantity,
    "in_wishlist": inWishlist,
    "main_image": mainImage,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "attributes": List<dynamic>.from(attributes.map((x) => x)),
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
    "has_variants": hasVariants,
    "related_products": relatedProducts?.toJson(),
  };
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] as int,
    name: json["name"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Currency {
  final String code;
  final String symbol;

  Currency({
    required this.code,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    code: json["code"] as String,
    symbol: json["symbol"] as String,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "symbol": symbol,
  };
}

class DeliveryInfo {
  final double weight;
  final double volume;

  DeliveryInfo({
    required this.weight,
    required this.volume,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
    weight: (json["weight"] as num).toDouble(),
    volume: (json["volume"] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "volume": volume,
  };
}

class RelatedProducts {
  final List<List<ProductData>> optionalProducts;
  final List<dynamic> accessoryProducts;
  final List<dynamic> alternativeProducts;

  RelatedProducts({
    required this.optionalProducts,
    required this.accessoryProducts,
    required this.alternativeProducts,
  });

  factory RelatedProducts.fromJson(Map<String, dynamic> json) => RelatedProducts(
    optionalProducts: List<List<ProductData>>.from(json["optional_products"]
        .map((x) => List<ProductData>.from(
        x.map((x) => ProductData.fromJson(x))))),
    accessoryProducts:
    List<dynamic>.from(json["accessory_products"].map((x) => x)),
    alternativeProducts:
    List<dynamic>.from(json["alternative_products"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "optional_products": List<dynamic>.from(optionalProducts.map((x) =>
    List<dynamic>.from(x.map((x) => x.toJson())))),
    "accessory_products":
    List<dynamic>.from(accessoryProducts.map((x) => x)),
    "alternative_products":
    List<dynamic>.from(alternativeProducts.map((x) => x)),
  };
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
  final int discountPercent;
  final bool inStock;
  final double stockQuantity;
  final double weight;
  final double volume;
  final List<Attribute> attributes;
  final List<ProductImage> images;

  Variant({
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

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"] as int,
    sku: json["sku"] as String,
    barcode: json["barcode"] as String,
    name: json["name"] as String,
    price: (json["price"] as num).toDouble(),
    inWishlist: json["in_wishlist"] as bool,
    originalPrice: json["original_price"]?.toDouble(),
    hasDiscount: json["has_discount"] as bool?,
    discountPercent: json["discount_percent"] as int,
    inStock: json["in_stock"] as bool,
    stockQuantity: (json["stock_quantity"] as num).toDouble(),
    weight: (json["weight"] as num).toDouble(),
    volume: (json["volume"] as num).toDouble(),
    attributes: List<Attribute>.from(
        json["attributes"].map((x) => Attribute.fromJson(x))),
    images: json["images"] == null
        ? []
        : List<ProductImage>.from(
        json["images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "barcode": barcode,
    "name": name,
    "price": price,
    "in_wishlist": inWishlist,
    "original_price": originalPrice,
    "has_discount": hasDiscount,
    "discount_percent": discountPercent,
    "in_stock": inStock,
    "stock_quantity": stockQuantity,
    "weight": weight,
    "volume": volume,
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Attribute {
  final int attributeId;
  final String attributeName;
  final int valueId;
  final String valueName;
  final dynamic htmlColor;
  final String? imageUrl;

  Attribute({
    required this.attributeId,
    required this.attributeName,
    required this.valueId,
    required this.valueName,
    this.htmlColor,
    this.imageUrl,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    attributeId: json["attribute_id"] as int,
    attributeName: json["attribute_name"] as String,
    valueId: json["value_id"] as int,
    valueName: json["value_name"] as String,
    htmlColor: json["html_color"],
    imageUrl: json["image_url"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "attribute_id": attributeId,
    "attribute_name": attributeName,
    "value_id": valueId,
    "value_name": valueName,
    "html_color": htmlColor,
    "image_url": imageUrl,
  };
}

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

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"] as int,
    url: json["url"] as String,
    thumbnail: json["thumbnail"] as String,
    altText: json["alt_text"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "thumbnail": thumbnail,
    "alt_text": altText,
  };
}