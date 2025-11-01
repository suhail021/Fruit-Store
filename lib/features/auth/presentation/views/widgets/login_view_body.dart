import 'package:flutter/material.dart';
import 'package:google/constants.dart';
import 'package:google/core/utils/app_colors.dart';
import 'package:google/core/utils/app_images.dart';
import 'package:google/core/utils/app_text_styles.dart';
import 'package:google/core/widgets/custom_button.dart';
import 'package:google/core/widgets/custome_text_form_field.dart';
import 'package:google/features/auth/presentation/views/widgets/dont_have_account.dart';
import 'package:google/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:google/features/auth/presentation/views/widgets/social_login_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
      child: Column(
        children: [
          const SizedBox(height: 24),
          CustomeTextFormField(
            hintText: 'رقم الهاتف',
            textInputType: TextInputType.phone,
            suffixIcon: Icon(Icons.phone, color: Color(0xffc9cecf)),
          ),
          const SizedBox(height: 16),

          CustomeTextFormField(
            suffixIcon: Icon(Icons.remove_red_eye, color: Color(0xffc9cecf)),
            hintText: 'كلمة المرور',
            textInputType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'نسيت كلمة المرور؟',
                style: TextStyles.semibold13.copyWith(
                  color: AppColors.lightPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 33),

          CustomButton(onPressed: () {}, text: "تسجيل الدخول"),
          SizedBox(height: 33),

          const DontHaveAccount(),
          SizedBox(height: 33),

          const OrDivider(),
          SizedBox(height: 20),

          SocialLoginButton(
            image: Assets.imagesGoogleIcon,
            title: 'التسجيل بواسطة جوجل',
            onPressed: () {},
          ),
          SizedBox(height: 16),

          SocialLoginButton(
            image: Assets.imagesFacebookIcon,
            title: 'التسجيل بواسطة فيسبوك',
            onPressed: () {},
          ),
          SizedBox(height: 16),

          SocialLoginButton(
            image: Assets.imagesAppleIcon,
            title: 'التسجيل بواسطة ابل',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
