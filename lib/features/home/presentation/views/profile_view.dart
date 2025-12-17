import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helper_functions/get_user.dart';
import 'package:myapp/core/services/shared_preferences_singleton.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/auth/presentation/views/signin_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var user = getuser();
    return Scaffold(
      appBar: buildAppBar(context, title: 'الملف الشخصي', showBackIcon: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // User Info
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(user.phoneNumber, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),

            // Settings List
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                await Prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SigninView.routeName,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
