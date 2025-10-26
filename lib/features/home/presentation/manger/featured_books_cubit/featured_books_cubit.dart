import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/home/data/repos/home_repo.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    var result = await homeRepo.fetchFeaturedBooks();

    result.fold(
      (failure) {
        emit(FeaturedBooksfailure(failure.errMessage));
      },
      (books) {
        emit(FeaturedBooksSuccess(books));
      },
    );
  }
}
