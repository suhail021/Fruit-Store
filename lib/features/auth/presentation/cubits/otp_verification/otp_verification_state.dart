// lib/features/auth/presentation/cubits/otp_verification/otp_verification_state.dart
part of 'otp_verification_cubit.dart';

sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationLoading extends OtpVerificationState {}

final class OtpVerificationSuccess extends OtpVerificationState {
  final UserEntity user;
  OtpVerificationSuccess({required this.user});
}

final class OtpVerificationFailure extends OtpVerificationState {
  final String message;
  OtpVerificationFailure({required this.message});
}

final class OtpResending extends OtpVerificationState {}

final class OtpResendSuccess extends OtpVerificationState {
  final String message;
  OtpResendSuccess({required this.message});
}

final class OtpResendFailure extends OtpVerificationState {
  final String message;
  OtpResendFailure({required this.message});
}