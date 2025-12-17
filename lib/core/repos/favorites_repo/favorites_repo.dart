// lib/features/favorites/domain/repos/favorites_repo.dart
import 'package:dartz/dartz.dart';
import 'package:myapp/core/entities/favorite_entity.dart';
import 'package:myapp/core/errors/failures.dart';

abstract class FavoritesRepo {
  /// الحصول على جميع المفضلات
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites();

  /// إضافة/إزالة من المفضلة (Toggle)
  Future<Either<Failure, String>> toggleFavorite({
    required int productId,
  });

  /// التحقق من وجود منتج في المفضلة
  Future<Either<Failure, bool>> checkFavorite({
    required int productId,
  });

  /// حذف من المفضلة
  Future<Either<Failure, String>> removeFavorite({
    required int favoriteId,
  });
}