// lib/features/auth/data/repos/auth_repo_impl.dartؤ// lib/features/auth/data/repos/auth_repo_impl.dart
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/custom_exceptions.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/api_constants.dart';
import 'package:myapp/features/auth/data/model/auth_response_model.dart';
import 'package:myapp/features/auth/data/model/user_model.dart';

import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

// ❌ لا تستورد من get_user.dart
// import 'package:myapp/core/helper_functions/get_user.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl({required this.apiService});

  // ==========================================
  // التسجيل (Register)
  // ==========================================
  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String gender,
    required int idRole,
    required int idCurrencies,
  }) async {
    try {
      final requestData = {
        'name': name,
        'phone_number': phoneNumber,
        'password': password,
        'gender': gender,
        'id_role': idRole,
        'id_currencies': idCurrencies,
      };

      log('📝 Registering user: $phoneNumber');

      final response = await apiService.post(
        endpoint: ApiConstants.register,
        data: requestData,
      );

      final authResponse = AuthResponseModel.fromJson(response);

      if (!authResponse.success) {
        return Left(ServerFailure(authResponse.message));
      }

      if (authResponse.user != null) {
        await _saveUserDataLocally(authResponse.user!);
      }

      log('✅ Registration successful!');

      return Right({
        'success': authResponse.success,
        'message': authResponse.message,
        'user': authResponse.user?.toEntity(),
        'otp_required': authResponse.otpRequired ?? true,
      });

    } on ServerException catch (e) {
      log('❌ ServerException in register: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in register: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

  // ==========================================
  // تسجيل الدخول (Login)
  // ==========================================
  @override
  Future<Either<Failure, UserEntity>> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final requestData = {
        'phone_number': phoneNumber,
        'password': password,
      };

      log('🔐 Login attempt for: $phoneNumber');

      final response = await apiService.post(
        endpoint: ApiConstants.login,
        data: requestData,
      );

      final loginResponse = LoginResponseModel.fromJson(response);

      if (!loginResponse.success || loginResponse.user == null) {
        return Left(ServerFailure(loginResponse.message));
      }

      // حفظ بيانات المستخدم
      await _saveUserDataLocally(loginResponse.user!);
      
      // حفظ التوكن
      if (loginResponse.token != null) {
        await Prefs.setString('auth_token', loginResponse.token!);
        log('✅ Token saved: ${loginResponse.token}');
      }

      // حفظ العناوين
      if (loginResponse.addresses != null && loginResponse.addresses!.isNotEmpty) {
        await _saveAddresses(loginResponse.addresses!);
        log('✅ Saved ${loginResponse.addresses!.length} addresses');
      }
      
      // حفظ المفضلة
      if (loginResponse.favorites != null && loginResponse.favorites!.isNotEmpty) {
        await _saveFavorites(loginResponse.favorites!);
        log('✅ Saved ${loginResponse.favorites!.length} favorites');
      }

      // حفظ بيانات إضافية
      if (loginResponse.referralData != null) {
        await _saveReferralData(loginResponse.referralData!);
      }

      if (loginResponse.stats != null) {
        await _saveStats(loginResponse.stats!);
      }

      log('✅ Login successful! User: ${loginResponse.user!.name}');
      return Right(loginResponse.user!.toEntity());

    } on ServerException catch (e) {
      log('❌ ServerException in login: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in login: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

  // ==========================================
  // التحقق من OTP
  // ==========================================
  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final requestData = {
        'phone_number': phoneNumber,
        'otp_code': otp,
      };

      log('🔍 Verifying OTP for: $phoneNumber');

      final response = await apiService.post(
        endpoint: ApiConstants.verifyOtp,
        data: requestData,
      );

      final authResponse = AuthResponseModel.fromJson(response);

      if (!authResponse.success || authResponse.user == null) {
        return Left(ServerFailure(authResponse.message));
      }

      // حفظ بيانات المستخدم
      await _saveUserDataLocally(authResponse.user!);
      
      // حفظ التوكن
      if (authResponse.token != null) {
        await Prefs.setString('auth_token', authResponse.token!);
        log('✅ Token saved successfully');
      }

      log('✅ OTP verification successful!');
      return Right(authResponse.user!.toEntity());

    } on ServerException catch (e) {
      log('❌ ServerException in verifyOtp: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in verifyOtp: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

  // ==========================================
  // إعادة إرسال OTP
  // ==========================================
  @override
  Future<Either<Failure, String>> resendOtp({
    required String phoneNumber,
  }) async {
    try {
      final requestData = {
        'phone_number': phoneNumber,
      };

      log('🔄 Resending OTP for: $phoneNumber');

      final response = await apiService.post(
        endpoint: ApiConstants.resendOtp,
        data: requestData,
      );

      final message = response['message'] as String;
      log('✅ OTP resent successfully');
      
      return Right(message);

    } on ServerException catch (e) {
      log('❌ ServerException in resendOtp: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in resendOtp: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

  // ==========================================
  // حفظ بيانات المستخدم
  // ==========================================
  @override
  Future<void> saveUserData({required UserEntity user}) async {
    final userModel = UserModel.fromEntity(user);
    await _saveUserDataLocally(userModel);
  }

  // ==========================================
  // الحصول على المستخدم المحفوظ
  // ==========================================
  @override
  Future<UserEntity?> getCachedUser() async {
    try {
      final userData = Prefs.getString('user_data');
      if (userData == null || userData.isEmpty) return null;

      final userJson = jsonDecode(userData) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userJson);
      
      log('✅ User loaded from cache: ${userModel.name}');
      return userModel.toEntity();
    } catch (e) {
      log('❌ Exception in getCachedUser: $e');
      return null;
    }
  }

  // ==========================================
  // تسجيل الخروج
  // ==========================================
  @override
  Future<void> logout() async {
    await Prefs.remove('user_data');
    await Prefs.remove('auth_token');
    await Prefs.remove('addresses');
    await Prefs.remove('favorites');
    await Prefs.remove('referral_data');
    await Prefs.remove('stats');
    log('✅ User logged out successfully');
  }

  // ==========================================
  // Helper Methods (Private)
  // ==========================================

  Future<void> _saveUserDataLocally(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await Prefs.setString('user_data', userJson);
  }

  Future<void> _saveAddresses(List<AddressData> addresses) async {
    final addressesJson = jsonEncode(
      addresses.map((e) => {
        'id_addresses': e.idAddresses,
        'country': e.country,
        'city': e.city,
        'street': e.street,
        'postal_code': e.postalCode,
        'is_default': e.isDefault,
        'description_addresses': e.descriptionAddresses,
      }).toList(),
    );
    await Prefs.setString('addresses', addressesJson);
  }

  Future<void> _saveFavorites(List<FavoriteData> favorites) async {
    final favoritesJson = jsonEncode(
      favorites.map((e) => {
        'id_favorites': e.idFavorites,
        'product_name': e.productName,
        'product_description': e.productDescription,
        'img': e.img,
        'product_link': e.productLink,
        'created_at': e.createdAt.toIso8601String(),
      }).toList(),
    );
    await Prefs.setString('favorites', favoritesJson);
  }

  Future<void> _saveReferralData(ReferralData referralData) async {
    final referralJson = jsonEncode({
      'my_code': referralData.myCode,
      'total_referrals': referralData.totalReferrals,
      'completed_referrals': referralData.completedReferrals,
      'total_rewards': referralData.totalRewards,
    });
    await Prefs.setString('referral_data', referralJson);
  }

  Future<void> _saveStats(StatsData stats) async {
    final statsJson = jsonEncode({
      'total_orders': stats.totalOrders,
      'completed_orders': stats.completedOrders,
      'total_spent': stats.totalSpent,
    });
    await Prefs.setString('stats', statsJson);
  }
}