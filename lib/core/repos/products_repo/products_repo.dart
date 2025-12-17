// lib/core/repos/products_repo/products_repo.dart
import 'package:dartz/dartz.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/core/errors/failures.dart';

abstract class ProductsRepo {
  /// الحصول على جميع المنتجات مع فلترة
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? search,
    double? minPrice,
    double? maxPrice,
    bool? availableOnly,
    String? status,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    int perPage = 20,
  });

  /// الحصول على منتج واحد
  Future<Either<Failure, ProductEntity>> getProduct(int id);
  
  /// البحث في المنتجات
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
  
  /// المنتجات المميزة / الأكثر مبيعاً
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts({
    int limit = 10,
  });
  
  /// التحقق من توفر المنتج
  Future<Either<Failure, bool>> checkAvailability(int id);
}
