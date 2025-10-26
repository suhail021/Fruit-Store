import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/home/data/repos/home_repo.dart';

part 'newset_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepo) : super(SimilarBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchSimilarBooks({required String categary}) async {
    emit(SimilarBooksLoading());
    var result = await homeRepo.fetchSimilarBooks(categary: categary);

    result.fold(
      (failure) {
        emit(SimilarBooksfailure(failure.errMessage));
      },
      (books) {
        emit(SimilarBooksSuccess(books));
      },
    );
  }
}
