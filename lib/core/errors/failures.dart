import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("connection time with ApiServer");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout with ApiServer");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout with ApiServer");
      case DioExceptionType.badCertificate: 
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode as int,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure("Receive timeout with ApiServer");
      case DioExceptionType.connectionError:
        if (dioException.message!.contains('SouketException:')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('No Internet Connection!');

      case DioExceptionType.unknown:
        return ServerFailure('connectionError');

      default:
        return ServerFailure("opps there was an Error, please try again!");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure("your requst no found, plase try later!");
    } else if (statusCode == 500) {
      return ServerFailure("Internal Server error , plase try later!");
    } else {
      return ServerFailure("opps there was an Error, please try again!");
    }
  }
}
