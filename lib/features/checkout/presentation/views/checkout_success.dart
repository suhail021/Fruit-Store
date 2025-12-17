import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:svg_flutter/svg.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({super.key});
  static const routeName = 'checkout-success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تم الطلب بنجاح',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Column(
          children: [
            SizedBox(height: 76),
            Center(child: SvgPicture.asset(Assets.imagesOrdersSuccess)),
            SizedBox(height: 33),
            Text('تم تقديم طلبك بنجاح!', style: TextStyles.bold16),
            SizedBox(height: 20),

            Text(
              '  رقم الطلب الخاص بك هو #123456',
              style: TextStyles.regular13.copyWith(color: Color(0xff4E5556)),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            CustomButton(onPressed: () {}, text: 'تتبع الطلب'),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'العودة إلى الصفحة الرئيسية',
                style: TextStyles.bold16.copyWith(
                  color: AppColors.primaryColor,
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                  decorationThickness: 2,
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
