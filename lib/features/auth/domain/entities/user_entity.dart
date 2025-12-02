// lib/features/auth/domain/entities/user_entity.dart
class UserEntity {
  final int? idUser;
  final String name;
  final String phoneNumber;
  final String? gender;
  final int? idRole;
  final int? idCurrencies;
  final bool? otpVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  // ✅ الحقول الجديدة
  final DateTime? loginAt;
  final bool? actv;
  final String? balance;
  final DateTime? phoneVerifiedAt;
  final String? palace;
  final int? idLevel;

  UserEntity({
    this.idUser,
    required this.name,
    required this.phoneNumber,
    this.gender,
    this.idRole,
    this.idCurrencies,
    this.otpVerified,
    this.createdAt,
    this.updatedAt,
    this.loginAt,
    this.actv,
    this.balance,
    this.phoneVerifiedAt,
    this.palace,
    this.idLevel,
  });
}