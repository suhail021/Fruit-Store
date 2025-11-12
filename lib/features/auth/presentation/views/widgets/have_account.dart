import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google/core/utils/app_colors.dart';
import 'package:google/core/utils/app_text_styles.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'تمتلك حساب بالفعل؟ ',
            style: TextStyles.semibold16.copyWith(color: Color(0xff949d9e)),
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                  Navigator.pop(context);
                  },
            text: 'تسجيل الدخول',
            style: TextStyles.semibold16.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
