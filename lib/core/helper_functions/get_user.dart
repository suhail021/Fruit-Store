import 'dart:convert';

import 'package:myapp/constants.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/features/auth/data/model/user_model.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';

UserEntity getuser() {
  var jsonString = Prefs.getString(kUserData);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}
