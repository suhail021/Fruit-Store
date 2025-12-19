import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/home/domain/entities/coupon_entity.dart';
import 'package:myapp/features/home/domain/entities/referral_stats_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, UserEntity>> getUserProfile();
  Future<Either<Failure, ReferralStatsEntity>> getReferralStats();
  Future<Either<Failure, List<CouponEntity>>> getMyCoupons();
}
