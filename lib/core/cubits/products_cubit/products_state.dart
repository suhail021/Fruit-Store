part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsFailure extends ProductsState {
  final String errMessage;
  const ProductsFailure({required this.errMessage});
}

final class ProductsSussecc extends ProductsState {
  final List<ProductEntity> products;

  ProductsSussecc(this.products);
}
