import 'dart:convert';
import 'package:dartz/dartz.dart' hide id;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/features/address/data/models/address_model.dart';
import 'package:myapp/features/address/domain/entities/address_entity.dart';
import 'package:myapp/features/address/domain/repos/address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  final String kAddressesKey = 'user_addresses';

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async {
    try {
      final String? jsonString = Prefs.getString(kAddressesKey);
      if (jsonString != null) {
        final List<dynamic> decodedJson = jsonDecode(jsonString);
        final List<AddressEntity> addresses =
            decodedJson
                .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
                .toList();
        return Right(addresses);
      }
      return const Right([]);
    } catch (e) {
      return Left(
        ServerFailure('Failed to load addresses: $e'),
      ); // Using ServerFailure generically or create CacheFailure
    }
  }

  @override
  Future<Either<Failure, void>> addAddress(AddressEntity address) async {
    try {
      final result = await getAddresses();
      List<AddressEntity> currentAddresses = result.fold((l) => [], (r) => r);

      // If this is the first address, make it default
      bool isDefault = address.isDefault;
      if (currentAddresses.isEmpty) {
        isDefault = true;
      }

      // If adding a new default, unset previous default
      if (isDefault) {
        currentAddresses =
            currentAddresses.map((e) {
              if (e.isDefault) {
                return AddressModel.fromEntity(e).copyWith(isDefault: false);
              }
              return e;
            }).toList();
      }

      // Convert entity to model to ensure consistency
      final newAddressHelper = AddressModel.fromEntity(address);
      // We need copyWith on AddressModel to handle logic cleanly, implementing ad-hoc here
      final newAddress = AddressModel(
        id: newAddressHelper.id,
        name: newAddressHelper.name,
        street: newAddressHelper.street,
        city: newAddressHelper.city,
        phone: newAddressHelper.phone,
        latitude: newAddressHelper.latitude,
        longitude: newAddressHelper.longitude,
        isDefault: isDefault,
      );

      currentAddresses.add(newAddress);
      await _saveAddresses(currentAddresses);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to save address'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String addressId) async {
    try {
      final result = await getAddresses();
      final currentAddresses = result.fold((l) => <AddressEntity>[], (r) => r);

      currentAddresses.removeWhere((element) => element.id == addressId);
      await _saveAddresses(currentAddresses);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete address'));
    }
  }

  @override
  Future<Either<Failure, void>> setDefaultAddress(String addressId) async {
    try {
      final result = await getAddresses();
      final currentAddresses = result.fold((l) => <AddressEntity>[], (r) => r);

      final updatedAddresses =
          currentAddresses.map((e) {
            // Since we are using AddressEntity which is likely constant/immutable and doesn't have copyWith in the base definition I wrote,
            // (Wait, I didn't add copyWith to Entity or Model yet).
            // I should reconstruct it.
            if (e.id == addressId) {
              return AddressModel(
                id: e.id,
                name: e.name,
                street: e.street,
                city: e.city,
                phone: e.phone,
                latitude: e.latitude,
                longitude: e.longitude,
                isDefault: true,
              );
            } else if (e.isDefault) {
              return AddressModel(
                id: e.id,
                name: e.name,
                street: e.street,
                city: e.city,
                phone: e.phone,
                latitude: e.latitude,
                longitude: e.longitude,
                isDefault: false,
              );
            }
            return e;
          }).toList();

      await _saveAddresses(updatedAddresses);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to set default address'));
    }
  }

  @override
  Future<Either<Failure, void>> editAddress(AddressEntity address) async {
    try {
      final result = await getAddresses();
      final currentAddresses = result.fold((l) => <AddressEntity>[], (r) => r);

      final updatedAddresses =
          currentAddresses.map((e) {
            if (e.id == address.id) {
              return address;
            }
            return e;
          }).toList();

      await _saveAddresses(updatedAddresses);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to edit address'));
    }
  }

  Future<void> _saveAddresses(List<AddressEntity> addresses) async {
    final List<Map<String, dynamic>> jsonList =
        addresses.map((e) {
          return AddressModel.fromEntity(e).toJson();
        }).toList();
    await Prefs.setString(kAddressesKey, jsonEncode(jsonList));
  }
}

// Extension to help with immutability if needed, though mostly handled in logic
extension AddressModelCopyWith on AddressModel {
  AddressModel copyWith({bool? isDefault}) {
    return AddressModel(
      id: id,
      name: name,
      street: street,
      city: city,
      phone: phone,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
