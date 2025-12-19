import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/home/domain/entities/coupon_entity.dart';
import 'package:myapp/features/home/domain/entities/referral_stats_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final ReferralStatsEntity referralStats;
  final List<CouponEntity> coupons;

  ProfileLoaded({
    required this.user,
    required this.referralStats,
    required this.coupons,
  });
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}
