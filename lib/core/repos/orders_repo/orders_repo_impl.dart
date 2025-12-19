// lib/core/repos/orders_repo/orders_repo_impl.dart
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/core/errors/custom_exceptions.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/api_constants.dart';

class OrdersRepoImpl implements OrdersRepo {
  final ApiService apiService;

  OrdersRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, Map<String, dynamic>>> addOrder({
    required order,
  }) async {
    // استخراج البيانات من order object
    try {
      final items = <Map<String, dynamic>>[];

      // تحويل cart items إلى format الـ API
      if (order.cartEntity != null && order.cartEntity.cartItems != null) {
        for (var item in order.cartEntity.cartItems) {
          items.add({
            'id_products': item.productEntity.id,
            'quantity': item.quantity,
            'price': item.productEntity.finalPrice,
          });
        }
      }

      final idAddress = order.shippingAddressEntity?.id ?? 0;

      return await createOrder(
        items: items,
        idAddress: idAddress,
        notes: order.notes,
      );
    } catch (e) {
      log('❌ Exception in addOrder: $e');
      return Left(ServerFailure('حدث خطأ في معالجة الطلب'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createOrder({
    required List<Map<String, dynamic>> items,
    required int idAddress,
    String? notes,
    int? idCoupon,
    double? balanceUsed,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      final requestData = {
        'items': items,
        'id_address': idAddress,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
        if (idCoupon != null) 'id_coupon': idCoupon,
        if (balanceUsed != null) 'balance_used': balanceUsed,
      };

      log('📦 Creating order with ${items.length} items');
      log('📦 Request data: $requestData');

      final response = await apiService.post(
        endpoint: ApiConstants.invoicesCreate,
        data: requestData,
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Order created successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in createOrder: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in createOrder: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getMyOrders() async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('📋 Getting my orders');

      final response = await apiService.get(
        endpoint: ApiConstants.invoices,
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Orders retrieved successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in getMyOrders: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in getMyOrders: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getOrder(int id) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('📦 Getting order #$id');

      final response = await apiService.get(
        endpoint: '${ApiConstants.invoicesShow}/$id',
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Order retrieved successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in getOrder: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in getOrder: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, String>> cancelOrder({
    required int id,
    required String reason,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('🚫 Cancelling order #$id');

      final response = await apiService.post(
        endpoint: '${ApiConstants.invoicesCancel}/$id/cancel',
        data: {'cancellation_reason': reason},
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Order cancelled successfully');
      return Right(response['message'] as String);
    } on ServerException catch (e) {
      log('❌ ServerException in cancelOrder: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in cancelOrder: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadPaymentProof({
    required int invoiceId,
    required String imagePath,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('📤 Uploading payment proof for invoice #$invoiceId');

      // استخدام multipart لرفع الصورة
      final url = Uri.parse(
        '${ApiConstants.baseUrl}/invoices/$invoiceId/payment-proof',
      );

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(ApiConstants.headersWithToken(token));

      // إضافة الصورة
      request.files.add(
        await http.MultipartFile.fromPath('payment_proof', imagePath),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log('✅ Payment proof uploaded successfully');
        return Right('تم رفع إثبات الدفع بنجاح');
      } else {
        throw ServerException(message: 'فشل رفع إثبات الدفع');
      }
    } on ServerException catch (e) {
      log('❌ ServerException in uploadPaymentProof: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in uploadPaymentProof: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  // ==========================================
  // Cart Operations
  // ==========================================

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCart() async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('🛒 Getting current cart');

      final response = await apiService.get(
        endpoint: ApiConstants.invoicesGetCart,
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Cart retrieved successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in getCart: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in getCart: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addToCart({
    required int quantity,
    required String sheinProductId,
    required String productName,
    required double productPrice,
    required String productImg,
    required String description,
    required String linkProducts,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('➡️ Adding Shein product to cart: $productName');

      final requestData = {
        'quantity': quantity,
        'shein_product_id': sheinProductId,
        'product_name': productName,
        'product_price': productPrice,
        'product_img': productImg,
        'description': description,
        'link_products': linkProducts,
      };

      final response = await apiService.post(
        endpoint: ApiConstants.invoicesAddToCart,
        data: requestData,
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Product added to cart successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in addToCart: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in addToCart: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> removeFromCart({
    required int itemId,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('🗑️ Removing item from cart: $itemId');

      final response = await apiService.post(
        endpoint: '${ApiConstants.invoicesRemoveFromCart}/$itemId',
        data: {}, // Empty data for delete operation
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Item removed from cart successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in removeFromCart: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in removeFromCart: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> selectAddress({
    required int invoiceId,
    required int addressId,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('📍 Selecting address for invoice $invoiceId');

      final requestData = {'id_address': addressId};

      final response = await apiService.post(
        endpoint:
            '${ApiConstants.invoicesSelectAddress}/$invoiceId/select-address',
        data: requestData,
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Address selected successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in selectAddress: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in selectAddress: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> applyCoupon({
    required int invoiceId,
    required String couponCode,
  }) async {
    try {
      final token = await Prefs.getString('auth_token');

      if (token == null) {
        return Left(ServerFailure('يرجى تسجيل الدخول أولاً'));
      }

      log('🎫 Applying coupon: $couponCode');

      final requestData = {'coupon_code': couponCode};

      final response = await apiService.post(
        endpoint: '${ApiConstants.invoicesApplyCoupon}/$invoiceId/apply-coupon',
        data: requestData,
        headers: ApiConstants.headersWithToken(token),
      );

      log('✅ Coupon applied successfully');
      return Right(response);
    } on ServerException catch (e) {
      log('❌ ServerException in applyCoupon: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('❌ Exception in applyCoupon: $e');
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }
}
