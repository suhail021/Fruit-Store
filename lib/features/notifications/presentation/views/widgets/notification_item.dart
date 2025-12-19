import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

class NotificationItem extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    bool isRead = notification['isRead'] == 'true';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification['title'] ?? '',
                      style: TextStyles.bold16,
                    ),
                    Text(
                      notification['time'] ?? '',
                      style: TextStyles.regular13.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification['body'] ?? '',
                  style: TextStyles.regular13.copyWith(color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
