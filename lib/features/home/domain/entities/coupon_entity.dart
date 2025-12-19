class CouponEntity {
  final int id;
  final String code;
  final String name;
  final String discountType;
  final double discountValue;
  final double maxDiscountValue;
  final bool isValid;
  final String? expiresAt;
  final bool isUsed;

  CouponEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.discountType,
    required this.discountValue,
    required this.maxDiscountValue,
    required this.isValid,
    this.expiresAt,
    this.isUsed = false,
  });
}
