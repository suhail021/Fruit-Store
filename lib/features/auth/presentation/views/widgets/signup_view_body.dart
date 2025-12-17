// lib/features/auth/presentation/views/widgets/signup_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:myapp/core/widgets/custome_text_form_field.dart';
import 'package:myapp/core/widgets/password_field.dart';
import 'package:myapp/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:myapp/features/auth/presentation/views/widgets/gender_selector_field.dart';
import 'package:myapp/features/auth/presentation/views/widgets/have_account.dart';
import 'package:myapp/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // المتغيرات المطلوبة للتسجيل
  late String name; // الاسم
  late String phoneNumber; // رقم الهاتف
  late String password; // كلمة المرور
  String? gender; // الجنس (male/female)
  bool isTermsAccepted = false; // الموافقة على الشروط

  // القيم الثابتة (يمكن تغييرها حسب الحاجة)
  final int idRole = 1; // دور المستخدم (1 = عميل عادي)
  final int idCurrencies = 1; // العملة الافتراضية

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Form(
          key: formkey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),

              // 1️⃣ حقل الاسم الكامل
              CustomeTextFormField(
                onSaved: (value) {
                  name = value!;
                },
                hintText: 'الاسم الكامل',
                textInputType: TextInputType.name,
                suffixIcon: const Icon(Icons.person, color: Color(0xffc9cecf)),
              ),
              const SizedBox(height: 16),

              // 2️⃣ حقل اختيار الجنس
              GenderSelectorField(
                onChanged: (value) {
                  gender = value;
                },
              ),
              const SizedBox(height: 16),

              // 3️⃣ حقل رقم الهاتف (بدلاً من البريد الإلكتروني)
              CustomeTextFormField(
                onSaved: (value) {
                  phoneNumber = value!;
                },
                hintText: 'رقم الهاتف',
                textInputType: TextInputType.phone,
                suffixIcon: const Icon(Icons.phone, color: Color(0xffc9cecf)),
              ),
              const SizedBox(height: 16),

              // 4️⃣ حقل كلمة المرور
              PasswordField(
                onsaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 10),

              // 5️⃣ الموافقة على الشروط والأحكام
              TermsAndConditions(
                onChanged: (bool value) {
                  isTermsAccepted = value;
                },
              ),
              const SizedBox(height: 20),

              // 6️⃣ زر إنشاء الحساب
              CustomButton(onPressed: _handleSignup, text: 'إنشاء حساب جديد'),
              const SizedBox(height: 16),

              // 7️⃣ رابط تسجيل الدخول
              const HaveAccount(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // دالة معالجة التسجيل
  void _handleSignup() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      if (gender == null) {
        showErrorBar(context, 'يرجى اختيار الجنس');
        return;
      }

      if (!isTermsAccepted) {
        showErrorBar(context, 'يجب عليك الموافقة على الشروط والأحكام');
        return;
      }

      // ✅ Logging
      print('📝 Submitting registration:');
      print('   Name: $name');
      print('   Phone: $phoneNumber');
      print('   Gender: $gender');

      context.read<SignupCubit>().register(
        name: name,
        phoneNumber: phoneNumber,
        password: password,
        gender: gender!,
        idRole: idRole,
        idCurrencies: idCurrencies,
      );
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
