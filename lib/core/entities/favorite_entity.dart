// lib/features/favorites/domain/entities/favorite_entity.dart
class FavoriteEntity {
  final int idFavorites;
  final int idUser;
  final int idProducts;
  final String productName;
  final String? productDescription;
  final String? img;
  final double? price;
  final double? finalPrice;
  final String productLink;
  final DateTime createdAt;

  FavoriteEntity({
    required this.idFavorites,
    required this.idUser,
    required this.idProducts,
    required this.productName,
    this.productDescription,
    this.img,
    this.price,
    this.finalPrice,
    required this.productLink,
    required this.createdAt,
  });

  bool get hasDiscount => price != null && finalPrice != null && finalPrice! < price!;
  
  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((price! - finalPrice!) / price! * 100).roundToDouble();
  }
}