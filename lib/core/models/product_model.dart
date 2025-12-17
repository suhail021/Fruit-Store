// lib/core/models/product_model.dart
import 'package:myapp/core/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    super.description,
    super.img,
    required super.price,
    super.discountPrice,
    required super.finalPrice,
    required super.quantity,
    required super.status,
    required super.isAvailable,
    super.createdAt,
    super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      img: json['img'] as String?,
      price: _parseDouble(json['price']),
      discountPrice: json['discount_price'] != null 
          ? _parseDouble(json['discount_price'])
          : null,
      finalPrice: _parseDouble(json['final_price']),
      quantity: json['quantity'] as int,
      status: json['status'] as String,
      isAvailable: json['is_available'] as bool,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'img': img,
      'price': price,
      'discount_price': discountPrice,
      'final_price': finalPrice,
      'quantity': quantity,
      'status': status,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      img: entity.img,
      price: entity.price,
      discountPrice: entity.discountPrice,
      finalPrice: entity.finalPrice,
      quantity: entity.quantity,
      status: entity.status,
      isAvailable: entity.isAvailable,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ProductEntity toEntity() => this;
}
