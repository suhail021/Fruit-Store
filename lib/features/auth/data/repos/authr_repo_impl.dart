import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/services/firebase_auth_service.dart';
import 'package:myapp/features/auth/data/model/user_model.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

class AuthrRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthrRepoImpl({required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(UserModel.fromfirebaseUser(user));
    } on CustomExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}");
      return Left(ServerFailure('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }


  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(String email, String password)async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(UserModel.fromfirebaseUser(user));
    } on CustomExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}");
      return Left(ServerFailure('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
      try {
      var user = await firebaseAuthService.signInWithGoogle();
      return Right(UserModel.fromfirebaseUser(user));
    } catch (e) {
      log("Exception in AuthRepoImpl.signinWithGoogle: ${e.toString()}");
      return Left(ServerFailure('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }
  


  
  
}

