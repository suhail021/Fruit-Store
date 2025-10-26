import 'package:flutter/material.dart';
import 'package:google/core/utils/styles.dart';

class CustomeBottom extends StatelessWidget {
  const CustomeBottom({
    super.key,
    required this.bgcolor,
    required this.borderRadius,
    required this.textcolor,
    required this.text, this.onPressed,
  });
  final void Function()? onPressed;
  final String text;
  final Color textcolor;
  final Color bgcolor;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 44,
      color: bgcolor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Text(text, style: Styles.textStyle18.copyWith(color: textcolor)),
    );
  }
}
