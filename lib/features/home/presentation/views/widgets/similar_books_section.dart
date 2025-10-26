import 'package:flutter/material.dart';
import 'package:google/core/utils/styles.dart';
import 'package:google/features/home/presentation/views/widgets/similar_books_list_view.dart';

class SimilarBooksSection extends StatelessWidget {
  const SimilarBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "You can also like",
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),

        const Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: SimilarBooksListView(),
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
