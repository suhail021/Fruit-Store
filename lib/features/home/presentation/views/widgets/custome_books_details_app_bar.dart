import 'package:flutter/material.dart';

class CustomeBooksDetailsAppBar extends StatelessWidget {
  const CustomeBooksDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.close, size: 28)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, size: 26),
          ),
        ],
      ),
    );
  }
}
