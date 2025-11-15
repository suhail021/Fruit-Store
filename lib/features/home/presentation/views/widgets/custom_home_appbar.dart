import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(Assets.imagesProfileImage),
      title: Text(
        'صباح الخير !..',
        style: TextStyles.regular16.copyWith(color: Color(0xff949D9E)),
      ),
      subtitle: Text('أحمد مصطفي', style: TextStyles.bold16),
      trailing: Container(
        padding: EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: OvalBorder(),
          color: Color(0xffeef8ed),
        ),
        child: SvgPicture.asset(Assets.imagesNotification),
      ),
    );
  }
}
