import 'package:myapp/features/home/domain/entities/referral_stats_entity.dart';

class ReferralStatsModel extends ReferralStatsEntity {
  ReferralStatsModel({
    required super.referralCode,
    required super.totalReferrals,
    required super.completedReferrals,
    required super.pendingReferrals,
    required super.totalRewards,
    required super.totalCoupons,
    required super.unusedCoupons,
    super.nextTier,
  });

  factory ReferralStatsModel.fromJson(Map<String, dynamic> json) {
    return ReferralStatsModel(
      referralCode:
          json['referral_code'] as String? ?? json['my_code'] as String? ?? '',
      totalReferrals: json['total_referrals'] as int? ?? 0,
      completedReferrals: json['completed_referrals'] as int? ?? 0,
      pendingReferrals: json['pending_referrals'] as int? ?? 0,
      totalRewards:
          double.tryParse(json['total_rewards']?.toString() ?? '0') ?? 0.0,
      totalCoupons: json['total_coupons'] as int? ?? 0,
      unusedCoupons: json['unused_coupons'] as int? ?? 0,
      nextTier:
          json['next_tier'] != null
              ? NextTierModel.fromJson(json['next_tier'])
              : null,
    );
  }
}

class NextTierModel extends NextTierEntity {
  NextTierModel({
    required super.threshold,
    required super.discountValue,
    required super.discountType,
    required super.remaining,
    required super.progressPercentage,
  });

  factory NextTierModel.fromJson(Map<String, dynamic> json) {
    return NextTierModel(
      threshold: json['threshold'] as int? ?? 0,
      discountValue:
          double.tryParse(json['discount_value']?.toString() ?? '0') ?? 0.0,
      discountType: json['discount_type'] as String? ?? 'percentage',
      remaining: json['remaining'] as int? ?? 0,
      progressPercentage:
          double.tryParse(json['progress_percentage']?.toString() ?? '0') ??
          0.0,
    );
  }
}
