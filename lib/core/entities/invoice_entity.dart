// lib/core/entities/invoice_entity.dart

class InvoiceEntity {
  final int id;
  final double totalAmount;
  final double deliveryCost;
  final double couponDiscount;
  final double balanceUsed;
  final double finalAmount;
  final double remainingAmount;
  final DateTime invoiceDate;
  final bool done;
  final String paymentStatus;
  final String paymentStatusLabel;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<InvoiceItemEntity>? items;
  final int? itemsCount;
  final CouponEntity? coupon;
  final AddressEntity? address;
  final ContainerEntity? container;
  final PaymentEntity? payment;

  InvoiceEntity({
    required this.id,
    required this.totalAmount,
    required this.deliveryCost,
    required this.couponDiscount,
    required this.balanceUsed,
    required this.finalAmount,
    required this.remainingAmount,
    required this.invoiceDate,
    required this.done,
    required this.paymentStatus,
    required this.paymentStatusLabel,
    required this.createdAt,
    required this.updatedAt,
    this.items,
    this.itemsCount,
    this.coupon,
    this.address,
    this.container,
    this.payment,
  });
}

class InvoiceItemEntity {
  final int id;
  final InvoiceProductEntity product;
  final int quantity;
  final double price;
  final double total;

  InvoiceItemEntity({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.total,
  });
}

class InvoiceProductEntity {
  final int id;
  final String name;
  final String image;
  final String? description;
  final String? sheinProductId;
  final String? linkProducts;
  final String? storeType;

  InvoiceProductEntity({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    this.sheinProductId,
    this.linkProducts,
    this.storeType,
  });
}

class CouponEntity {
  final int id;
  final String code;
  final String name;
  final double discount;

  CouponEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.discount,
  });
}

class AddressEntity {
  final int id;
  final String country;
  final String city;
  final String street;
  final String? postalCode;
  final String? description;
  final String fullAddress;

  AddressEntity({
    required this.id,
    required this.country,
    required this.city,
    required this.street,
    this.postalCode,
    this.description,
    required this.fullAddress,
  });
}

class ContainerEntity {
  final int id;
  final String? status;
  final String? trackingNumber;

  ContainerEntity({required this.id, this.status, this.trackingNumber});
}

class PaymentEntity {
  final int id;
  final double amount;
  final String? paymentMethod;
  final DateTime paymentDate;

  PaymentEntity({
    required this.id,
    required this.amount,
    this.paymentMethod,
    required this.paymentDate,
  });
}
