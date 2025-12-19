import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/views/profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}
