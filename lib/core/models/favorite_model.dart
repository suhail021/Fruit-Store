// lib/features/favorites/data/models/favorite_model.dart

import 'package:myapp/core/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel({
    required super.idFavorites,
    required super.idUser,
    required super.idProducts,
    required super.productName,
    super.productDescription,
    super.img,
    super.price,
    super.finalPrice,
    required super.productLink,
    required super.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      idFavorites: json['id_favorites'] as int,
      idUser: json['id_user'] as int? ?? 0,
      idProducts: json['id_products'] as int,
      productName: json['product_name'] as String,
      productDescription: json['product_description'] as String?,
      img: json['img'] as String?,
      price: _parseDouble(json['price']),
      finalPrice: _parseDouble(json['final_price']),
      productLink: json['product_link'] as String? ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_favorites': idFavorites,
      'id_user': idUser,
      'id_products': idProducts,
      'product_name': productName,
      'product_description': productDescription,
      'img': img,
      'price': price,
      'final_price': finalPrice,
      'product_link': productLink,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  FavoriteEntity toEntity() => this;
}