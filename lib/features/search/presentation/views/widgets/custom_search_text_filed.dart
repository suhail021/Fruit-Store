import 'package:flutter/material.dart';

class CustomSearchTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchPressed;

  const CustomSearchTextFiled({
    super.key,
    required this.controller,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onSearchPressed,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),

        hintText: 'Search',
        suffixIcon: IconButton(
          onPressed: onSearchPressed,
          icon: Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}
