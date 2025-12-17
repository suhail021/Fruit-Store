// shein_top_bar.dart
import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';

class SheinTopBar extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onBack;
  final VoidCallback? onForward;

  const SheinTopBar({Key? key, this.onRefresh, this.onBack, this.onForward})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            "SHEIN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: onRefresh,
          ),
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: onForward,
          ),
        ],
      ),
    );
  }
}
