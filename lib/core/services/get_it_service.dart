import 'package:get_it/get_it.dart';
import 'package:google/core/services/firebase_auth_service.dart';
import 'package:google/features/auth/data/repos/authr_repo_impl.dart';
import 'package:google/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
 getIt.registerSingleton<AuthRepo>(AuthrRepoImpl(
  firebaseAuthService: getIt<FirebaseAuthService>(),
 ));
 

}