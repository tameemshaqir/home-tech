class CategoryModel {
  final String status;
  final String message;
  final List<CategoryData> data;
  final Map<String, dynamic> errors;

  CategoryModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['status'],
      message: json['message'],
      data: List<CategoryData>.from(
          json['data'].map((x) => CategoryData.fromJson(x))),
      errors: json['errors'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'errors': errors,
    };
  }
}

class CategoryData {
  final int id;
  final String name;
  final String? imageUrl;
  final int? parentId;
  final int productCount;
  final List<CategoryData> children;
  final Seo seo;

  CategoryData({
    required this.id,
    required this.name,
    this.imageUrl,
    this.parentId,
    required this.productCount,
    required this.children,
    required this.seo,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      parentId: json['parent_id'],
      productCount: json['product_count'],
      children: List<CategoryData>.from(
          json['children'].map((x) => CategoryData.fromJson(x))),
      seo: Seo.fromJson(json['seo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'parent_id': parentId,
      'product_count': productCount,
      'children': List<dynamic>.from(children.map((x) => x.toJson())),
      'seo': seo.toJson(),
    };
  }
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
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta_title': metaTitle,
      'meta_description': metaDescription,
    };
  }
}