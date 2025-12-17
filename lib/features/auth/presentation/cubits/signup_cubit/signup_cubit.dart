// lib/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart
import 'dart:developer'; // ✅ إضافة
import 'package:bloc/bloc.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String gender,
    required int idRole,
    required int idCurrencies,
  }) async {
    emit(SignupLoading());

    log('📝 Registering user: $phoneNumber');

    final result = await authRepo.register(
      name: name,
      phoneNumber: phoneNumber,
      password: password,
      gender: gender,
      idRole: idRole,
      idCurrencies: idCurrencies,
    );

    result.fold(
      (failure) {
        log('❌ Registration failed: ${failure.message}');
        emit(SignupFailure(message: failure.message));
      },
      (data) {
        // ✅ Logging للتحقق من البيانات
        log('✅ Registration response data: $data');
        log('   - user: ${data['user']}');
        log('   - otp_required: ${data['otp_required']}');
        log('   - message: ${data['message']}');

        final user = data['user'] as UserEntity?;
        final otpRequired = data['otp_required'] as bool? ?? true; // ✅ افتراضياً true

        emit(SignupSuccess(
          user: user,
          message: data['message'] as String,
          otpRequired: otpRequired,
          phoneNumber: phoneNumber, // ✅ حفظ رقم الهاتف
        ));
      },
    );
  }
}