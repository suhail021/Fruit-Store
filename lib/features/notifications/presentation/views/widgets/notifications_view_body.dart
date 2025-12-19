import 'package:flutter/material.dart';
import 'package:myapp/features/notifications/presentation/views/widgets/notification_item.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, String>> notifications = [
      {
        'title': 'تم شحن طلبك',
        'body': 'طلبك رقم #12345 في طريقه إليك.',
        'time': 'الآن',
        'isRead': 'false',
      },
      {
        'title': 'عرض خاص!',
        'body': 'خصم 20% على جميع الفواكه الطازجة.',
        'time': 'منذ ساعة',
        'isRead': 'true',
      },
      {
        'title': 'تحديث حالة الطلب',
        'body': 'تم تجهيز طلبك رقم #12344.',
        'time': 'منذ يومين',
        'isRead': 'true',
      },
    ];

    if (notifications.isEmpty) {
      return const Center(
        child: Text("لا توجد إشعارات حالياً"),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return NotificationItem(notification: notifications[index]);
      },
    );
  }
}
