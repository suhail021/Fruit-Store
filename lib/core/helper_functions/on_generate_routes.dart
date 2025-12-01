import 'package:flutter/material.dart';
import 'package:myapp/features/auth/presentation/views/signin_view.dart';
import 'package:myapp/features/auth/presentation/views/signup_view.dart';
import 'package:myapp/features/checkout/presentation/views/checkout_success.dart';
import 'package:myapp/features/checkout/presentation/views/checkout_view.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_entity.dart';
import 'package:myapp/features/home/presentation/views/main_view.dart';
import 'package:myapp/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:myapp/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case CheckoutSuccess.routeName:
      return MaterialPageRoute(builder: (context) => const CheckoutSuccess());
    case CheckoutView.routeName:
      return MaterialPageRoute(
        builder:
            (context) =>
                CheckoutView(cartEntity: settings.arguments as CartEntity),
      );
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
