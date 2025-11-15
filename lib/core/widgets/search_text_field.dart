import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0a000000),
            blurRadius: 9,
            offset: const Offset(0, 2),
            spreadRadius: 0
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: SvgPicture.asset(
            Assets.imagesFilter,
            fit: BoxFit.scaleDown,
          ),
          prefixIcon: SvgPicture.asset(
            Assets.imagesSearchIcon,
            fit: BoxFit.scaleDown,
          ),
          hintStyle: TextStyles.regular13.copyWith(
            color: const Color(0xff949d9e),
          ),
      
          hintText: 'ابحث عن.......',
          filled: true,
          fillColor: Colors.white,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(width: 1.5, color: Colors.white),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 1, color: Colors.white),
    );
  }
}
