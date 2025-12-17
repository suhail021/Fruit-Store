// lib/core/helper_functions/get_user.dart
import 'dart:convert';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/features/auth/data/model/user_model.dart';

// ✅ إنشاء كلاس بسيط للمستخدم (بدون تعارض)
class UserInfo {
  final int idUser;
  final String name;
  final String phoneNumber;
  
  UserInfo({
    required this.idUser,
    required this.name,
    required this.phoneNumber,
  });
  
  // ✅ للتوافق مع الكود القديم
  int get uId => idUser;
  String get uid => idUser.toString();
}

// ✅ دالة getuser المحدثة
UserInfo getuser() {
  final userData = Prefs.getString('user_data');
  
  if (userData != null && userData.isNotEmpty) {
    try {
      final userJson = jsonDecode(userData) as Map<String, dynamic>;
      
      // ✅ استخدام UserModel الصحيح للـ parsing
      final userModel = UserModel.fromJson(userJson);
      
      // ✅ إرجاع UserInfo بسيط
      return UserInfo(
        idUser: userModel.idUser ?? 0,
        name: userModel.name,
        phoneNumber: userModel.phoneNumber,
      );
    } catch (e) {
      return UserInfo(
        idUser: 0,
        name: 'مستخدم',
        phoneNumber: '',
      );
    }
  }
  
  return UserInfo(
    idUser: 0,
    name: 'مستخدم',
    phoneNumber: '',
  );
}

// ✅ دالة للحصول على UserModel الكامل (اختياري)
UserModel? getUserModel() {
  final userData = Prefs.getString('user_data');
  
  if (userData != null && userData.isNotEmpty) {
    try {
      final userJson = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(userJson);
    } catch (e) {
      return null;
    }
  }
  
  return null;
}