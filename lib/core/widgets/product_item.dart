import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xfff3f5f7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            right: 0,
            child: Column(
              children: [
                Image.asset(Assets.imagesFruitTest),
                ListTile(
                  title: Text('برتقال', style: TextStyles.bold16),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '300 ريال',
                          style: TextStyles.bold13.copyWith(
                            color: AppColors.lightsecondaryColor,
                          ),
                        ),
                        TextSpan(
                          text: ' / ',
                          style: TextStyles.semibold13.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'كيلو',
                          style: TextStyles.semibold13.copyWith(
                            color: AppColors.lightsecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }
}
