// lib/features/auth/domain/entities/user_entity.dart
class UserEntity {
  final int? idUser;
  final String name;
  final String phoneNumber;
  final String? gender;
  final double? balance;
  final bool? otpVerified;
  final bool? actv;
  final String? referralCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  // Relations
  final RoleEntity? role;
  final CurrencyEntity? currency;
  final LevelEntity? level;

  UserEntity({
    this.idUser,
    required this.name,
    required this.phoneNumber,
    this.gender,
    this.balance,
    this.otpVerified,
    this.actv,
    this.referralCode,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.currency,
    this.level,
  });
}

// Role Entity
class RoleEntity {
  final int idRole;
  final String name;

  RoleEntity({required this.idRole, required this.name});
}

// Currency Entity
class CurrencyEntity {
  final int idCurrencies;
  final String name;
  final String? symbol;

  CurrencyEntity({
    required this.idCurrencies,
    required this.name,
    this.symbol,
  });
}

// Level Entity
class LevelEntity {
  final int idLevel;
  final String name;
  final String minValue;
  final String maxValue;
  final String? icon;
  final String? badgeColor;

  LevelEntity({
    required this.idLevel,
    required this.name,
    required this.minValue,
    required this.maxValue,
    this.icon,
    this.badgeColor,
  });
}