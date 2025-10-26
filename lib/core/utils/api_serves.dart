import 'package:dio/dio.dart';
import 'package:google/core/models/book_model/book_model.dart';

class ApiServes {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;

  ApiServes(this._dio);

  Future<Map<String,dynamic>> get ({required String endpoint}) async{
 var response = await _dio.get('$_baseUrl$endpoint');
 return response.data;
  }
}