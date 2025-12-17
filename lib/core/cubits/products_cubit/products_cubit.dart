// lib/core/cubits/products_cubit/products_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/core/repos/products_repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productsRepo) : super(ProductsInitial());

  final ProductsRepo productsRepo;
  
  // ✅ إضافة المتغير
  List<ProductEntity> _products = [];
  
  // ✅ إضافة getter
  int get productsLength => _products.length;

  /// الحصول على المنتجات الأكثر مبيعاً
  Future<void> getBestSellingProducts({int limit = 20}) async {
    emit(ProductsLoading());

    final result = await productsRepo.getFeaturedProducts(limit: limit);

    result.fold(
      (failure) => emit(ProductsFailure(errMessage: failure.message)),
      (products) {
        _products = products; // ✅ حفظ المنتجات
        emit(ProductsSuccess(products: products));
      },
    );
  }

  /// الحصول على جميع المنتجات
  Future<void> getProducts({
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
    emit(ProductsLoading());

    final result = await productsRepo.getProducts(
      search: search,
      minPrice: minPrice,
      maxPrice: maxPrice,
      availableOnly: availableOnly,
      status: status,
      sortBy: sortBy,
      sortOrder: sortOrder,
      page: page,
      perPage: perPage,
    );

    result.fold(
      (failure) => emit(ProductsFailure(errMessage: failure.message)),
      (products) {
        _products = products; // ✅ حفظ المنتجات
        emit(ProductsSuccess(products: products));
      },
    );
  }

  /// البحث في المنتجات
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(ProductsInitial());
      return;
    }

    emit(ProductsLoading());

    final result = await productsRepo.searchProducts(query);

    result.fold(
      (failure) => emit(ProductsFailure(errMessage: failure.message)),
      (products) {
        _products = products; // ✅ حفظ المنتجات
        emit(ProductsSuccess(products: products));
      },
    );
  }

  /// الحصول على منتج واحد
  Future<void> getProduct(int id) async {
    emit(ProductsLoading());

    final result = await productsRepo.getProduct(id);

    result.fold(
      (failure) => emit(ProductsFailure(errMessage: failure.message)),
      (product) {
        _products = [product]; // ✅ حفظ المنتج
        emit(ProductsSuccess(products: [product]));
      },
    );
  }

  /// التحقق من توفر المنتج
  Future<bool> checkAvailability(int id) async {
    final result = await productsRepo.checkAvailability(id);

    return result.fold(
      (failure) => false,
      (isAvailable) => isAvailable,
    );
  }
}