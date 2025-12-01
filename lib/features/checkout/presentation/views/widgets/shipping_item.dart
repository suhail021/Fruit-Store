import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

class ShippingItem extends StatelessWidget {
  const ShippingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected, required this.onTap,
  });
  final String title, subtitle, price;
  final bool isSelected;
 final VoidCallback  onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 13, right: 28),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0x33d9d9d9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected ?  AppColors.primaryColor :Colors.transparent,
              width: 1.5
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSelected ? ActiveShippingItemDot() : InActiveShippingItemDot(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title, style: TextStyles.semibold13),
                  SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyles.regular13.copyWith(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Center(
                child: Text(
                  '${price} ريال ',
                  style: TextStyles.bold13.copyWith(
                    color: AppColors.lightPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InActiveShippingItemDot extends StatelessWidget {
  const InActiveShippingItemDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: ShapeDecoration(
        shape: OvalBorder(side: BorderSide(width: 1, color: Color(0xff949d9e))),
      ),
    );
  }
}

class ActiveShippingItemDot extends StatelessWidget {
  const ActiveShippingItemDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: ShapeDecoration(
        color: AppColors.primaryColor,
        shape: OvalBorder(side: BorderSide(width: 4, color: Colors.white)),
      ),
    );
  }
}
