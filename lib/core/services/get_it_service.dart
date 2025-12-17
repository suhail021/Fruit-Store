// lib/core/services/get_it_service.dart
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/core/cubits/products_cubit/products_cubit.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo_impl.dart';
import 'package:myapp/core/repos/products_repo/products_repo.dart';
import 'package:myapp/core/repos/products_repo/products_repo_impl.dart';
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/features/auth/data/repos/authr_repo_impl.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';
import 'package:myapp/features/auth/presentation/cubits/otp_verification/otp_verification_cubit.dart';
import 'package:myapp/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:myapp/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:myapp/features/checkout/presentation/manager/add_order_cubit/add_order_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // ==========================================
  // External Dependencies
  // ==========================================
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // ==========================================
  // Core Services
  // ==========================================
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(client: getIt<http.Client>()),
  );

  // ==========================================
  // Repositories
  // ==========================================
  
  // Auth Repository
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(apiService: getIt<ApiService>()),
  );

  // Products Repository
  getIt.registerLazySingleton<ProductsRepo>(
    () => ProductsRepoImpl(apiService: getIt<ApiService>()),
  );

  // Orders Repository
  getIt.registerLazySingleton<OrdersRepo>(
    () => OrdersRepoImpl(apiService: getIt<ApiService>()),
  );

  // ==========================================
  // Cubits - Factory (يتم إنشاء instance جديد في كل مرة)
  // ==========================================
  
  // Auth Cubits
  getIt.registerFactory<SigninCubit>(
    () => SigninCubit(getIt<AuthRepo>()),
  );

  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(getIt<AuthRepo>()),
  );

  getIt.registerFactory<OtpVerificationCubit>(
    () => OtpVerificationCubit(getIt<AuthRepo>()),
  );

  // Products Cubit
  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(getIt<ProductsRepo>()),
  );

  // Checkout Cubit
  getIt.registerFactory<AddOrderCubit>(
    () => AddOrderCubit(getIt<OrdersRepo>()),
  );
}
