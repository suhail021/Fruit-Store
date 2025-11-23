import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({
    super.key, 
    required this.image,
    this.isMiddleButton = false,
  });

  final String image;
  final bool isMiddleButton;
  
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image, 
      color: isMiddleButton ? Colors.white : AppColors.primaryColor,
      width: isMiddleButton ? 28 : 24,
      height: isMiddleButton ? 28 : 24,
    );
  }
}