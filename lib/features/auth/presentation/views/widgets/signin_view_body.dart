// lib/features/auth/presentation/views/widgets/signin_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:myapp/core/widgets/custome_text_form_field.dart';
import 'package:myapp/core/widgets/password_field.dart';
import 'package:myapp/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:myapp/features/auth/presentation/views/widgets/dont_have_account.dart';
import 'package:myapp/features/auth/presentation/views/widgets/or_divider.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  
  late String phoneNumber;
  late String password;

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
            
            // حقل رقم الهاتف
            CustomeTextFormField(
              onSaved: (value) {
                phoneNumber = value!;
              },
              hintText: 'رقم الهاتف',
              textInputType: TextInputType.phone,
              suffixIcon: const Icon(
                Icons.phone,
                color: Color(0xffc9cecf),
              ),
            ),
            const SizedBox(height: 16),

            // حقل كلمة المرور
            PasswordField(
              onsaved: (value) {
                password = value!;
              },
            ),
            const SizedBox(height: 16),

            // يمكنك إضافة "نسيت كلمة المرور؟"
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextButton(
            //     onPressed: () {
            //       // Navigate to forgot password
            //     },
            //     child: const Text('نسيت كلمة المرور؟'),
            //   ),
            // ),

            const SizedBox(height: 33),

            // زر تسجيل الدخول
            CustomButton(
              onPressed: _handleLogin,
              text: "تسجيل الدخول",
            ),
            const SizedBox(height: 33),

            const DontHaveAccount(),
            const SizedBox(height: 33),

            const OrDivider(),
            const SizedBox(height: 20),

            // يمكنك إضافة أزرار تسجيل الدخول الاجتماعي هنا
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      
      // تسجيل الدخول
      context.read<SigninCubit>().login(phoneNumber, password);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}