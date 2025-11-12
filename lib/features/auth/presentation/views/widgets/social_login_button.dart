import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
  });
  final String image;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(color: Color(0xffdcdede), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),

        onPressed: onPressed,
        child: ListTile(
          visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
          leading: SvgPicture.asset(image),
          title: Text(
            title,
            style: TextStyles.semibold16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
