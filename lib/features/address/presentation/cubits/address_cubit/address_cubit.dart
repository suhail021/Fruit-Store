import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/address/domain/entities/address_entity.dart';
import 'package:myapp/features/address/domain/repos/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepo addressRepo;

  AddressCubit(this.addressRepo) : super(AddressInitial());

  Future<void> getAddresses() async {
    emit(AddressLoading());
    final result = await addressRepo.getAddresses();
    result.fold(
      (failure) => emit(AddressFailure(failure.message)),
      (addresses) => emit(AddressSuccess(addresses)),
    );
  }

  Future<void> addAddress(AddressEntity address) async {
    emit(AddressLoading());
    final result = await addressRepo.addAddress(address);
    result.fold(
      (failure) => emit(AddressFailure(failure.message)),
      (success) => getAddresses(),
    );
  }

  Future<void> deleteAddress(String addressId) async {
    emit(AddressLoading());
    final result = await addressRepo.deleteAddress(addressId);
    result.fold(
      (failure) => emit(AddressFailure(failure.message)),
      (success) => getAddresses(),
    );
  }

  Future<void> setDefaultAddress(String addressId) async {
    emit(AddressLoading());
    final result = await addressRepo.setDefaultAddress(addressId);
    result.fold(
      (failure) => emit(AddressFailure(failure.message)),
      (success) => getAddresses(),
    );
  }

  Future<void> editAddress(AddressEntity address) async {
    emit(AddressLoading());
    final result = await addressRepo.editAddress(address);
    result.fold(
      (failure) => emit(AddressFailure(failure.message)),
      (success) => getAddresses(),
    );
  }
}
