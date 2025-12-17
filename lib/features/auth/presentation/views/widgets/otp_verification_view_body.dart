// lib/features/auth/presentation/views/widgets/otp_verification_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:myapp/core/widgets/custom_progress_hud.dart';
import 'package:myapp/features/auth/presentation/cubits/otp_verification/otp_verification_cubit.dart';
import 'package:myapp/features/home/presentation/views/main_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationViewBody extends StatefulWidget {
  final String phoneNumber;
  final String userName;

  const OtpVerificationViewBody({
    super.key,
    required this.phoneNumber,
    required this.userName,
  });

  @override
  State<OtpVerificationViewBody> createState() =>
      _OtpVerificationViewBodyState();
}

class _OtpVerificationViewBodyState extends State<OtpVerificationViewBody> {
  String otpCode = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
      listener: (context, state) {
        // نجح التحقق
        if (state is OtpVerificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم التحقق بنجاح! مرحباً بك'),
              backgroundColor: Colors.green,
            ),
          );
          // الانتقال للصفحة الرئيسية
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainView.routeName,
            (route) => false,
          );
        }
        // فشل التحقق
        if (state is OtpVerificationFailure) {
          showErrorBar(context, state.message);
        }

        // نجحت إعادة الإرسال
        if (state is OtpResendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.blue,
            ),
          );
        }

        // فشلت إعادة الإرسال
        if (state is OtpResendFailure) {
          showErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is OtpVerificationLoading || state is OtpResending,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizintalPadding,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    // أيقونة الرسالة
                    const Icon(
                      Icons.message_outlined,
                      size: 80,
                      color: Color(0xff1B5E37),
                    ),
                    const SizedBox(height: 24),

                    // العنوان
                    Text(
                      'مرحباً ${widget.userName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // الوصف
                    Text(
                      'أدخل رمز التحقق المرسل إلى',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.phoneNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1B5E37),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // حقل إدخال OTP
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        onChanged: (value) {
                          otpCode = value;
                        },
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 45,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: const Color(0xff1B5E37),
                          inactiveColor: Colors.grey[300],
                          selectedColor: const Color(0xff1B5E37),
                        ),
                        enableActiveFill: true,
                        cursorColor: const Color(0xff1B5E37),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // زر التحقق
                    CustomButton(
                      onPressed: () {
                        if (otpCode.length == 6) {
                          context.read<OtpVerificationCubit>().verifyOtp(
                            phoneNumber: widget.phoneNumber,
                            otp: otpCode,
                          );
                        } else {
                          showErrorBar(context, 'يرجى إدخال رمز التحقق كاملاً');
                        }
                      },
                      text: 'تحقق',
                    ),
                    const SizedBox(height: 16),

                    // زر إعادة الإرسال
                    TextButton(
                      onPressed: () {
                        context.read<OtpVerificationCubit>().resendOtp(
                          phoneNumber: widget.phoneNumber,
                        );
                      },
                      child: const Text(
                        'لم يصلك الرمز؟ إعادة الإرسال',
                        style: TextStyle(
                          color: Color(0xff1B5E37),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
