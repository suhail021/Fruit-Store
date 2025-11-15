import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = <IconData>[
      Icons.home_rounded,
      Icons.search_rounded,
      Icons.add, // middle icon
      Icons.notifications_rounded,
      Icons.person_rounded,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, -4),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final isMiddle = index == 2;
          final isSelected = currentIndex == index;

          if (isMiddle) {
            // UNIQUE MIDDLE ICON
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      color: AppColors.primaryColor.withOpacity(0.4),
                    ),
                  ],
                ),
                child: Icon(icons[index], size: 30, color: Colors.white),
              ),
            );
          }

          // NORMAL ICONS (LEFT & RIGHT)
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 4),
                  Icon(
                    icons[index],
                    size: 26,
                    color:
                        isSelected ? AppColors.primaryColor : Colors.grey[500],
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: isSelected ? 18 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
