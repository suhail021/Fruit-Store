import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/constants.dart';
import 'package:google/core/helper_functions/build_error_bar.dart';
import 'package:google/core/widgets/custom_button.dart';
import 'package:google/core/widgets/custome_text_form_field.dart';
import 'package:google/core/widgets/password_field.dart';
import 'package:google/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:google/features/auth/presentation/views/widgets/gender_selector_field.dart';
import 'package:google/features/auth/presentation/views/widgets/have_account.dart';
import 'package:google/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, userName, password;
  late bool isTermsAccepted = false;
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
              CustomeTextFormField(
                onSaved: (value) {
                  userName = value!;
                },
                hintText: 'الاسم كامل',
                textInputType: TextInputType.name,
                suffixIcon: Icon(Icons.person, color: Color(0xffc9cecf)),
              ),
              const SizedBox(height: 16),

              GenderSelectorField(),
              const SizedBox(height: 16),
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

              const SizedBox(height: 10),

              TermsAndConditions(
                onChanged: (bool value) {
                  isTermsAccepted = value;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    if (isTermsAccepted) {
                      context
                          .read<SignupCubit>()
                          .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                            name: userName,
                          );
                    } else {
                      buildErrorBar(
                        context,
                        "يجب عليك الموافقة على الشروط و الاحكام.",
                      );
                    }
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: 'إنشاء حساب جديد',
              ),
              const SizedBox(height: 16),
              HaveAccount(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
