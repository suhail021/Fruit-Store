import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/core/widgets/custom_Error_widget.dart';
import 'package:google/core/widgets/custom_loading_indicator.dart';
import 'package:google/features/search/presentation/manger/search_books_cubit/search_books_cubit.dart';
import 'package:google/features/search/presentation/views/widgets/custom_search_text_filed.dart';
import 'package:google/features/search/presentation/views/widgets/search_view_item.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearchPressed() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      BlocProvider.of<SearchBooksCubit>(
        context,
      ).fetchSearchBooks(searchBook: query);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomSearchTextFiled(
              controller: _searchController,
              onSearchPressed: _onSearchPressed,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: Text("Resulte")),
          BlocBuilder<SearchBooksCubit, SearchBooksState>(
            builder: (context, state) {
              if (state is SearchBooksSuccess) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: SearchViewItem(book: state.books[index]),
                    );
                  }, childCount: state.books.length),
                );
              } else if (state is SearchBooksFailure) {
                return SliverToBoxAdapter(
                  child: CustomErrorWidget(errMessage: state.errMessage),
                );
              } else if(state is SearchBooksLoading){
                return SliverToBoxAdapter(child: CustomLoadingIndicator());
              }else{
                return Text("");
              }
            },
          ),
        ],
      ),
    );
  }
}
