import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/domain/entities/user_entity.dart';
import 'package:myapp/features/home/domain/entities/coupon_entity.dart';
import 'package:myapp/features/home/domain/entities/referral_stats_entity.dart';
import 'package:myapp/features/home/domain/repos/home_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final HomeRepo homeRepo;

  ProfileCubit(this.homeRepo) : super(ProfileInitial());

  Future<void> fetchProfileData() async {
    emit(ProfileLoading());

    try {
      // 1. Fetch User Profile
      final userResult = await homeRepo.getUserProfile();
      UserEntity? user;
      String? errorMessage;

      userResult.fold(
        (failure) => errorMessage = failure.message,
        (data) => user = data,
      );

      if (errorMessage != null) {
        emit(ProfileFailure(errorMessage!));
        return;
      }

      // 2. Fetch Referral Stats
      final referralResult = await homeRepo.getReferralStats();
      ReferralStatsEntity? referralStats;

      referralResult.fold((failure) {
        // Log failure but allow partial success?
        // For now, fail whole if critical parts miss.
        errorMessage = failure.message;
      }, (data) => referralStats = data);

      if (errorMessage != null) {
        emit(ProfileFailure(errorMessage!));
        return;
      }

      // 3. Fetch Coupons
      final couponsResult = await homeRepo.getMyCoupons();
      List<CouponEntity> coupons = [];

      couponsResult.fold(
        (failure) => errorMessage = failure.message,
        (data) => coupons = data,
      );

      if (errorMessage != null) {
        emit(ProfileFailure(errorMessage!));
        return;
      }

      emit(
        ProfileLoaded(
          user: user!,
          referralStats: referralStats!,
          coupons: coupons,
        ),
      );
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
