import 'package:myapp/features/address/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.name,
    required super.street,
    required super.city,
    required super.phone,
    required super.latitude,
    required super.longitude,
    super.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      name: json['name'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'street': street,
      'city': city,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'is_default': isDefault,
    };
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      name: entity.name,
      street: entity.street,
      city: entity.city,
      phone: entity.phone,
      latitude: entity.latitude,
      longitude: entity.longitude,
      isDefault: entity.isDefault,
    );
  }
}
