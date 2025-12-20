part of 'address_cubit.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
  final List<AddressEntity> addresses;
  AddressSuccess(this.addresses);
}

class AddressFailure extends AddressState {
  final String errMessage;
  AddressFailure(this.errMessage);
}
