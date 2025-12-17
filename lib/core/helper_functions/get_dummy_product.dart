// lib/core/helper_functions/get_dummy_product.dart
import 'package:myapp/core/entities/product_entity.dart';

ProductEntity getDummyProduct() {
  return ProductEntity(
    id: 1,
    name: 'منتج تجريبي',
    description: 'وصف المنتج',
    img: null,
    price: 100.0,
    discountPrice: null,
    finalPrice: 100.0,
    quantity: 10,
    status: 'active',
    isAvailable: true,
  );
}

List<ProductEntity> getDummyProducts() {
  return List.generate(6, (index) => getDummyProduct());
}