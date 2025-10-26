import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:google/features/home/presentation/views/widgets/book_details_view_body.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    BlocProvider.of<SimilarBooksCubit>(
      context,
    ).fetchSimilarBooks(categary: widget.bookModel.volumeInfo.categories?[0] ?? " no categories");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BookDetailsViewBody(bookModel: widget.bookModel));
  }
}
