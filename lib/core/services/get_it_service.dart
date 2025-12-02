// lib/core/di/dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/features/auth/data/repos/authr_repo_impl.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';
import 'package:myapp/features/auth/presentation/cubits/otp_verification/otp_verification_cubit.dart';
import 'package:myapp/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // External
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // Core Services
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(client: getIt<http.Client>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(apiService: getIt<ApiService>()),
  );

  // Cubits
  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(getIt<AuthRepo>()),
  );
  
  getIt.registerFactory<OtpVerificationCubit>(
    () => OtpVerificationCubit(getIt<AuthRepo>()),
  );
}