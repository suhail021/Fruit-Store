import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/auth/presentation/views/signin_view.dart';
import 'package:myapp/features/home/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:myapp/features/home/presentation/cubits/profile_cubit/profile_state.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'الملف الشخصي', showBackIcon: false),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProfileLoaded) {
            final user = state.user;
            final stats = state.referralStats;
            final coupons = state.coupons;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // User Info
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(user.name, style: TextStyles.bold19),
                  Text(
                    user.phoneNumber,
                    style: TextStyles.regular16.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  // Referral Stats Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "كود الإحالة الخاص بك",
                            style: TextStyles.bold16,
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            stats.referralCode,
                            style: TextStyles.bold23.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                "الإحالات",
                                stats.totalReferrals.toString(),
                              ),
                              _buildStatItem(
                                "المكافآت",
                                "${stats.totalRewards} ريال",
                              ),
                              _buildStatItem(
                                "الكوبونات",
                                stats.unusedCoupons.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Coupons Section
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الكوبونات الخاصة بك",
                      style: TextStyles.bold16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (coupons.isEmpty)
                    const Text(
                      "لا توجد كوبونات حالياً",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ...coupons.map(
                    (coupon) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(
                          Icons.local_offer,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(coupon.code, style: TextStyles.bold16),
                        subtitle: Text(coupon.name),
                        trailing: Text(
                          "${coupon.discountValue} ${coupon.discountType == 'percentage' ? '%' : 'ريال'}",
                          style: TextStyles.bold13.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Settings List
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'تسجيل الخروج',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () async {
                      await Prefs.remove('user_data');
                      await Prefs.remove('auth_token');
                      await Prefs.remove('addresses');
                      await Prefs.remove('favorites');
                      await Prefs.remove('referral_data');
                      await Prefs.remove('stats');
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SigninView.routeName,
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyles.bold16),
        Text(label, style: TextStyles.regular13.copyWith(color: Colors.grey)),
      ],
    );
  }
}
