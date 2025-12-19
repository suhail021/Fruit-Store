// lib/core/models/invoice_model.dart
import 'package:myapp/core/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  InvoiceModel({
    required super.id,
    required super.totalAmount,
    required super.deliveryCost,
    required super.couponDiscount,
    required super.balanceUsed,
    required super.finalAmount,
    required super.remainingAmount,
    required super.invoiceDate,
    required super.done,
    required super.paymentStatus,
    required super.paymentStatusLabel,
    required super.createdAt,
    required super.updatedAt,
    super.items,
    super.itemsCount,
    super.coupon,
    super.address,
    super.container,
    super.payment,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] as int,
      totalAmount: (json['total_amount'] as num).toDouble(),
      deliveryCost: (json['delivery_cost'] as num?)?.toDouble() ?? 0.0,
      couponDiscount: (json['coupon_discount'] as num?)?.toDouble() ?? 0.0,
      balanceUsed: (json['balance_used'] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json['final_amount'] as num).toDouble(),
      remainingAmount: (json['remaining_amount'] as num?)?.toDouble() ?? 0.0,
      invoiceDate: DateTime.parse(json['invoice_date'] as String),
      done: json['done'] as bool,
      paymentStatus: json['payment_status'] as String,
      paymentStatusLabel: json['payment_status_label'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      items:
          json['items'] != null
              ? (json['items'] as List)
                  .map((item) => InvoiceItemModel.fromJson(item))
                  .toList()
              : null,
      itemsCount: json['items_count'] as int?,
      coupon:
          json['coupon'] != null ? CouponModel.fromJson(json['coupon']) : null,
      address:
          json['address'] != null
              ? AddressModel.fromJson(json['address'])
              : null,
      container:
          json['container'] != null
              ? ContainerModel.fromJson(json['container'])
              : null,
      payment:
          json['payment'] != null
              ? PaymentModel.fromJson(json['payment'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_amount': totalAmount,
      'delivery_cost': deliveryCost,
      'coupon_discount': couponDiscount,
      'balance_used': balanceUsed,
      'final_amount': finalAmount,
      'remaining_amount': remainingAmount,
      'invoice_date': invoiceDate.toIso8601String(),
      'done': done,
      'payment_status': paymentStatus,
      'payment_status_label': paymentStatusLabel,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      if (items != null)
        'items':
            items!.map((item) => (item as InvoiceItemModel).toJson()).toList(),
      'items_count': itemsCount,
      if (coupon != null) 'coupon': (coupon as CouponModel).toJson(),
      if (address != null) 'address': (address as AddressModel).toJson(),
      if (container != null)
        'container': (container as ContainerModel).toJson(),
      if (payment != null) 'payment': (payment as PaymentModel).toJson(),
    };
  }
}

class InvoiceItemModel extends InvoiceItemEntity {
  InvoiceItemModel({
    required super.id,
    required super.product,
    required super.quantity,
    required super.price,
    required super.total,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      id: json['id'] as int,
      product: InvoiceProductModel.fromJson(json['product']),
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': (product as InvoiceProductModel).toJson(),
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}

class InvoiceProductModel extends InvoiceProductEntity {
  InvoiceProductModel({
    required super.id,
    required super.name,
    required super.image,
    super.description,
    super.sheinProductId,
    super.linkProducts,
    super.storeType,
  });

  factory InvoiceProductModel.fromJson(Map<String, dynamic> json) {
    return InvoiceProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String?,
      sheinProductId: json['shein_product_id'] as String?,
      linkProducts: json['link_products'] as String?,
      storeType: json['store_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'shein_product_id': sheinProductId,
      'link_products': linkProducts,
      'store_type': storeType,
    };
  }
}

class CouponModel extends CouponEntity {
  CouponModel({
    required super.id,
    required super.code,
    required super.name,
    required super.discount,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      discount: (json['discount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name, 'discount': discount};
  }
}

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.country,
    required super.city,
    required super.street,
    super.postalCode,
    super.description,
    required super.fullAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int,
      country: json['country'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      postalCode: json['postal_code'] as String?,
      description: json['description'] as String?,
      fullAddress: json['full_address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'street': street,
      'postal_code': postalCode,
      'description': description,
      'full_address': fullAddress,
    };
  }
}

class ContainerModel extends ContainerEntity {
  ContainerModel({required super.id, super.status, super.trackingNumber});

  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      id: json['id'] as int,
      status: json['status'] as String?,
      trackingNumber: json['tracking_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'status': status, 'tracking_number': trackingNumber};
  }
}

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.id,
    required super.amount,
    super.paymentMethod,
    required super.paymentDate,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String?,
      paymentDate: DateTime.parse(json['payment_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_date': paymentDate.toIso8601String(),
    };
  }
}
