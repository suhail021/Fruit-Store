// lib/features/home/presentation/cubits/cart_cubit/cart_state.dart
part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartItemAdded extends CartState {}

final class CartItemRemoved extends CartState {}

final class CartItemQuantityIncreased extends CartState {}

final class CartItemQuantityUpdated extends CartState {}

final class CartCleared extends CartState {}

final class CartItemNotAvailable extends CartState {}
