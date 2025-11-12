import 'package:flutter/material.dart';
import 'package:google/constants.dart';
import 'package:google/core/services/shared_preferences_singleton.dart';
import 'package:google/core/utils/app_text_styles.dart';
import 'package:google/features/auth/presentation/views/signin_view.dart';
import 'package:svg_flutter/svg.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subtitle,
    required this.title,
    required this.isvisible,
  });
  final String image, backgroundImage;
  final String subtitle;
  final Widget title;
  final bool isvisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(image),
              ),
              Visibility(
                visible: isvisible,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: (){
                    Prefs.setBool(kIsOnBoardingViewSeen, true); 
                       Navigator.of(context).pushReplacementNamed(SigninView.routeName);
                    },
                    child: Text(
                      "تخط",
                      style: TextStyles.regular13.copyWith(
                        color: Color(0xff949d9e),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40.0),

        title,
        const SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyles.semibold13.copyWith(color: Color(0xff4e5456)),
          ),
        ),
      ],
    );
  }
}
