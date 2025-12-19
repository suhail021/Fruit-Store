import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_item_entity.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

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
      // If new, we set the initial quantity.
      // Note: checking CartItemEntity, it defaults to 1 in constructor.
      // We probably need a way to set initial quantity or set it after creation.
      // Since getCarItem returns a NEW item with qty=1 if not found:
      // We should update that item's quantity.
      carItem.quantity = quantity;
      cartEntity.addCartItem(carItem);
    }
    emit(CartItemAdded());
  }

  void deleteCarItem(CartItemEntity carItem) {
    cartEntity.removeCarItem(carItem);
    emit(CartItemRemoved());
  }
}
