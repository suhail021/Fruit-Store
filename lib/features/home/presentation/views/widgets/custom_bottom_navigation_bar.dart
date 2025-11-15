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
      Icons.add,
      Icons.notifications_rounded,
      Icons.person_rounded,
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, -2),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Navigation items
          Row(
            children: List.generate(5, (index) {
              if (index == 2) return const Spacer();

              final isSelected = currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 26,
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 3,
                        width: isSelected ? 20 : 0,
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

          // Floating middle button
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 28,
            top: -14,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                      color: AppColors.primaryColor.withOpacity(0.3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}