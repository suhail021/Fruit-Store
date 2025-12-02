// lib/features/auth/presentation/views/otp_verification_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';
import 'package:myapp/features/auth/presentation/cubits/otp_verification/otp_verification_cubit.dart';
import 'package:myapp/features/auth/presentation/views/widgets/otp_verification_view_body.dart';

class OtpVerificationView extends StatelessWidget {
  final String phoneNumber;
  final String userName;

  const OtpVerificationView({
    super.key,
    required this.phoneNumber,
    required this.userName,
  });

  static const String routeName = 'OtpVerificationView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'التحقق من رقم الهاتف'),
        body: OtpVerificationViewBody(
          phoneNumber: phoneNumber,
          userName: userName,
        ),
      ),
    );
  }
}