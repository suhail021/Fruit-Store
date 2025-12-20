import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String name;
  final String street;
  final String city;
  final String phone;
  final double latitude;
  final double longitude;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.phone,
    required this.latitude,
    required this.longitude,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    street,
    city,
    phone,
    latitude,
    longitude,
    isDefault,
  ];
}
