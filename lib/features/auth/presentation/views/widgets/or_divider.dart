import 'package:flutter/material.dart';
import 'package:google/core/utils/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(height: 1, color: Color(0xffdcdede))),
        SizedBox(width: 18,),
        Text('أو',style: TextStyles.semibold16.copyWith(color: Color(0xff0c0d0d)),),
                SizedBox(width: 18,),
        Expanded(child: Divider(height: 1, color: Color(0xffdcdede))),
      ],
    );
  }
}
