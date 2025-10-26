import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomeBooksImageListViewItem extends StatelessWidget {
  const CustomeBooksImageListViewItem({
    super.key,
    required this.aspectratio,
    required this.imageUrl,
  });
  final double aspectratio;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(right: 10  ,left:  10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          // 3 this is the width and the 4 is the height
          aspectRatio: aspectratio,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
      // placeholder: (context, url) => const CircularProgressIndicator(padding: EdgeInsets.symmetric(horizontal: 45,vertical: 80),color: Colors.white,strokeWidth: 2,),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
        ),
      ),
    );
  }
}
