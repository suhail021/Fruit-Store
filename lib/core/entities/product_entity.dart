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

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'img': img,
      'price': price,
      'discount_price': discountPrice,
      'final_price': finalPrice,
      'quantity': quantity,
      'status': status,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_shein_product': isSheinProduct,
      'selected_size': selectedSize,
      'selected_color': selectedColor,
      'shein_url': sheinUrl,
    };
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      img: json['img'],
      price: (json['price'] as num).toDouble(),
      discountPrice:
          json['discount_price'] != null
              ? (json['discount_price'] as num).toDouble()
              : null,
      finalPrice: (json['final_price'] as num).toDouble(),
      quantity: json['quantity'],
      status: json['status'],
      isAvailable: json['is_available'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      isSheinProduct: json['is_shein_product'] ?? false,
      selectedSize: json['selected_size'],
      selectedColor: json['selected_color'],
      sheinUrl: json['shein_url'],
    );
  }
}
