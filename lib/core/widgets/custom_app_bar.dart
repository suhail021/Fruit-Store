import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  bool showBackIcon = true, 
}) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false, 
    leading: showBackIcon
        ? GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          )
        : null, 
    centerTitle: true,
    title: Text(
      title,
      style: TextStyles.bold19,
    ),
  );
}
