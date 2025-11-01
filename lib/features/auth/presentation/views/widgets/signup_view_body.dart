import 'package:flutter/material.dart';
import 'package:google/constants.dart';
import 'package:google/core/widgets/custome_text_form_field.dart';
import 'package:google/features/auth/presentation/views/widgets/gender_selector_field.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomeTextFormField(
              hintText: 'الاسم كامل',
              textInputType: TextInputType.name,
              suffixIcon: Icon(Icons.person, color: Color(0xffc9cecf)),
            ),
            const SizedBox(height: 16),

            GenderSelectorField(),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),

            CustomeTextFormField(
              suffixIcon: Icon(Icons.remove_red_eye, color: Color(0xffc9cecf)),
              hintText: 'تأكيد كلمة المرور',
              textInputType: TextInputType.visiblePassword,
            ),
          ],
        ),
      ),
    );
  }
}
