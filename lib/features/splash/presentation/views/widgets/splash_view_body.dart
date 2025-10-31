import 'package:flutter/material.dart';
import 'package:google/constants.dart';
import 'package:google/core/services/shared_preferences_singleton.dart';
import 'package:google/core/utils/app_images.dart';
import 'package:google/features/auth/presentation/views/login_view.dart';
import 'package:google/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:svg_flutter/svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNaviagtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [SvgPicture.asset(Assets.imagesPlant)],
        ),
        SvgPicture.asset(Assets.imagesLogo),
        SvgPicture.asset(Assets.imagesSplashBottom),
      ],   
    );
  }

  void excuteNaviagtion() {
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 3), () {
      if (isOnBoardingViewSeen) {
  Navigator.pushReplacementNamed(context, LoginView.routeName);
  
}else{
    Navigator.pushReplacementNamed(context, OnBoardingView.routeName);

}
    });
  }
}
