// lib/features/auth/data/models/user_model.dart
import 'dart:convert';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.idUser,
    required super.name,
    required super.phoneNumber,
    super.gender,
    super.idRole,
    super.idCurrencies,
    super.otpVerified,
    super.createdAt,
    super.updatedAt,
    super.loginAt,
    super.actv,
    super.balance,
    super.phoneVerifiedAt,
    super.palace,
    super.idLevel,
  });

  // ✅ From JSON - متوافق مع الاستجابة الجديدة
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id_user'] as int?,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      gender: json['gender'] as String?,
      idRole: json['id_role'] as int?,
      idCurrencies: json['id_currencies'] as int?,
      otpVerified: json['otp_verified'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      // الحقول الجديدة
      loginAt: json['login_at'] != null
          ? DateTime.parse(json['login_at'])
          : null,
      actv: json['actv'] as bool?,
      balance: json['balance'] as String?,
      phoneVerifiedAt: json['phone_verified_at'] != null
          ? DateTime.parse(json['phone_verified_at'])
          : null,
      palace: json['palace'] as String?,
      idLevel: json['id_level'] as int?,
    );
  }

  // ✅ To JSON
  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'name': name,
      'phone_number': phoneNumber,
      'gender': gender,
      'id_role': idRole,
      'id_currencies': idCurrencies,
      'otp_verified': otpVerified,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'login_at': loginAt?.toIso8601String(),
      'actv': actv,
      'balance': balance,
      'phone_verified_at': phoneVerifiedAt?.toIso8601String(),
      'palace': palace,
      'id_level': idLevel,
    };
  }

  // From Entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      idUser: entity.idUser,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      gender: entity.gender,
      idRole: entity.idRole,
      idCurrencies: entity.idCurrencies,
      otpVerified: entity.otpVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      loginAt: entity.loginAt,
      actv: entity.actv,
      balance: entity.balance,
      phoneVerifiedAt: entity.phoneVerifiedAt,
      palace: entity.palace,
      idLevel: entity.idLevel,
    );
  }

  // To Entity
  UserEntity toEntity() {
    return UserEntity(
      idUser: idUser,
      name: name,
      phoneNumber: phoneNumber,
      gender: gender,
      idRole: idRole,
      idCurrencies: idCurrencies,
      otpVerified: otpVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
      loginAt: loginAt,
      actv: actv,
      balance: balance,
      phoneVerifiedAt: phoneVerifiedAt,
      palace: palace,
      idLevel: idLevel,
    );
  }

  @override
  String toString() {
    return 'UserModel(idUser: $idUser, name: $name, phoneNumber: $phoneNumber, actv: $actv)';
  }
}