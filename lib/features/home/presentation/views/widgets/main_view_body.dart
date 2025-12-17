import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/views/cart_view.dart';
import 'package:myapp/features/home/presentation/views/favorites_view.dart';
import 'package:myapp/features/home/presentation/views/product_view.dart';
import 'package:myapp/features/home/presentation/views/shein_view.dart';
import 'package:myapp/features/home/presentation/views/home_view.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({super.key, required this.currentViewIndex});
  final int currentViewIndex;
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentViewIndex,
      children: [
        const HomeView(),
        const ProductView(),
        const SheinView(),
        const CartView(),
        const FavoritesView(),
      ],
    );
  }
}
