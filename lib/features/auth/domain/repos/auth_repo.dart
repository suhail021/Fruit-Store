// lib/features/auth/domain/repos/auth_repo.dart
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String gender,
    required int idRole,
    required int idCurrencies,
  });

  Future<Either<Failure, UserEntity>> login({
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, UserEntity>> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<Either<Failure, String>> resendOtp({
    required String phoneNumber,
  });

  Future<void> saveUserData({required UserEntity user});
  
  Future<UserEntity?> getCachedUser();
  
  Future<void> logout();
}