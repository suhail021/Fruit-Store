import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google/core/utils/app_router.dart';
import 'package:google/core/utils/assates.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 12, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetsData.logo, width: 75, height: 16),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSearchView);
            },
            icon: const Icon(Icons.search, size: 24),
          ),
        ],
      ),
    );
  }
}
