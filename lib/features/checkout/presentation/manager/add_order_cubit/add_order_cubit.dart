// lib/features/checkout/presentation/manager/add_order_cubit/add_order_cubit.dart
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.ordersRepo) : super(AddOrderInitial());
  
  final OrdersRepo ordersRepo;

  /// إنشاء طلب (الطريقة الأصلية - تدعم order object)
  Future<void> addOrder({required order}) async {
    emit(AddOrderLoading());
    
    log('🛒 Adding order...');

    final result = await ordersRepo.addOrder(order: order);
    
    result.fold(
      (failure) {
        log('❌ Order creation failed: ${failure.message}');
        emit(AddOrderFailure(failure.message));
      },
      (response) {
        final invoiceId = response['invoice']?['id_invoices'] as int?;
        log('✅ Order created successfully! Invoice ID: $invoiceId');
        emit(AddOrderSuccess(invoiceId: invoiceId));
      },
    );
  }

  /// إنشاء طلب من بيانات محددة
  Future<void> createOrder({
    required List<Map<String, dynamic>> items,
    required int idAddress,
    String? notes,
    int? idCoupon,
    double? balanceUsed,
  }) async {
    emit(AddOrderLoading());

    log('🛒 Creating order with ${items.length} items');

    final result = await ordersRepo.createOrder(
      items: items,
      idAddress: idAddress,
      notes: notes,
      idCoupon: idCoupon,
      balanceUsed: balanceUsed,
    );

    result.fold(
      (failure) {
        log('❌ Order creation failed: ${failure.message}');
        emit(AddOrderFailure(failure.message));
      },
      (response) {
        final invoiceId = response['invoice']?['id_invoices'] as int?;
        log('✅ Order created successfully! Invoice ID: $invoiceId');
        emit(AddOrderSuccess(invoiceId: invoiceId));
      },
    );
  }

  /// إلغاء طلب
  Future<void> cancelOrder({
    required int orderId,
    required String reason,
  }) async {
    emit(AddOrderLoading());

    log('🚫 Cancelling order #$orderId');

    final result = await ordersRepo.cancelOrder(
      id: orderId,
      reason: reason,
    );

    result.fold(
      (failure) {
        log('❌ Order cancellation failed: ${failure.message}');
        emit(AddOrderFailure(failure.message));
      },
      (message) {
        log('✅ Order cancelled successfully');
        emit(AddOrderCancelled(message: message));
      },
    );
  }

  /// رفع إثبات الدفع
  Future<void> uploadPaymentProof({
    required int invoiceId,
    required String imagePath,
  }) async {
    emit(AddOrderLoading());

    log('📤 Uploading payment proof for invoice #$invoiceId');

    final result = await ordersRepo.uploadPaymentProof(
      invoiceId: invoiceId,
      imagePath: imagePath,
    );

    result.fold(
      (failure) {
        log('❌ Payment proof upload failed: ${failure.message}');
        emit(AddOrderFailure(failure.message));
      },
      (message) {
        log('✅ Payment proof uploaded successfully');
        emit(AddOrderPaymentProofUploaded(message: message));
      },
    );
  }

  /// إعادة تعيين الحالة
  void reset() {
    emit(AddOrderInitial());
  }
}
