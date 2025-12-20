import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/features/address/domain/entities/address_entity.dart';

abstract class AddressRepo {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, void>> addAddress(AddressEntity address);
  Future<Either<Failure, void>> deleteAddress(String addressId);
  Future<Either<Failure, void>> editAddress(
    AddressEntity address,
  ); // New method
  Future<Either<Failure, void>> setDefaultAddress(String addressId);
}
