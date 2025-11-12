import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/core/services/get_it_service.dart';
import 'package:google/core/widgets/custom_app_bar.dart';
import 'package:google/features/auth/domain/repos/auth_repo.dart';
import 'package:google/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:google/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const String routeName = 'SignupView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'إنشاء حساب'),
        body: SignupViewBodyBlocConsumer()
      ),
    );
  }
} 
