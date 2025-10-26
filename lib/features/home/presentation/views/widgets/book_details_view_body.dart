import 'package:flutter/material.dart';
import 'package:google/core/models/book_model/book_model.dart';

import 'package:google/features/home/presentation/views/widgets/book_details_section.dart';

import 'package:google/features/home/presentation/views/widgets/similar_books_section.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.bookModel});
final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                BookDetailsSection(bookModel: bookModel,),

                const Expanded(child: SizedBox(height: 40)),
                SimilarBooksSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
