// lib/features/favorites/data/repos/favorites_repo_impl.dart
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/entities/favorite_entity.dart';
import 'package:myapp/core/errors/custom_exceptions.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/models/favorite_model.dart';
import 'package:myapp/core/repos/favorites_repo/favorites_repo.dart';
import 'package:myapp/core/services/api_service.dart'; // ✅ إضافة
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/api_constants.dart';


class FavoritesRepoImpl implements FavoritesRepo {
  final ApiService apiService; // ✅ إضافة ApiService
  
  FavoritesRepoImpl({required this.apiService}); // ✅ Constructor

  static const String _favoritesKey = 'local_favorites';

  // ==========================================
  // الحصول على المفضلات (من API + حفظ محلياً)
  // ==========================================
  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites() async {
    try {
      final token = Prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        // إذا لم يكن هناك token، جلب من التخزين المحلي فقط
        return _getLocalFavorites();
      }

      log('❤️ Syncing favorites from API...');

      // ✅ جلب المفضلات من API
      final response = await apiService.post(
        endpoint: ApiConstants.favorites,
        data: {}, // empty body
        headers: ApiConstants.headersWithToken(token),
      );

      final favoritesData = response['favorites'] as List;
      final favorites = favoritesData
          .map((json) => FavoriteModel.fromJson(json) as FavoriteEntity)
          .toList();

      // ✅ حفظ المفضلات محلياً بعد جلبها من API
      await _saveFavorites(favorites);

      log('✅ Synced ${favorites.length} favorites from API');
      return Right(favorites);

    } on ServerException catch (e) {
      log('❌ ServerException in getFavorites: ${e.message}');
      log('⚠️ Falling back to local favorites');
      
      // في حالة فشل API، استخدم التخزين المحلي
      return _getLocalFavorites();
      
    } catch (e) {
      log('❌ Exception in getFavorites: $e');
      log('⚠️ Falling back to local favorites');
      
      // في حالة فشل API، استخدم التخزين المحلي
      return _getLocalFavorites();
    }
  }

  // ==========================================
  // الحصول على المفضلات من التخزين المحلي فقط
  // ==========================================
  Future<Either<Failure, List<FavoriteEntity>>> _getLocalFavorites() async {
    try {
      log('📱 Getting favorites from local storage...');

      final favoritesJson = Prefs.getString(_favoritesKey);

      if (favoritesJson == null || favoritesJson.isEmpty) {
        log('✅ No local favorites found');
        return const Right([]);
      }

      final List<dynamic> favoritesList = jsonDecode(favoritesJson);
      final favorites = favoritesList
          .map((json) => FavoriteModel.fromJson(json) as FavoriteEntity)
          .toList();

      log('✅ Retrieved ${favorites.length} favorites from local storage');
      return Right(favorites);

    } catch (e) {
      log('❌ Exception in _getLocalFavorites: $e');
      return Left(CacheFailure('حدث خطأ أثناء تحميل المفضلات'));
    }
  }

  // ==========================================
  // إضافة منتج للمفضلة (محلي فقط)
  // ==========================================
  Future<Either<Failure, String>> addFavorite({
    required int productId,
    required String productName,
    String? productDescription,
    String? img,
    double? price,
    double? finalPrice,
    required String productLink,
  }) async {
    try {
      log('➕ Adding product to local favorites: $productName');

      // الحصول على المفضلات المحلية
      final localResult = await _getLocalFavorites();
      
      if (localResult.isLeft()) {
        return Left(CacheFailure('فشل في الوصول إلى المفضلات'));
      }

      final favorites = localResult.getOrElse(() => []).toList();

      // التحقق من عدم وجود المنتج
      final exists = favorites.any((fav) => fav.idProducts == productId);
      
      if (exists) {
        return const Right('المنتج موجود بالفعل في المفضلة');
      }

      // إنشاء المفضلة الجديدة
      final newFavorite = FavoriteModel(
        idFavorites: DateTime.now().millisecondsSinceEpoch,
        idUser: 0,
        idProducts: productId,
        productName: productName,
        productDescription: productDescription,
        img: img,
        price: price,
        finalPrice: finalPrice,
        productLink: productLink,
        createdAt: DateTime.now(),
      );

      favorites.add(newFavorite);
      await _saveFavorites(favorites);

      // ✅ إرسال للـ API في الخلفية (اختياري)
      _syncToAPI(productId, isAdding: true);

      log('✅ Product added to local favorites');
      return const Right('تمت إضافة المنتج إلى المفضلة');

    } catch (e) {
      log('❌ Exception in addFavorite: $e');
      return Left(CacheFailure('حدث خطأ غير متوقع'));
    }
  }

  // ==========================================
  // حذف من المفضلة (محلي فقط)
  // ==========================================
  @override
  Future<Either<Failure, String>> removeFavorite({
    required int favoriteId,
  }) async {
    try {
      log('🗑️ Removing favorite #$favoriteId from local storage');

      final localResult = await _getLocalFavorites();
      
      if (localResult.isLeft()) {
        return Left(CacheFailure('فشل في الوصول إلى المفضلات'));
      }

      final favorites = localResult.getOrElse(() => []).toList();

      // حذف المفضلة
      favorites.removeWhere((fav) => fav.idFavorites == favoriteId);
      await _saveFavorites(favorites);

      log('✅ Favorite removed from local storage');
      return const Right('تم حذف المنتج من المفضلة');

    } catch (e) {
      log('❌ Exception in removeFavorite: $e');
      return Left(CacheFailure('حدث خطأ غير متوقع'));
    }
  }

  // ==========================================
  // حذف منتج من المفضلة باستخدام Product ID
  // ==========================================
  Future<Either<Failure, String>> removeFavoriteByProductId({
    required int productId,
  }) async {
    try {
      log('🗑️ Removing favorite for product #$productId');

      final localResult = await _getLocalFavorites();
      
      if (localResult.isLeft()) {
        return Left(CacheFailure('فشل في الوصول إلى المفضلات'));
      }

      final favorites = localResult.getOrElse(() => []).toList();

      // حذف المفضلة
      favorites.removeWhere((fav) => fav.idProducts == productId);
      await _saveFavorites(favorites);

      // ✅ إرسال للـ API في الخلفية (اختياري)
      _syncToAPI(productId, isAdding: false);

      log('✅ Favorite removed by product ID');
      return const Right('تم حذف المنتج من المفضلة');

    } catch (e) {
      log('❌ Exception in removeFavoriteByProductId: $e');
      return Left(CacheFailure('حدث خطأ غير متوقع'));
    }
  }

  // ==========================================
  // Toggle المفضلة (محلي فقط)
  // ==========================================
  @override
  Future<Either<Failure, String>> toggleFavorite({
    required int productId,
  }) async {
    try {
      log('💝 Toggling favorite for product #$productId');

      final localResult = await _getLocalFavorites();
      
      if (localResult.isLeft()) {
        return Left(CacheFailure('فشل في الوصول إلى المفضلات'));
      }

      final favorites = localResult.getOrElse(() => []);

      // التحقق من وجود المنتج
      final existingIndex = favorites.indexWhere(
        (fav) => fav.idProducts == productId,
      );

      if (existingIndex != -1) {
        // المنتج موجود - حذفه
        favorites.removeAt(existingIndex);
        await _saveFavorites(favorites);
        
        // ✅ إرسال للـ API في الخلفية
        _syncToAPI(productId, isAdding: false);
        
        log('✅ Product removed from favorites');
        return const Right('تم إزالة المنتج من المفضلة');
      } else {
        log('⚠️ Cannot toggle: Product data required for adding');
        return Left(CacheFailure('لإضافة المنتج، استخدم addFavorite مع البيانات الكاملة'));
      }

    } catch (e) {
      log('❌ Exception in toggleFavorite: $e');
      return Left(CacheFailure('حدث خطأ غير متوقع'));
    }
  }

  // ==========================================
  // التحقق من وجود منتج في المفضلة
  // ==========================================
  @override
  Future<Either<Failure, bool>> checkFavorite({
    required int productId,
  }) async {
    try {
      final localResult = await _getLocalFavorites();
      
      if (localResult.isLeft()) {
        return const Right(false);
      }

      final favorites = localResult.getOrElse(() => []);
      final exists = favorites.any((fav) => fav.idProducts == productId);

      return Right(exists);

    } catch (e) {
      log('❌ Exception in checkFavorite: $e');
      return const Right(false);
    }
  }

  // ==========================================
  // حذف جميع المفضلات
  // ==========================================
  Future<Either<Failure, String>> clearAllFavorites() async {
    try {
      log('🗑️ Clearing all local favorites');

      await Prefs.remove(_favoritesKey);

      log('✅ All favorites cleared');
      return const Right('تم حذف جميع المفضلات');

    } catch (e) {
      log('❌ Exception in clearAllFavorites: $e');
      return Left(CacheFailure('حدث خطأ غير متوقع'));
    }
  }

  // ==========================================
  // Helper: حفظ المفضلات في SharedPreferences
  // ==========================================
  Future<void> _saveFavorites(List<FavoriteEntity> favorites) async {
    final favoritesList = favorites
        .map((fav) => (fav as FavoriteModel).toJson())
        .toList();

    final favoritesJson = jsonEncode(favoritesList);
    await Prefs.setString(_favoritesKey, favoritesJson);
  }

  // ==========================================
  // Helper: مزامنة مع API في الخلفية (اختياري)
  // ==========================================
  Future<void> _syncToAPI(int productId, {required bool isAdding}) async {
    try {
      final token = Prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        log('⚠️ No token, skipping API sync');
        return;
      }

      if (isAdding) {
        log('🔄 Syncing add to API...');
        await apiService.post(
          endpoint: ApiConstants.favoritesToggle,
          data: {'id_products': productId},
          headers: ApiConstants.headersWithToken(token),
        );
        log('✅ Add synced to API');
      } else {
        log('🔄 Syncing remove to API...');
        await apiService.post(
          endpoint: ApiConstants.favoritesToggle,
          data: {'id_products': productId},
          headers: ApiConstants.headersWithToken(token),
        );
        log('✅ Remove synced to API');
      }
    } catch (e) {
      log('⚠️ Failed to sync to API (non-critical): $e');
      // نتجاهل الخطأ لأن المزامنة اختيارية
    }
  }
}