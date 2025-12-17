import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_item_entity.dart';
import 'package:myapp/features/home/presentation/views/widgets/cart_item.dart';

class CarItemsList extends StatelessWidget {
  const CarItemsList({super.key, required this.carItems});

  final List<CartItemEntity> carItems;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const CustomDivider(),
      itemCount: carItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          child: CartItem(carItemEntity: carItems[index]),
        );
      },
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Color(0xFFF1F1F5), height: 22);
  }
}
