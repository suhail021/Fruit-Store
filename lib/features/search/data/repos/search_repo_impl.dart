import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/core/utils/api_serves.dart';
import 'package:google/features/search/data/repos/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiServes apiServes;

  SearchRepoImpl(this.apiServes);

  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks({
    required String searchBooks,
  }) async {
    try {
      var data = await apiServes.get(
        endpoint:
            'volumes?q=subject:*&search=$searchBooks',
      );
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
