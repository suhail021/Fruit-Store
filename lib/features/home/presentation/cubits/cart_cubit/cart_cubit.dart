import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_item_entity.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    loadCart();
  }

  CartEntity cartEntity = CartEntity([]);
  void addProduct(ProductEntity productEntity, {int quantity = 1}) {
    bool isProductExist = cartEntity.isExis(productEntity);
    var carItem = cartEntity.getCarItem(productEntity);
    if (isProductExist) {
      // If the item exists, we increase its quantity by the passed amount
      for (int i = 0; i < quantity; i++) {
        carItem.increasQuantity();
      }
    } else {
      carItem.quantity = quantity;
      cartEntity.addCartItem(carItem);
    }
    saveCart();
    emit(CartItemAdded());
  }

  void deleteCarItem(CartItemEntity carItem) {
    cartEntity.removeCarItem(carItem);
    saveCart();
    emit(CartItemRemoved());
  }

  void updateCartItemQuantity(CartItemEntity carItem, int change) {
    if (change > 0) {
      carItem.increasQuantity();
    } else {
      carItem.decreasQuantity();
    }
    saveCart();
    emit(CartItemQuantityUpdated());
  }

  void saveCart() {
    final List<Map<String, dynamic>> cartJson =
        cartEntity.cartItems.map((e) => e.toJson()).toList();
    Prefs.setString('cart_items', jsonEncode(cartJson));
  }

  void loadCart() {
    final String? cartJsonString = Prefs.getString('cart_items');
    if (cartJsonString != null) {
      final List<dynamic> decodedJson = jsonDecode(cartJsonString);
      final List<CartItemEntity> loadedItems =
          decodedJson
              .map((e) => CartItemEntity.fromJson(e as Map<String, dynamic>))
              .toList();
      cartEntity = CartEntity(loadedItems);
      emit(CartItemAdded());
    }
  }
}
