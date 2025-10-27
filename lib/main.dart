import 'package:flutter/material.dart';
import 'package:google/core/helper_functions/on_generate_routes.dart';
import 'package:google/features/splash/presentation/views/splash_view.dart';

void main(){
runApp(const FruitApp());
}

class FruitApp extends StatelessWidget {
  const FruitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}