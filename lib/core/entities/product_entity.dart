// lib/core/entities/product_entity.dart
class ProductEntity {
  final int id;
  final String name;
  final String? description;
  final String? img;
  final double price;
  final double? discountPrice;
  final double finalPrice;
  final int quantity;
  final String status;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductEntity({
    required this.id,
    required this.name,
    this.description,
    this.img,
    required this.price,
    this.discountPrice,
    required this.finalPrice,
    required this.quantity,
    required this.status,
    required this.isAvailable,
    this.createdAt,
    this.updatedAt,
    this.isSheinProduct = false,
    this.selectedSize,
    this.selectedColor,
    this.sheinUrl,
  });

  // Shein Specific Fields
  final bool isSheinProduct;
  final String? selectedSize;
  final String? selectedColor;
  final String? sheinUrl;

  // Computed Properties
  bool get hasDiscount => discountPrice != null && discountPrice! < price;

  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((price - discountPrice!) / price * 100).roundToDouble();
  }

  bool get inStock => quantity > 0 && isAvailable;

  String get formattedPrice => '${finalPrice.toStringAsFixed(2)} ر.س';

  String get formattedOriginalPrice => '${price.toStringAsFixed(2)} ر.س';

  // ✅ للتوافق مع الكود القديم
  String? get imageUrl => img;

  // ✅ كود المنتج (يمكن أن يكون الـ ID كنص)
  String get code => 'P$id';

  // ✅ وزن افتراضي
  double get unitAmount => 1.0;
}
