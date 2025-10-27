import 'package:flutter/material.dart';
import 'package:google/features/on_boarding/presentation/views/widgets/page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        PageViewItem(
          image: "image",
          backgroundColor: "backgroundColor",
          subtitle: "subtitle",
          title: Row(
            children: [
              Text("مرحبا بكم في"),
              Text("Fruit"),
              Text("Store"),
            ],
          ),
        ),
      ],
    );
  }
}
