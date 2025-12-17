// lib/core/repos/orders_repo/orders_repo.dart
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';

abstract class OrdersRepo {
  /// إنشاء طلب جديد (فاتورة)
  Future<Either<Failure, Map<String, dynamic>>> addOrder({
    required order,
  });

  /// إنشاء طلب من بيانات محددة
  Future<Either<Failure, Map<String, dynamic>>> createOrder({
    required List<Map<String, dynamic>> items,
    required int idAddress,
    String? notes,
    int? idCoupon,
    double? balanceUsed,
  });

  /// الحصول على جميع الطلبات للمستخدم
  Future<Either<Failure, Map<String, dynamic>>> getMyOrders();

  /// الحصول على طلب محدد
  Future<Either<Failure, Map<String, dynamic>>> getOrder(int id);

  /// إلغاء طلب
  Future<Either<Failure, String>> cancelOrder({
    required int id,
    required String reason,
  });

  /// رفع إثبات الدفع
  Future<Either<Failure, String>> uploadPaymentProof({
    required int invoiceId,
    required String imagePath,
  });
}
