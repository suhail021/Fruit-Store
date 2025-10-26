import 'package:flutter/material.dart';
import 'package:google/core/utils/Function/launch_url.dart';
import 'package:google/core/widgets/custome_bottom.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomeBottom(
              onPressed: () {},
              bgcolor: Colors.white,
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),

              textcolor: Colors.black,
              text: "Free",
            ),
          ),
          Expanded(
            child: CustomeBottom(
              bgcolor: Color(0xffE57964),
              borderRadius: BorderRadiusGeometry.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              textcolor: Colors.white,
              text: getText(bookModel),
              onPressed: () async {
           launchcustomeurl(context,bookModel.volumeInfo.previewLink);
              },
            ),
          ),
        ],
      ),
    );
  }
  String getText(BookModel bookModel) {
    if (bookModel.volumeInfo.previewLink == null) {
      return 'Not Avalible';
    } else {
      return 'Preview';
    }
  }
}
