import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  bool showBackIcon = true,
  bool showactionsIcon = false,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading:
        showBackIcon
            ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            )
            : null,
    centerTitle: true,
    title: Text(title, style: TextStyles.bold19),
    actions:
        showactionsIcon
            ? [
              Container(
                padding: EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  shape: OvalBorder(),
                  color: Color(0xffeef8ed),
                ),
                child: SvgPicture.asset(Assets.imagesNotification),
              ),
            ]
            : null,
  );
}
