import 'package:get_it/get_it.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo_impl.dart';
import 'package:myapp/core/repos/products_repo/products_repo.dart';
import 'package:myapp/core/repos/products_repo/products_repo_impl.dart';
import 'package:myapp/core/services/database_service.dart';
import 'package:myapp/core/services/firebase_auth_service.dart';
import 'package:myapp/core/services/firestore_service.dart';
import 'package:myapp/features/auth/data/repos/authr_repo_impl.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthrRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImpl(getIt<DatabaseService>()),
  );
  getIt.registerSingleton<OrdersRepo>(
    OrdersRepoImpl(getIt<DatabaseService>()),
  );
}
