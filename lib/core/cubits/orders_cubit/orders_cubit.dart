// lib/core/cubits/orders_cubit/orders_cubit.dart
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/core/entities/invoice_entity.dart';
import 'package:myapp/core/models/invoice_model.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.ordersRepo) : super(OrdersInitial());

  final OrdersRepo ordersRepo;

  List<InvoiceEntity> _allOrders = [];
  InvoiceEntity? _currentCart;

  List<InvoiceEntity> get allOrders => _allOrders;
  InvoiceEntity? get currentCart => _currentCart;

  /// جلب جميع الطلبات من API
  Future<void> fetchOrders() async {
    emit(OrdersLoading());

    log('📋 Fetching all orders...');

    final result = await ordersRepo.getMyOrders();

    result.fold(
      (failure) {
        log('❌ Failed to fetch orders: ${failure.message}');
        emit(OrdersError(failure.message));
      },
      (response) {
        try {
          final invoicesData = response['invoices'] as List;
          _allOrders =
              invoicesData
                  .map((json) => InvoiceModel.fromJson(json) as InvoiceEntity)
                  .toList();

          log('✅ Loaded ${_allOrders.length} orders');
          emit(OrdersLoaded(_allOrders));
        } catch (e) {
          log('❌ Error parsing orders: $e');
          emit(OrdersError('حدث خطأ أثناء تحميل الطلبات'));
        }
      },
    );
  }

  /// جلب السلة الحالية
  Future<void> getCart() async {
    emit(CartLoading());

    log('🛒 Getting current cart...');

    final result = await ordersRepo.getCart();

    result.fold(
      (failure) {
        log('❌ Failed to get cart: ${failure.message}');
        emit(CartError(failure.message));
      },
      (response) {
        try {
          if (response['invoice'] == null) {
            _currentCart = null;
            log('✅ Cart is empty');
            emit(CartEmpty());
          } else {
            _currentCart =
                InvoiceModel.fromJson(response['invoice']) as InvoiceEntity;
            log('✅ Cart loaded with ${_currentCart!.itemsCount ?? 0} items');
            emit(CartLoaded(_currentCart!));
          }
        } catch (e) {
          log('❌ Error parsing cart: $e');
          emit(CartError('حدث خطأ أثناء تحميل السلة'));
        }
      },
    );
  }

  /// إضافة منتج Shein للسلة
  Future<void> addToCart({
    required int quantity,
    required String sheinProductId,
    required String productName,
    required double productPrice,
    required String productImg,
    required String description,
    required String linkProducts,
  }) async {
    emit(CartLoading());

    log('➕ Adding Shein product to cart: $productName');

    final result = await ordersRepo.addToCart(
      quantity: quantity,
      sheinProductId: sheinProductId,
      productName: productName,
      productPrice: productPrice,
      productImg: productImg,
      description: description,
      linkProducts: linkProducts,
    );

    result.fold(
      (failure) {
        log('❌ Failed to add to cart: ${failure.message}');
        emit(CartError(failure.message));
      },
      (response) {
        try {
          _currentCart =
              InvoiceModel.fromJson(response['invoice']) as InvoiceEntity;
          log('✅ Product added to cart successfully');
          emit(CartItemAdded(_currentCart!));
        } catch (e) {
          log('❌ Error parsing cart response: $e');
          emit(CartError('حدث خطأ أثناء إضافة المنتج'));
        }
      },
    );
  }

  /// حذف عنصر من السلة
  Future<void> removeFromCart(int itemId) async {
    emit(CartLoading());

    log('🗑️ Removing item $itemId from cart');

    final result = await ordersRepo.removeFromCart(itemId: itemId);

    result.fold(
      (failure) {
        log('❌ Failed to remove from cart: ${failure.message}');
        emit(CartError(failure.message));
      },
      (response) {
        try {
          if (response['invoice'] == null) {
            _currentCart = null;
            log('✅ Item removed, cart is now empty');
            emit(CartEmpty());
          } else {
            _currentCart =
                InvoiceModel.fromJson(response['invoice']) as InvoiceEntity;
            log('✅ Item removed from cart');
            emit(CartLoaded(_currentCart!));
          }
        } catch (e) {
          log('❌ Error parsing cart response: $e');
          emit(CartError('حدث خطأ أثناء حذف العنصر'));
        }
      },
    );
  }

  /// اختيار عنوان التوصيل
  Future<void> selectAddress(int invoiceId, int addressId) async {
    emit(CartLoading());

    log('📍 Selecting address for invoice $invoiceId');

    final result = await ordersRepo.selectAddress(
      invoiceId: invoiceId,
      addressId: addressId,
    );

    result.fold(
      (failure) {
        log('❌ Failed to select address: ${failure.message}');
        emit(CartError(failure.message));
      },
      (response) {
        try {
          _currentCart =
              InvoiceModel.fromJson(response['invoice']) as InvoiceEntity;
          log('✅ Address selected successfully');
          emit(AddressSelected(_currentCart!));
        } catch (e) {
          log('❌ Error parsing response: $e');
          emit(CartError('حدث خطأ أثناء اختيار العنوان'));
        }
      },
    );
  }

  /// تطبيق كوبون
  Future<void> applyCoupon(int invoiceId, String couponCode) async {
    emit(CartLoading());

    log('🎟️ Applying coupon: $couponCode');

    final result = await ordersRepo.applyCoupon(
      invoiceId: invoiceId,
      couponCode: couponCode,
    );

    result.fold(
      (failure) {
        log('❌ Failed to apply coupon: ${failure.message}');
        emit(CartError(failure.message));
      },
      (response) {
        try {
          _currentCart =
              InvoiceModel.fromJson(response['invoice']) as InvoiceEntity;
          final discount = response['discount'] as double;
          log('✅ Coupon applied! Discount: $discount');
          emit(CouponApplied(_currentCart!, discount));
        } catch (e) {
          log('❌ Error parsing response: $e');
          emit(CartError('حدث خطأ أثناء تطبيق الكوبون'));
        }
      },
    );
  }

  /// إعادة تعيين الحالة
  void reset() {
    emit(OrdersInitial());
  }
}
