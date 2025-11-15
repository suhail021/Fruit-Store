import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:myapp/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
    int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int value) {
          _currentIndex = value;
          setState(() {});
        },
      ),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
