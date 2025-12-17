// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/core/helper_functions/on_generate_routes.dart';
import 'package:myapp/core/services/custom_bloc_observer.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/features/splash/presentation/views/splash_view.dart';
import 'package:myapp/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // WebView Debugging
  await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  
  // Bloc Observer
  Bloc.observer = CustomBlocObserver();

  
  // SharedPreferences
  await Prefs.init();
  
  // Dependency Injection
  setupGetIt();
  
  runApp(const FruitApp());
}

class FruitApp extends StatelessWidget {
  const FruitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        fontFamily: 'Cairo',
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar'),
      supportedLocales: S.delegate.supportedLocales,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}