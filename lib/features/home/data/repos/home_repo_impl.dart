import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/services/api_service.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/api_constants.dart';
import 'package:myapp/features/auth/data/model/user_model.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/home/data/models/coupon_model.dart';
import 'package:myapp/features/home/data/models/referral_stats_model.dart';
import 'package:myapp/features/home/domain/entities/coupon_entity.dart';
import 'package:myapp/features/home/domain/entities/referral_stats_entity.dart';
import 'package:myapp/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});

  Future<String?> _getToken() async {
    return Prefs.getString('auth_token');
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      var data = await apiService.postWithAuth(
        endpoint: ApiConstants.profile,
        data: {},
        token: token,
      );

      // Check for 'user' key directly based on provided JSON
      if (data['user'] != null) {
        return Right(UserModel.fromJson(data['user']));
      }

      // Fallback to 'data' if structure changes
      if (data['data'] != null) {
        if (data['data'] is Map<String, dynamic> &&
            data['data']['user'] != null) {
          return Right(UserModel.fromJson(data['data']['user']));
        }
        if (data['data'] is Map<String, dynamic> &&
            data['data']['name'] != null) {
          return Right(UserModel.fromJson(data['data']));
        }
      }

      return Left(ServerFailure('بيانات المستخدم غير متوفرة'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReferralStatsEntity>> getReferralStats() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      final response = await apiService.postWithAuth(
        endpoint: ApiConstants.referralsStats,
        data: {},
        token: token,
      );

      // Check for 'referral_data' key
      if (response['referral_data'] != null) {
        return Right(ReferralStatsModel.fromJson(response['referral_data']));
      }

      // Fallback
      if (response['data'] != null) {
        return Right(ReferralStatsModel.fromJson(response['data']));
      }

      return Left(ServerFailure('بيانات الإحالة غير متوفرة'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CouponEntity>>> getMyCoupons() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      final response = await apiService.postWithAuth(
        endpoint: ApiConstants.couponsMy,
        data: {},
        token: token,
      );

      // Based on JSON: "coupons": { "referral": [], "general": [] }
      if (response['coupons'] != null &&
          response['coupons']['referral'] != null) {
        final referralCoupons = response['coupons']['referral'];
        if (referralCoupons is List) {
          List<CouponEntity> coupons = [];
          for (var item in referralCoupons) {
            coupons.add(CouponModel.fromJson(item));
          }
          return Right(coupons);
        }
      }

      // Fallback for previous assumption
      if (response['data'] != null &&
          response['data']['referral_coupons'] != null) {
        List<CouponEntity> coupons = [];
        for (var item in response['data']['referral_coupons']) {
          coupons.add(CouponModel.fromJson(item));
        }
        return Right(coupons);
      }

      return const Right([]);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
