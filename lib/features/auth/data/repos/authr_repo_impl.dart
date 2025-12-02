// lib/features/auth/data/repos/auth_repo_impl.dart
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/custom_exceptions.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/backend_endpoint.dart';
import 'package:myapp/features/auth/data/model/auth_response_model.dart';
import 'package:myapp/features/auth/data/model/user_model..dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl({required this.apiService});

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

      return Right({
        'success': authResponse.success,
        'message': authResponse.message,
        'user': authResponse.user?.toEntity(),
        'otp_required': authResponse.otpRequired ?? false,
      });

    } on ServerException catch (e) {
      log('ServerException in register: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in register: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      // ✅ المفتاح الصحيح هو 'otp_code'
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

  @override
  Future<Either<Failure, String>> resendOtp({
    required String phoneNumber,
  }) async {
    try {
      final requestData = {
        'phone_number': phoneNumber,
      };

      final response = await apiService.post(
        endpoint: ApiConstants.resendOtp,
        data: requestData,
      );

      final message = response['message'] as String;
      return Right(message);

    } on ServerException catch (e) {
      log('ServerException in resendOtp: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in resendOtp: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

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

      final response = await apiService.post(
        endpoint: ApiConstants.login,
        data: requestData,
      );

      final authResponse = AuthResponseModel.fromJson(response);

      if (!authResponse.success || authResponse.user == null) {
        return Left(ServerFailure(authResponse.message));
      }

      await _saveUserDataLocally(authResponse.user!);
      
      if (authResponse.token != null) {
        await Prefs.setString('auth_token', authResponse.token!);
      }

      return Right(authResponse.user!.toEntity());

    } on ServerException catch (e) {
      log('ServerException in login: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in login: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.'));
    }
  }

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    final userModel = UserModel.fromEntity(user);
    await _saveUserDataLocally(userModel);
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    try {
      final userData = await Prefs.getString('user_data');
      if (userData == null) return null;

      final userJson = jsonDecode(userData) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userJson);
      
      return userModel.toEntity();
    } catch (e) {
      log('Exception in getCachedUser: $e');
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await Prefs.remove('user_data');
    await Prefs.remove('auth_token');
  }

  // Helper Methods
  Future<void> _saveUserDataLocally(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await Prefs.setString('user_data', userJson);
  }
}