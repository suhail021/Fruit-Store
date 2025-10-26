import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/core/utils/api_serves.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiServes apiServes;

  HomeRepoImpl(this.apiServes);
  @override
  Future<Either<Failure, List<BookModel>>> fetchNewsetBooks() async {
    try {
      var data = await apiServes.get(
        endpoint:
            'volumes?Filtering=free-ebooks&Sorting=newset &q=computer science',
      );
      List<BookModel> books = [];
      for (var item in data['items']) {
        try {
          books.add(BookModel.fromJson(item));
        } catch (e) {
          books.add(BookModel.fromJson(item));
        }
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiServes.get(
        endpoint: 'volumes?Filtering=free-ebooks&Sorting=newset &q=Programming',
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

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({
    required String categary,
  }) async {
    try {
      var data = await apiServes.get(
        endpoint:
            'volumes?Filtering=free-ebooks&Sorting=relevance &q=Programming',
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
