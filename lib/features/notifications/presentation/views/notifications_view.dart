import 'package:flutter/material.dart';
import 'package:myapp/features/notifications/presentation/views/widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  static const String routeName = 'notifications_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        centerTitle: true,
      ),
      body: const NotificationsViewBody(),
    );
  }
}
