// lib/core/cubits/products_cubit/products_state.dart
part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductEntity> products;

  ProductsSuccess({required this.products});
}

final class ProductsFailure extends ProductsState {
  final String errMessage;

  ProductsFailure({required this.errMessage});
}
