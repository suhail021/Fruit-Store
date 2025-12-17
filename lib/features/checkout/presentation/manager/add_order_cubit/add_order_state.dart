// lib/features/checkout/presentation/manager/add_order_cubit/add_order_state.dart
part of 'add_order_cubit.dart';

sealed class AddOrderState extends Equatable {
  const AddOrderState();

  @override
  List<Object?> get props => [];
}

final class AddOrderInitial extends AddOrderState {}

final class AddOrderLoading extends AddOrderState {}

final class AddOrderSuccess extends AddOrderState {
  final int? invoiceId;
  
  const AddOrderSuccess({this.invoiceId});

  @override
  List<Object?> get props => [invoiceId];
}

final class AddOrderFailure extends AddOrderState {
  final String message; // ✅ الاسم الصحيح
  
  const AddOrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class AddOrderCancelled extends AddOrderState {
  final String message;
  
  const AddOrderCancelled({required this.message});

  @override
  List<Object?> get props => [message];
}

final class AddOrderPaymentProofUploaded extends AddOrderState {
  final String message;
  
  const AddOrderPaymentProofUploaded({required this.message});

  @override
  List<Object?> get props => [message];
}