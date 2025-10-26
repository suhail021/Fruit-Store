import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google/core/utils/app_router.dart';
import 'package:google/core/widgets/custom_loading_indicator.dart';
import 'package:google/features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:google/core/widgets/custom_Error_widget.dart';
import 'package:google/features/home/presentation/views/widgets/custome_books_image_list_view_item.dart';

class FeaturedBooksListView extends StatelessWidget {
  const FeaturedBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            child: ListView.builder(
              semanticChildCount: 1,
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).push(AppRouter.kBookDetailsView, extra: state.books[index]);
                  },
                  child: CustomeBooksImageListViewItem(
                    aspectratio: 2.5 / 4,
                    imageUrl:
                        state.books[index].volumeInfo.imageLinks?.thumbnail ??
                        "",
                  ),
                );
              },
            ),
          );
        } else if (state is FeaturedBooksfailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return CustomLoadingIndicator();
        }
      },
    );
  }
}
