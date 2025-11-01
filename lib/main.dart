import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google/core/helper_functions/on_generate_routes.dart';
import 'package:google/core/services/shared_preferences_singleton.dart';
import 'package:google/core/utils/app_colors.dart';
import 'package:google/features/splash/presentation/views/splash_view.dart';
import 'package:google/generated/l10n.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Prefs.init();
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
       localizationsDelegates: [
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