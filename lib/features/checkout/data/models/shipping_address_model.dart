
import 'package:myapp/features/checkout/domain/entities/shipping_address_entity.dart';

class ShippingAddressModel {
  String? name;
  String? phone;
  String? address;
  String? city;
  String? email;
  String? floor;

  ShippingAddressModel({
    this.name,
    this.phone,
    this.address,
    this.floor,
    this.city,
    this.email,
  });
  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
      name: entity.name,
      phone: entity.sate,
      address: entity.adrees,
      floor: entity.mapAdrees,
      city: entity.city,
    );
  }
  @override
  String toString() {
    return '$address $floor $city';
  }

  toJson() {
    return {
      'name': name,
      'sate': phone,
      'address': address,
      'floor': floor,
      'city': city,
    };
  }
}
