import 'dart:convert';
import 'package:collection/collection.dart';

class User {
  String? name;
  String? phoneNumber;
  String? gender;
  int? idRole;
  int? idCurrencies;
  bool? otpVerified;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? idUser;

  User({
    this.name,
    this.phoneNumber,
    this.gender,
    this.idRole,
    this.idCurrencies,
    this.otpVerified,
    this.updatedAt,
    this.createdAt,
    this.idUser,
  });

  @override
  String toString() {
    return 'User(name: $name, phoneNumber: $phoneNumber, gender: $gender, idRole: $idRole, idCurrencies: $idCurrencies, otpVerified: $otpVerified, updatedAt: $updatedAt, createdAt: $createdAt, idUser: $idUser)';
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data['name'] as String?,
      phoneNumber: data['phone_number'] as String?,
      gender: data['gender'] as String?,
      idRole: data['id_role'] as int?,
      idCurrencies: data['id_currencies'] as int?,
      otpVerified: data['otp_verified'] as bool?,
      updatedAt: data['updated_at'] == null
          ? null
          : DateTime.parse(data['updated_at'] as String),
      createdAt: data['created_at'] == null
          ? null
          : DateTime.parse(data['created_at'] as String),
      idUser: data['id_user'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'gender': gender,
      'id_role': idRole,
      'id_currencies': idCurrencies,
      'otp_verified': otpVerified,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'id_user': idUser,
    };
  }

  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      idRole.hashCode ^
      idCurrencies.hashCode ^
      otpVerified.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      idUser.hashCode;
}