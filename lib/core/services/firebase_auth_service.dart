import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' ;
import 'package:myapp/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "FirebaseAuthException in createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'weak-password') {
        throw CustomExceptions(message: 'الرقم السري ضعيف جدا.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions(
          message: 'لقد قمت بالتسجيل مسبقا. الرجاء تسجيل الدخول',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(message: 'تاكد من اتصالك بالانترنت .');
      } else {
        throw CustomExceptions(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        );
      }
    } catch (e) {
      log(
        "FirebaseAuthException in createUserWithEmailAndPassword: ${e.toString()}",
      );

      throw CustomExceptions(
        message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
      );
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "FirebaseAuthException in signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'user-not-found') {
        throw CustomExceptions(
          message: 'الرقم السري او البريد الالكتروني غير صحيح.',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomExceptions(
          message: 'الرقم السري او البريد الالكتروني غير صحيح.',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(message: 'تاكد من اتصالك بالانترنت .');
      } else {
        throw CustomExceptions(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        );
      }
    } catch (e) {
      log(
        "FirebaseAuthException in signInWithEmailAndPassword: ${e.toString()}",
      );

      throw CustomExceptions(
        message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
      );
    }
  }

Future<User> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
}
}
