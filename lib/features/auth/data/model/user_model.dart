// lib/features/auth/data/models/user_model.dart
import 'package:myapp/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.idUser,
    required super.name,
    required super.phoneNumber,
    super.gender,
    super.balance,
    super.otpVerified,
    super.actv,
    super.referralCode,
    super.createdAt,
    super.updatedAt,
    super.role,
    super.currency,
    super.level,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id_user'] as int?,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      gender: json['gender'] as String?,
      balance: _parseDouble(json['balance']),
      otpVerified: json['otp_verified'] as bool?,
      actv: json['actv'] as bool?,
      referralCode: json['referral_code'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      currency:
          json['currency'] != null
              ? CurrencyModel.fromJson(json['currency'])
              : null,
      level: json['level'] != null ? LevelModel.fromJson(json['level']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'name': name,
      'phone_number': phoneNumber,
      'gender': gender,
      'balance': balance,
      'otp_verified': otpVerified,
      'actv': actv,
      'referral_code': referralCode,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'role': role != null ? (role as RoleModel).toJson() : null,
      'currency':
          currency != null ? (currency as CurrencyModel).toJson() : null,
      'level': level != null ? (level as LevelModel).toJson() : null,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      idUser: entity.idUser,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      gender: entity.gender,
      balance: entity.balance,
      otpVerified: entity.otpVerified,
      actv: entity.actv,
      referralCode: entity.referralCode,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      role: entity.role,
      currency: entity.currency,
      level: entity.level,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      idUser: idUser,
      name: name,
      phoneNumber: phoneNumber,
      gender: gender,
      balance: balance,
      otpVerified: otpVerified,
      actv: actv,
      referralCode: referralCode,
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: role,
      currency: currency,
      level: level,
    );
  }

  // ✅ دالة مساعدة لتحويل القيم
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

// ==========================================
// Role Model
// ==========================================
class RoleModel extends RoleEntity {
  RoleModel({required super.idRole, required super.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      idRole: json['id_role'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id_role': idRole, 'name': name};
  }
}

// ==========================================
// Currency Model
// ==========================================
class CurrencyModel extends CurrencyEntity {
  CurrencyModel({
    required super.idCurrencies,
    required super.name,
    super.symbol,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      idCurrencies: json['id_currencies'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id_currencies': idCurrencies, 'name': name, 'symbol': symbol};
  }
}

// ==========================================
// Level Model
// ==========================================
class LevelModel extends LevelEntity {
  LevelModel({
    required super.idLevel,
    required super.name,
    required super.minValue,
    required super.maxValue,
    super.icon,
    super.badgeColor,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      idLevel: json['id_level'] as int,
      name: json['name'] as String,
      minValue: json['min_value'].toString(),
      maxValue: json['max_value'].toString(),
      icon: json['icon'] as String?,
      badgeColor: json['badge_color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_level': idLevel,
      'name': name,
      'min_value': minValue,
      'max_value': maxValue,
      'icon': icon,
      'badge_color': badgeColor,
    };
  }
}
