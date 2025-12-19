import 'package:myapp/features/checkout/data/models/order_product_model.dart';
import 'package:myapp/features/checkout/data/models/shipping_address_model.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  final double totalPrice;
  final String uId;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final String orderId;

  OrderModel({
    required this.totalPrice,
    required this.uId,
    required this.orderId,
    required this.shippingAddressModel,
    required this.orderProducts,
    required this.paymentMethod,
  });

  factory OrderModel.fromEntity(OrderEntity orderEntity) {
    return OrderModel(
      orderId: const Uuid().v4(),
      totalPrice: orderEntity.cartEntity.calculateTotalPrice(),
      uId: orderEntity.uID.toString(), // ✅ الحل هنا
      shippingAddressModel: ShippingAddressModel.fromEntity(
        orderEntity.shippingAddressEntity!,
      ),
      orderProducts:
          orderEntity.cartEntity.cartItems
              .map((e) => OrderProductModel.fromEntity(cartItemEntity: e))
              .toList(),
      paymentMethod: 'Cash', // ✅ ثابت
    );
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'totalPrice': totalPrice,
    'uId': uId,
    'status': 'pending',
    'date': DateTime.now().toIso8601String(),
    'shippingAddress': shippingAddressModel.toJson(),
    'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };
}
