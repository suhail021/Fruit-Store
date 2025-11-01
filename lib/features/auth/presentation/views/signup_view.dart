import 'package:flutter/material.dart';
import 'package:google/core/widgets/custom_app_bar.dart';
import 'package:google/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
static const String routeName = 'SignupView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'إنشاء حساب'),
      body: SignupViewBody(),
    );
    
  }
}