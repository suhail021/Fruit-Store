
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:myapp/core/widgets/custome_text_form_field.dart';
import 'package:myapp/core/widgets/password_field.dart';
import 'package:myapp/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:myapp/features/auth/presentation/views/widgets/dont_have_account.dart';
import 'package:myapp/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:myapp/features/auth/presentation/views/widgets/social_login_button.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
late String email, password;

class _SigninViewBodyState extends State<SigninViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
      child: Form(
        key: formkey,
        autovalidateMode: autovalidateMode,

        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomeTextFormField(
              onSaved: (value) {
                email = value!;
              },
              hintText: 'البريد الالكتروني ',
              textInputType: TextInputType.emailAddress,
              suffixIcon: Icon(Icons.phone, color: Color(0xffc9cecf)),
            ),
            const SizedBox(height: 16),

            PasswordField(
              onsaved: (value) {
                password = value!; 
              },
            ),
            SizedBox(height: 16),

            SizedBox(height: 33),

            CustomButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  context.read<SigninCubit>().signin(
                    email,
                    password ,
                  ); 
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              text: "تسجيل الدخول",
            ),
            SizedBox(height: 33),

            const DontHaveAccount(),
            SizedBox(height: 33),

            const OrDivider(),
            SizedBox(height: 20),

            SocialLoginButton(
              image: Assets.imagesGoogleIcon,
              title: 'التسجيل بواسطة جوجل',
              onPressed: () {
                context.read<SigninCubit>().signinWithGoogle();
              },
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
      ),
    );
  }
}
