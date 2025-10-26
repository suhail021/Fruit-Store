import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/core/widgets/custom_Error_widget.dart';
import 'package:google/core/widgets/custom_loading_indicator.dart';
import 'package:google/features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:google/features/home/presentation/views/widgets/custome_books_image_list_view_item.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if (state is SimilarBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .16,
            child: ListView.builder(
              semanticChildCount: 1,
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return  CustomeBooksImageListViewItem(
                  aspectratio: 2.5 / 4,
                  imageUrl:state.books[index].volumeInfo.imageLinks?.thumbnail ?? '' ,
                );
              },
            ),
          );
        } else if (state is SimilarBooksfailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        }
        {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
