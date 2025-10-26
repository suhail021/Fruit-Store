import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/core/widgets/custom_Error_widget.dart';
import 'package:google/core/widgets/custom_loading_indicator.dart';
import 'package:google/features/home/presentation/manger/newset_books_cubit/newset_books_cubit.dart';
import 'package:google/features/home/presentation/views/widgets/best_seller_list_view_item.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsetBooksCubit, NewsetBooksState>(
      builder: (context, state) {
        if (state is NewsetBooksSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return  Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: BestSellerListViewItem(book: state.books[index],),
              );
            }, childCount: state.books.length),
          );
        } else if (state is NewsetBooksfailure) {
          return SliverToBoxAdapter(child: CustomErrorWidget(errMessage: state.errMessage));
        } else {
          return SliverToBoxAdapter(child: CustomLoadingIndicator());
        }
      },
    );
  }
}
