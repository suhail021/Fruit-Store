// lib/features/favorites/presentation/cubits/favorites_cubit.dart
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:myapp/core/cubits/favorites_cubit/favorites_state.dart';
import 'package:myapp/core/repos/favorites_repo/favorites_repo.dart';
import 'package:myapp/core/repos/favorites_repo/favorites_repo_impl.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.favoritesRepo) : super(FavoritesInitial());

  final FavoritesRepo favoritesRepo;

  /// الحصول على جميع المفضلات
  Future<void> getFavorites() async {
    emit(FavoritesLoading());

    log('📋 Loading favorites...');

    final result = await favoritesRepo.getFavorites();

    result.fold(
      (failure) {
        log('❌ Failed to load favorites: ${failure.message}');
        emit(FavoritesFailure(errMessage: failure.message));
      },
      (favorites) {
        log('✅ Loaded ${favorites.length} favorites');
        emit(FavoritesSuccess(favorites: favorites));
      },
    );
  }

  /// إضافة منتج للمفضلة
  Future<void> addFavorite({
    required int productId,
    required String productName,
    String? productDescription,
    String? img,
    double? price,
    double? finalPrice,
    required String productLink,
  }) async {
    // استخدام الـ implementation مباشرة
    final repo = favoritesRepo as FavoritesRepoImpl;
    
    final result = await repo.addFavorite(
      productId: productId,
      productName: productName,
      productDescription: productDescription,
      img: img,
      price: price,
      finalPrice: finalPrice,
      productLink: productLink,
    );

    result.fold(
      (failure) {
        log('❌ Failed to add favorite: ${failure.message}');
        emit(FavoriteToggleFailure(errMessage: failure.message));
      },
      (message) {
        log('✅ Favorite added: $message');
        emit(FavoriteToggleSuccess(message: message));
        // إعادة تحميل المفضلات
        getFavorites();
      },
    );
  }

  /// حذف من المفضلة باستخدام Product ID
  Future<void> removeFavoriteByProductId(int productId) async {
    final repo = favoritesRepo as FavoritesRepoImpl;
    
    final result = await repo.removeFavoriteByProductId(productId: productId);

    result.fold(
      (failure) {
        log('❌ Failed to remove favorite: ${failure.message}');
        emit(FavoriteRemoveFailure(errMessage: failure.message));
      },
      (message) {
        log('✅ Favorite removed: $message');
        emit(FavoriteRemoveSuccess(message: message));
        // إعادة تحميل المفضلات
        getFavorites();
      },
    );
  }

  /// Toggle المفضلة (إضافة أو حذف)
  Future<void> toggleFavorite({
    required int productId,
    required String productName,
    String? productDescription,
    String? img,
    double? price,
    double? finalPrice,
    required String productLink,
  }) async {
    // التحقق من وجود المنتج
    final checkResult = await favoritesRepo.checkFavorite(productId: productId);

    final isFavorite = checkResult.getOrElse(() => false);

    if (isFavorite) {
      // حذف من المفضلة
      await removeFavoriteByProductId(productId);
    } else {
      // إضافة للمفضلة
      await addFavorite(
        productId: productId,
        productName: productName,
        productDescription: productDescription,
        img: img,
        price: price,
        finalPrice: finalPrice,
        productLink: productLink,
      );
    }
  }

  /// حذف من المفضلة
  Future<void> removeFavorite(int favoriteId) async {
    final result = await favoritesRepo.removeFavorite(favoriteId: favoriteId);

    result.fold(
      (failure) {
        log('❌ Failed to remove favorite: ${failure.message}');
        emit(FavoriteRemoveFailure(errMessage: failure.message));
      },
      (message) {
        log('✅ Favorite removed: $message');
        emit(FavoriteRemoveSuccess(message: message));
        // إعادة تحميل المفضلات
        getFavorites();
      },
    );
  }

  /// التحقق من وجود منتج في المفضلة
  Future<bool> checkFavorite(int productId) async {
    final result = await favoritesRepo.checkFavorite(productId: productId);

    return result.fold(
      (failure) => false,
      (isFavorite) => isFavorite,
    );
  }

  /// حذف جميع المفضلات
  Future<void> clearAllFavorites() async {
    final repo = favoritesRepo as FavoritesRepoImpl;
    
    final result = await repo.clearAllFavorites();

    result.fold(
      (failure) {
        log('❌ Failed to clear favorites: ${failure.message}');
        emit(FavoriteRemoveFailure(errMessage: failure.message));
      },
      (message) {
        log('✅ All favorites cleared: $message');
        emit(FavoriteRemoveSuccess(message: message));
        // إعادة تحميل المفضلات
        getFavorites();
      },
    );
  }
}