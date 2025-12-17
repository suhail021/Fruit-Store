// lib/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart
import 'dart:developer'; // ✅ إضافة
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
        if (state is SignupSuccess) {
          log('🎉 SignupSuccess state received');
          log('   - otpRequired: ${state.otpRequired}');
          log('   - user: ${state.user?.name}');
          log('   - phoneNumber: ${state.phoneNumber}');

          // عرض رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
            ),
          );

          // ✅ الانتقال لصفحة OTP (بدون شروط معقدة)
          // نستخدم phoneNumber من الـ state مباشرة
          Future.delayed(const Duration(milliseconds: 500), () {
            log('🚀 Navigating to OTP screen...');
            
            Navigator.pushReplacementNamed(
              context,
              OtpVerificationView.routeName,
              arguments: {
                'phoneNumber': state.phoneNumber,
                'userName': state.user?.name ?? 'مستخدم',
              },
            );
          });
        }

        if (state is SignupFailure) {
          log('❌ SignupFailure: ${state.message}');
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