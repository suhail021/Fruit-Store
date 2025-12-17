// lib/features/auth/presentation/cubits/signup_cubit/signup_state.dart
part of 'signup_cubit.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserEntity? user;
  final String message;
  final bool otpRequired;
  final String phoneNumber; // ✅ إضافة رقم الهاتف

  SignupSuccess({
    this.user,
    required this.message,
    this.otpRequired = true, // ✅ افتراضياً true
    required this.phoneNumber,
  });
}

final class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}