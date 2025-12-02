// import 'package:dartz/dartz.dart';
// import 'package:myapp/core/errors/failures.dart';
// import 'package:myapp/core/repos/orders_repo/orders_repo.dart';
// import 'package:myapp/core/services/database_service.dart';
// import 'package:myapp/core/utils/backend_endpoint.dart';
// import 'package:myapp/features/checkout/data/models/order_model.dart';
// import 'package:myapp/features/checkout/domain/entities/order_entity.dart';

// class OrdersRepoImpl implements OrdersRepo {
//   final DatabaseService firestoreService;

//   OrdersRepoImpl(this.firestoreService);
//   @override
//   Future<Either<Failure, void>> addOrder({required OrderEntity order}) async {
//     try {
//       await firestoreService.addData(
//         path: BackendEndpoint.addorders,
//         data: OrderModel.fromEntity(order).toJson(),
//         docuementId: order.uID,
//       );
//       return Right(null);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }
