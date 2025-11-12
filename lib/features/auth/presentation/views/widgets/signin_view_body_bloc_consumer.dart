import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_progress_hud.dart';
import 'package:myapp/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:myapp/features/auth/presentation/views/widgets/signin_view_body.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {

        }
        if (state is SigninFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is SigninLoading ? true : false,
          child: SigninViewBody(),
        );
      },
    );
  }
}

