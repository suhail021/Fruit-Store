import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/product_item.dart';

class BestSellingGridView extends StatelessWidget {
  const BestSellingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 163 /214,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const ProductItem();
      },
    );
  }
}
