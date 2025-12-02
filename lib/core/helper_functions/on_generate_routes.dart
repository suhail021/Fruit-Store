import 'package:flutter/material.dart';
import 'package:myapp/features/auth/presentation/views/home_view.dart';
import 'package:myapp/features/auth/presentation/views/otp_verification_view.dart';
import 'package:myapp/features/auth/presentation/views/signin_view.dart';
import 'package:myapp/features/auth/presentation/views/signup_view.dart';
import 'package:myapp/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:myapp/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());

    // ✅ معالجة OTP View بشكل صحيح
    case OtpVerificationView.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      
      if (args != null) {
        return MaterialPageRoute(
          builder: (context) => OtpVerificationView(
            phoneNumber: args['phoneNumber'] as String,
            userName: args['userName'] as String,
          ),
        );
      }
      
      // في حالة عدم وجود arguments، العودة لصفحة التسجيل
      return MaterialPageRoute(builder: (context) => const SignupView());

    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}