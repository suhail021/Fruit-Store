// lib/core/cubits/orders_cubit/orders_state.dart
part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

// ==========================================
// Initial & Loading States
// ==========================================

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class CartLoading extends OrdersState {}

// ==========================================
// Orders States
// ==========================================

class OrdersLoaded extends OrdersState {
  final List<InvoiceEntity> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

// ==========================================
// Cart States
// ==========================================

class CartEmpty extends OrdersState {}

class CartLoaded extends OrdersState {
  final InvoiceEntity cart;

  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartItemAdded extends OrdersState {
  final InvoiceEntity cart;

  const CartItemAdded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends OrdersState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

// ==========================================
// Action States
// ==========================================

class AddressSelected extends OrdersState {
  final InvoiceEntity cart;

  const AddressSelected(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CouponApplied extends OrdersState {
  final InvoiceEntity cart;
  final double discount;

  const CouponApplied(this.cart, this.discount);

  @override
  List<Object?> get props => [cart, discount];
}
