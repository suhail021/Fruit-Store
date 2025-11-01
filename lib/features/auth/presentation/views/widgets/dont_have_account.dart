import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google/core/utils/app_colors.dart';
import 'package:google/core/utils/app_text_styles.dart';
import 'package:google/features/auth/presentation/views/signup_view.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'لاتمتلك حساب؟ ',
            style: TextStyles.semibold16.copyWith(color: Color(0xff949d9e)),
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                  Navigator.pushNamed(context, SignupView.routeName);
                  },
            text: 'قم بإنشاء حساب',
            style: TextStyles.semibold16.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
