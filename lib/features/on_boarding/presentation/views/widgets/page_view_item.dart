import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subtitle,
    required this.title,
  });
  final String image, backgroundImage;
  final String subtitle;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(image),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("تخط", style: TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60.0),

        title,
        const SizedBox(height: 24.0),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
             style: TextStyle(  
                color: Color(0XFF4E5556),
                fontFamily: 'Cairo',
              ),
          ),
        ),
      ],
    );
  }
}
