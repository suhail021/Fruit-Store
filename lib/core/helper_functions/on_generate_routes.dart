// lib/core/helper_functions/on_generate_routes.dart
import 'package:flutter/material.dart';
import 'package:myapp/features/auth/presentation/views/signin_view.dart';
import 'package:myapp/features/auth/presentation/views/signup_view.dart';
import 'package:myapp/features/auth/presentation/views/otp_verification_view.dart';
import 'package:myapp/features/home/presentation/views/cart_view.dart';
import 'package:myapp/features/home/presentation/views/favorites_view.dart';
import 'package:myapp/features/home/presentation/views/home_view.dart'; // ✅ إضافة
import 'package:myapp/features/home/presentation/views/main_view.dart';
import 'package:myapp/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:myapp/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());

    case OtpVerificationView.routeName:
      final args = settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        return MaterialPageRoute(
          builder:
              (context) => OtpVerificationView(
                phoneNumber: args['phoneNumber'] as String,
                userName: args['userName'] as String,
              ),
        );
      }

      return MaterialPageRoute(builder: (context) => const SignupView());

    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    case FavoritesView.routeName:
      return MaterialPageRoute(builder: (context) => const FavoritesView());
    case HomeView.routeName: // ✅ إضافة
      return MaterialPageRoute(builder: (context) => const HomeView());
    case MainView.routeName: // ✅ إضافة
      return MaterialPageRoute(builder: (context) => const MainView());
    case CartView.routeName: // ✅ إضافة
      return MaterialPageRoute(builder: (context) => const CartView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
