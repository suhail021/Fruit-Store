import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

class InActiveStepItem extends StatelessWidget {
  const InActiveStepItem({super.key, required this.text, required this.index});
  final String text;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Color(0xfff2f3f3),
          child: Text('${index+1}', style: TextStyles.semibold13),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyles.semibold13.copyWith(color: Color(0XFFAAAAAA)),
        ),
      ],
    );
  }
}
