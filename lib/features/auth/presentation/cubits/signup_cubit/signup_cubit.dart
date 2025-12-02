// lib/features/auth/presentation/cubits/signup/signup_cubit.dart
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

    final result = await authRepo.register(
      name: name,
      phoneNumber: phoneNumber,
      password: password,
      gender: gender,
      idRole: idRole,
      idCurrencies: idCurrencies,
    );

    result.fold(
      (failure) => emit(SignupFailure(message: failure.message)),
      (data) {
        emit(SignupSuccess(
          user: data['user'] as UserEntity?,
          message: data['message'] as String,
          otpRequired: data['otp_required'] as bool,
        ));
      },
    );
  }
}