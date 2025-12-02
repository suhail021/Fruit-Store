// lib/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_progress_hud.dart';
import 'package:myapp/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:myapp/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:myapp/features/auth/presentation/views/otp_verification_view.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        // في حالة النجاح
        if (state is SignupSuccess) {
          // عرض رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          // ✅ إذا كان يتطلب OTP، الانتقال لصفحة التحقق
          if (state.otpRequired && state.user != null) {
            Navigator.pushReplacementNamed(
              context,
              OtpVerificationView.routeName,
              arguments: {
                'phoneNumber': state.user!.phoneNumber,
                'userName': state.user!.name,
              },
            );
          } else {
            // إذا لم يتطلب OTP، العودة للصفحة السابقة
            Navigator.pop(context);
          }
        }

        // في حالة الفشل
        if (state is SignupFailure) {
          showErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is SignupLoading,
          child: const SignupViewBody(),
        );
      },
    );
  }
}