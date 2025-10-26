import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/search/data/repos/search_repo.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.searchRepo) : super(SearchBooksInitial());

  final SearchRepo searchRepo;
  Future<void> fetchSearchBooks({required String searchBook}) async {
    emit(SearchBooksLoading());
  
      var result = await searchRepo.fetchSearchBooks(searchBooks: searchBook);
      result.fold(
        (failure) {
          emit(SearchBooksFailure(failure.errMessage));
        },
        (books) {
          emit(SearchBooksSuccess(books));
        },
      );
    
  }
}
