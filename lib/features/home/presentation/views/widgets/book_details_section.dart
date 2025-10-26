import 'package:flutter/material.dart';
import 'package:google/core/utils/styles.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/home/presentation/views/widgets/BooksAction.dart';
import 'package:google/features/home/presentation/views/widgets/book_rating.dart';
import 'package:google/features/home/presentation/views/widgets/custome_books_details_app_bar.dart';
import 'package:google/features/home/presentation/views/widgets/custome_books_details_image.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.bookModel});
final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomeBooksDetailsAppBar(),
        const SizedBox(height: 5),
         CustomeBooksDetailsImage(imageUrl: bookModel.volumeInfo.imageLinks?.thumbnail ??"",),
        const SizedBox(height: 30),
         Text(bookModel.volumeInfo.title!, style: Styles.textStyle30,textAlign: TextAlign.center,),
        Text(
         bookModel.volumeInfo.authors![0],
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.normal,
            color: Color(0xffA9ABB8),
          ),
        ),
        const SizedBox(height: 8),

        const BookRating(),
        SizedBox(height: 10),
        BooksAction(bookModel: bookModel,),
      ],
    );
  }
}
