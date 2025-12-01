import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.ordersRepo) : super(AddOrderInitial());
  final OrdersRepo ordersRepo;

  void addOrder({required order}) async {
    emit(AddOrderLoading());
    final result = await ordersRepo.addOrder(order: order);
    result.fold(
      (failure) => emit(AddOrderFailure(failure.toString())),
      (_) => emit(AddOrderSuccess()),
    );
  }
}  
