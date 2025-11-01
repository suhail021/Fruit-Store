import 'package:flutter/material.dart';
import 'package:google/core/utils/app_text_styles.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
     this.suffixIcon,
  });
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintStyle: TextStyles.bold13.copyWith(color: const Color(0xff949d9e)),
        hintText: hintText,
        filled: true,
        fillColor: Color(0xfff9fafa),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(width: 2, color: Color(0xffe6e9e9)),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 1, color: Color(0xffe6e9e9)),
    );
  }
}
