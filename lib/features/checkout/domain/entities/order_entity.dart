// lib/features/checkout/domain/entities/order_entity.dart
import 'package:myapp/features/checkout/domain/entities/shipping_address_entity.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_entity.dart';

class OrderEntity {
  final CartEntity cartEntity;
  final ShippingAddressEntity shippingAddressEntity;
  final int uID; // ✅ تصحيح النوع
  final String? notes;

  OrderEntity(
    this.cartEntity, {
    required this.shippingAddressEntity,
    required this.uID,
    this.notes,
  });
  
  // حساب الإجمالي
  double get totalAmount => cartEntity.calculateTotalPrice();
  
  // عدد العناصر
  int get itemsCount => cartEntity.cartItems.length;
}