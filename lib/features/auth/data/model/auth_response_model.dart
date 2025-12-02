// lib/features/auth/data/models/auth_response_model.dart
import 'package:myapp/features/auth/data/model/user_model..dart';

class AuthResponseModel {
  final bool success;
  final String message;
  final UserModel? user;
  final bool? otpRequired;
  final String? token;

  AuthResponseModel({
    required this.success,
    required this.message,
    this.user,
    this.otpRequired,
    this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: json['user'] != null 
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      otpRequired: json['otp_required'] as bool?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user?.toJson(),
      'otp_required': otpRequired,
      'token': token,
    };
  }
}