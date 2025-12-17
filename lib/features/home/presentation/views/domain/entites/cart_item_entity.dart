// lib/features/home/presentation/views/domain/entites/cart_item_entity.dart
import 'package:equatable/equatable.dart';
import 'package:myapp/core/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity productEntity;
  int quantity; // ✅ تصحيح

  CartItemEntity({
    required this.productEntity, 
    this.quantity = 1,
  });

  num calculateTotalPrice() {
    return productEntity.finalPrice * quantity;
  }

  num calculateTotalWeight() {
    return productEntity.unitAmount * quantity;
  }

  void increasQuantity() {
    quantity++;
  }

  void decreasQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
  
  // ✅ للتوافق مع الكود القديم
  int get quanitty => quantity;
  set quanitty(int value) => quantity = value;

  @override
  List<Object?> get props => [productEntity, quantity];
}