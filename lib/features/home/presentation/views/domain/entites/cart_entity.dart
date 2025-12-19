import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> cartItems;

  CartEntity(this.cartItems);

  addCartItem(CartItemEntity cartItemEntity) {
    cartItems.add(cartItemEntity);
  }

  removeCarItem(CartItemEntity carItem) {
    cartItems.remove(carItem);
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var carItem in cartItems) {
      totalPrice += carItem.calculateTotalPrice();
    }
    return totalPrice;
  }

  bool isExis(ProductEntity product) {
    for (var carItem in cartItems) {
      if (carItem.productEntity.code == product.code) {
        return true;
      }
    }
    return false;
  }

  CartItemEntity getCarItem(ProductEntity product) {
    for (var carItem in cartItems) {
      if (carItem.productEntity.code == product.code) {
        return carItem;
      }
    }
    return CartItemEntity(productEntity: product, quantity: 1);
  }
}
