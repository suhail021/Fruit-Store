import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/bottom_navigation_bar_entity.dart';

import 'active_item.dart';
import 'in_active_item.dart';

class NaivgationBarItem extends StatelessWidget {
  const NaivgationBarItem({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
    this.isMiddleButton = false,
  });

  final bool isSelected;
  final bool isMiddleButton;
  final BottomNavigationBarEntity bottomNavigationBarEntity;

  @override
  Widget build(BuildContext context) {
    if (isMiddleButton) {
      return ActiveItem(
        image: bottomNavigationBarEntity.inActiveImage,
        isMiddleButton: true,
      );
    }

    return isSelected
        ? ActiveItem(image: bottomNavigationBarEntity.activeImage)
        : InActiveItem(image: bottomNavigationBarEntity.inActiveImage);
  }
}
