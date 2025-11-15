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
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, -4),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Curved notch background
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: _NotchPainter(),
          ),
          
          // Navigation items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(5, (index) {
                final isMiddle = index == 2;
                final isSelected = currentIndex == index;

                if (isMiddle) {
                  return const SizedBox(width: 80); // Space for floating button
                }

                // NORMAL ICONS (LEFT & RIGHT)
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.all(isSelected ? 8 : 0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              icons[index],
                              size: 26,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey[500],
                            ),
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
                  ),
                );
              }),
            ),
          ),
          
          // ELEVATED MIDDLE BUTTON
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 32,
            top: -16,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                      color: AppColors.primaryColor.withOpacity(0.4),
                    ),
                    BoxShadow(
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      color: AppColors.primaryColor.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Icon(
                    icons[2],
                    size: 32,
                    color: Colors.white,
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

// Custom painter for the notched background
class _NotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    
    final notchRadius = 40.0;
    final notchMargin = 8.0;
    final centerX = size.width / 2;
    
    path.moveTo(0, 0);
    path.lineTo(centerX - notchRadius - notchMargin, 0);
    
    // Create smooth curve for notch
    path.quadraticBezierTo(
      centerX - notchRadius,
      0,
      centerX - notchRadius + notchMargin,
      notchMargin,
    );
    
    path.arcToPoint(
      Offset(centerX + notchRadius - notchMargin, notchMargin),
      radius: Radius.circular(notchRadius - notchMargin),
      clockwise: false,
    );
    
    path.quadraticBezierTo(
      centerX + notchRadius,
      0,
      centerX + notchRadius + notchMargin,
      0,
    );
    
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}