import 'package:myapp/features/home/domain/entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  CouponModel({
    required super.id,
    required super.code,
    required super.name,
    required super.discountType,
    required super.discountValue,
    required super.maxDiscountValue,
    required super.isValid,
    super.expiresAt,
    super.isUsed,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
        id: json['id'] as int? ?? 0,
        code: json['code'] as String? ?? '',
        name: json['name'] as String? ?? '',
        discountType: json['discount_type'] as String? ?? 'percentage',
        discountValue:
            double.tryParse(json['discount_value']?.toString() ?? '0') ?? 0.0,
        maxDiscountValue:
            double.tryParse(json['max_discount_value']?.toString() ?? '0') ??
                0.0,
        isValid: json['is_valid'] as bool? ?? false,
        expiresAt: json['expires_at'] as String?,
        isUsed: json['is_used'] as bool? ?? false);
  }
}
