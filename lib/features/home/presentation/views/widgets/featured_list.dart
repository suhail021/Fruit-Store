import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/views/widgets/featured_item.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FeaturedItem(),
          );
        }),
      ),
    );
  }
}
