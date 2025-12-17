// lib/features/auth/domain/repos/auth_repo.dart
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  /// التسجيل
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String gender,
    required int idRole,
    required int idCurrencies,
  });

  /// تسجيل الدخول
  Future<Either<Failure, UserEntity>> login({
    required String phoneNumber,
    required String password,
  });

  /// التحقق من OTP
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  /// إعادة إرسال OTP
  Future<Either<Failure, String>> resendOtp({
    required String phoneNumber,
  });

  /// حفظ بيانات المستخدم
  Future<void> saveUserData({required UserEntity user});
  
  /// الحصول على المستخدم المحفوظ
  Future<UserEntity?> getCachedUser();
  
  /// تسجيل الخروج
  Future<void> logout();
}