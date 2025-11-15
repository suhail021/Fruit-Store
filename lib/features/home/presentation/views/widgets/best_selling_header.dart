import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'الأكثر مبيعًا',
          style: TextStyles.bold16,
        ),
        const Spacer(),
        Text(
          'المزيد',
             style: TextStyles.regular13,
        ),
      ],
    );
  }
}