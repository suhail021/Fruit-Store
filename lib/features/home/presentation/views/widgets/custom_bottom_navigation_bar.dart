import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/bottom_navigation_bar_entity.dart';

import 'naivation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.onItemTapped});
  final ValueChanged<int> onItemTapped;
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // احسب الزر الأوسط
    int middleIndex = (bottomNavigationBarItems.length / 2).floor();

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
          Row(
            children:
                bottomNavigationBarItems.asMap().entries.map((e) {
                  var index = e.key;
                  var entity = e.value;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          widget.onItemTapped(index);
                        });
                      },
                      child:
                          index == middleIndex
                              ? const SizedBox() // مساحة فارغة للزر الأوسط
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NaivgationBarItem(
                                    isSelected: selectedIndex == index,
                                    bottomNavigationBarEntity: entity,
                                  ),
                                  const SizedBox(height: 6),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: 3,
                                    width: selectedIndex == index ? 20 : 0,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  );
                }).toList(),
          ),

          // الزر الأوسط المميز
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 32,
            top: -20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = middleIndex;
                  widget.onItemTapped(middleIndex);
                });
              },
              child: Container(
                width: 64,
                height: 64,
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
                child: Center(
                  child: NaivgationBarItem(
                    isSelected: true,
                    bottomNavigationBarEntity:
                        bottomNavigationBarItems[middleIndex],
                    isMiddleButton: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
