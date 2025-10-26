import 'package:dartz/dartz.dart';
import 'package:google/core/errors/failures.dart';
import 'package:google/core/models/book_model/book_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks({
    required String searchBooks,
  });
}
