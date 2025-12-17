// lib/core/repos/products_repo/products_repo_impl.dart
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/core/errors/custom_exceptions.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/models/product_model.dart';
import 'package:myapp/core/repos/products_repo/products_repo.dart';
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/api_constants.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ApiService apiService;

  ProductsRepoImpl({required this.apiService});

  @override
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
  }) async {
    try {
      final token = await Prefs.getString('auth_token');
      
      final queryParameters = <String, dynamic>{
        'page': page.toString(),
        'per_page': perPage.toString(),
      };

      if (search != null && search.isNotEmpty) queryParameters['search'] = search;
      if (minPrice != null) queryParameters['min_price'] = minPrice.toString();
      if (maxPrice != null) queryParameters['max_price'] = maxPrice.toString();
      if (availableOnly != null) queryParameters['available_only'] = availableOnly.toString();
      if (status != null) queryParameters['status'] = status;
      if (sortBy != null) queryParameters['sort_by'] = sortBy;
      if (sortOrder != null) queryParameters['sort_order'] = sortOrder;

      log('🛍️ Getting products with filters: $queryParameters');

      final response = await apiService.get(
        endpoint: ApiConstants.products,
        headers: token != null ? ApiConstants.headersWithToken(token) : null,
        queryParameters: queryParameters,
      );

      final productsData = response['products']['data'] as List;
      final products = productsData
          .map((json) => ProductModel.fromJson(json) as ProductEntity)
          .toList();

      log('✅ Retrieved ${products.length} products');
      return Right(products);

    } on ServerException catch (e) {
      log('❌ ServerException in getProducts: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in getProducts: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(int id) async {
    try {
      final token = await Prefs.getString('auth_token');

      log('📦 Getting product #$id');

      final response = await apiService.get(
        endpoint: '${ApiConstants.products}/$id',
        headers: token != null ? ApiConstants.headersWithToken(token) : null,
      );

      final product = ProductModel.fromJson(response['product']);
      
      log('✅ Product retrieved: ${product.name}');
      return Right(product);

    } on ServerException catch (e) {
      log('❌ ServerException in getProduct: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in getProduct: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
    try {
      final token = await Prefs.getString('auth_token');

      log('🔍 Searching for: $query');

      final response = await apiService.get(
        endpoint: ApiConstants.productsSearch,
        headers: token != null ? ApiConstants.headersWithToken(token) : null,
        queryParameters: {'q': query},
      );

      final productsData = response['products']['data'] as List;
      final products = productsData
          .map((json) => ProductModel.fromJson(json) as ProductEntity)
          .toList();

      log('✅ Found ${products.length} products');
      return Right(products);

    } on ServerException catch (e) {
      log('❌ ServerException in searchProducts: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in searchProducts: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts({
    int limit = 10,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      log('⭐ Getting featured products (limit: $limit)');

      final response = await apiService.get(
        endpoint: ApiConstants.productsFeatured,
        headers: token != null ? ApiConstants.headersWithToken(token) : null,
        queryParameters: {'limit': limit.toString()},
      );

      final productsData = response['products'] as List;
      final products = productsData
          .map((json) => ProductModel.fromJson(json) as ProductEntity)
          .toList();

      log('✅ Retrieved ${products.length} featured products');
      return Right(products);

    } on ServerException catch (e) {
      log('❌ ServerException in getFeaturedProducts: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in getFeaturedProducts: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAvailability(int id) async {
    try {
      final token = await Prefs.getString('auth_token');

      log('🔍 Checking availability for product #$id');

      final response = await apiService.get(
        endpoint: '${ApiConstants.products}/$id/check-availability',
        headers: token != null ? ApiConstants.headersWithToken(token) : null,
      );

      final isAvailable = response['is_available'] as bool;
      
      log('✅ Product #$id availability: $isAvailable');
      return Right(isAvailable);

    } on ServerException catch (e) {
      log('❌ ServerException in checkAvailability: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in checkAvailability: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }
}
