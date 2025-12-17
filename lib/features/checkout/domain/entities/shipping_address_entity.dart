class ShippingAddressEntity {
  String? name;
  String? adrees;
  String? city;
  String? sate;
  String? mapAdrees;

  ShippingAddressEntity({
    this.name,
    this.adrees,
    this.city,
    this.sate,
    this.mapAdrees,
  });

  String toString() {
    return '$adrees $city $sate $mapAdrees';
  }
}
