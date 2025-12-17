// lib/features/checkout/data/models/order_product_model.dart
import 'package:myapp/features/home/presentation/views/domain/entites/cart_item_entity.dart';

class OrderProductModel {
  final String name;
  final String code;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderProductModel({
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderProductModel.fromEntity({
    required CartItemEntity cartItemEntity,
  }) {
    return OrderProductModel(
      name: cartItemEntity.productEntity.name,
      code: cartItemEntity.productEntity.code, // ✅ الآن موجود
      imageUrl: cartItemEntity.productEntity.imageUrl ?? '', // ✅ معالجة null
      price: cartItemEntity.productEntity.finalPrice, // ✅ استخدام finalPrice
      quantity: cartItemEntity.quantity, // ✅ تصحيح
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}