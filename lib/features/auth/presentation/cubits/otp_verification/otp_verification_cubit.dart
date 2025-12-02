// lib/features/auth/presentation/cubits/otp_verification/otp_verification_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit(this.authRepo) : super(OtpVerificationInitial());

  final AuthRepo authRepo;

  // التحقق من رمز OTP
  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(OtpVerificationLoading());

    final result = await authRepo.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );

    result.fold(
      (failure) => emit(OtpVerificationFailure(message: failure.message)),
      (user) => emit(OtpVerificationSuccess(user: user)),
    );
  }

  // إعادة إرسال رمز OTP
  Future<void> resendOtp({required String phoneNumber}) async {
    emit(OtpResending());

    final result = await authRepo.resendOtp(phoneNumber: phoneNumber);

    result.fold(
      (failure) => emit(OtpResendFailure(message: failure.message)),
      (message) => emit(OtpResendSuccess(message: message)),
    );
  }
}