import 'package:dartz/dartz.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/core/models/book_model/book_model.dart';

abstract class HomeRepo {
  Future<Either<Failure , List<BookModel>>> fetchNewsetBooks();
  Future<Either<Failure , List<BookModel>>> fetchFeaturedBooks();
  Future<Either<Failure , List<BookModel>>> fetchSimilarBooks({required String categary});
}
