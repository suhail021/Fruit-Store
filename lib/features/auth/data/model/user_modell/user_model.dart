// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:myapp/features/auth/domain/entities/user_entity.dart';

// class UserModelfire extends UserEntityfire {
//   UserModelfire({required super.name, required super.email, required super.uId});
//   factory UserModelfire.fromfirebaseUser(User user) {
//     return UserModelfire(
//       name: user.displayName ?? '',
//       email: user.email ?? '',
//       uId: user.uid,
//     );
//   }

//   factory UserModelfire.fromJson(Map<String, dynamic> json) {
//     return UserModelfire(
//       name: json['name'],
//       email: json['email'],
//       uId: json['uId'],
//     );
//   }
//   factory UserModelfire.fromEntity(UserEntityfire user) {
//     return UserModelfire(name: user.name, email: user.email, uId: user.uId);
//   }

//   toMap() {
//     return {'name': name, 'email': email, 'uId': uId};
//   }
// }
