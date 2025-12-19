class ReferralStatsEntity {
  final String referralCode;
  final int totalReferrals;
  final int completedReferrals;
  final int pendingReferrals;
  final double totalRewards;
  final int totalCoupons;
  final int unusedCoupons;
  final NextTierEntity? nextTier;

  ReferralStatsEntity({
    required this.referralCode,
    required this.totalReferrals,
    required this.completedReferrals,
    required this.pendingReferrals,
    required this.totalRewards,
    required this.totalCoupons,
    required this.unusedCoupons,
    this.nextTier,
  });
}

class NextTierEntity {
  final int threshold;
  final double discountValue;
  final String discountType;
  final int remaining;
  final double progressPercentage;

  NextTierEntity({
    required this.threshold,
    required this.discountValue,
    required this.discountType,
    required this.remaining,
    required this.progressPercentage,
  });
}
