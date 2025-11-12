import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  UserModel({
    required super.name,
    required super.email,
    required super.uId,
  });
  factory UserModel.fromfirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
    );
  }
}
