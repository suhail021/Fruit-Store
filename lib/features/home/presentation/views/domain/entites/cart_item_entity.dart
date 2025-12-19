// lib/features/home/presentation/views/domain/entites/cart_item_entity.dart
import 'package:equatable/equatable.dart';
import 'package:myapp/core/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity productEntity;
  int quantity;

  CartItemEntity({required this.productEntity, this.quantity = 1});

  num calculateTotalPrice() {
    return (productEntity.finalPrice * quantity).roundTo2();
  }

  num calculateTotalWeight() {
    return productEntity.unitAmount * quantity;
  }

  /// ✅ رقمين بعد الفاصلة (للعرض)
  String get totalPriceFormatted => calculateTotalPrice().toStringAsFixed(2);

  void increasQuantity() {
    quantity++;
  }

  void decreasQuantity() {
    if (quantity > 1) quantity--;
  }

  // للتوافق مع الكود القديم
  int get quanitty => quantity;
  set quanitty(int value) => quantity = value;

  @override
  List<Object?> get props => [productEntity, quantity];

  Map<String, dynamic> toJson() {
    return {'product': productEntity.toJson(), 'quantity': quantity};
  }

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      productEntity: ProductEntity.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

extension DoubleRounding on num {
  double roundTo2() => double.parse(toStringAsFixed(2));
}
