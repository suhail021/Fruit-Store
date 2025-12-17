// lib/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());

  final AuthRepo authRepo;

  Future<void> login(String phoneNumber, String password) async {
    emit(SigninLoading());

    final result = await authRepo.login(
      phoneNumber: phoneNumber,
      password: password,
    );

    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (user) => emit(SigninSuccess(userEntity: user)),
    );
  }
}