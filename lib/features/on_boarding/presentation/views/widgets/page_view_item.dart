import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundColor,
    required this.subtitle,
    required this.title,
  });
  final String image, backgroundColor;
  final String subtitle;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Stack(children: [
          Text('')
        ],)
      ],
    );
  }
}
