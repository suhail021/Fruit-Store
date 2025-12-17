// lib/core/services/api_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/core/errors/custom_exceptions.dart';
import 'package:myapp/core/utils/api_constants.dart';

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  // POST Request
  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      log('📤 POST Request: $url');
      log('📦 Body: ${jsonEncode(data)}');

      final response = await client.post(
        url,
        headers: headers ?? ApiConstants.headers,
        body: jsonEncode(data),
      );

      log('📥 Response Status: ${response.statusCode}');
      log('📥 Response Body: ${response.body}');

      return _handleResponse(response);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } catch (e) {
      log('❌ API Error: $e');
      throw ServerException(
        message: 'فشل الاتصال بالخادم. تحقق من اتصال الإنترنت.',
      );
    }
  }
  // lib/core/services/api_service.dart

  // إضافة دالة للطلبات المحمية (التي تحتاج توكن)
  Future<Map<String, dynamic>> postWithAuth({
    required String endpoint,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    return await post(
      endpoint: endpoint,
      data: data,
      headers: ApiConstants.headersWithToken(token),
    );
  }

  Future<Map<String, dynamic>> getWithAuth({
    required String endpoint,
    required String token,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await get(
      endpoint: endpoint,
      headers: ApiConstants.headersWithToken(token),
      queryParameters: queryParameters,
    );
  }

  // GET Request
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      if (queryParameters != null) {
        url = url.replace(queryParameters: queryParameters);
      }

      log('📤 GET Request: $url');

      final response = await client.get(
        url,
        headers: headers ?? ApiConstants.headers,
      );

      log('📥 Response Status: ${response.statusCode}');
      log('📥 Response Body: ${response.body}');

      return _handleResponse(response);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } catch (e) {
      log('❌ API Error: $e');
      throw ServerException(
        message: 'فشل الاتصال بالخادم. تحقق من اتصال الإنترنت.',
      );
    }
  }

  // Handle Response
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      // Success Response
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw ServerException(message: 'خطأ في معالجة البيانات من الخادم');
      }
    } else if (statusCode == 400) {
      // Bad Request
      final errorData = jsonDecode(response.body) as Map<String, dynamic>;
      throw ServerException(
        message: errorData['message'] ?? 'بيانات غير صحيحة',
      );
    } else if (statusCode == 401) {
      // Unauthorized
      throw ServerException(message: 'غير مصرح. يرجى تسجيل الدخول مرة أخرى');
    } else if (statusCode == 422) {
      // Validation Error
      final errorData = jsonDecode(response.body) as Map<String, dynamic>;
      final errors = errorData['errors'] as Map<String, dynamic>?;

      if (errors != null) {
        final firstError = errors.values.first;
        final errorMessage = firstError is List ? firstError.first : firstError;
        throw ServerException(message: errorMessage.toString());
      }

      throw ServerException(
        message: errorData['message'] ?? 'خطأ في التحقق من البيانات',
      );
    } else if (statusCode == 500) {
      // Server Error
      throw ServerException(message: 'خطأ في الخادم. يرجى المحاولة لاحقاً');
    } else {
      // Other Errors
      throw ServerException(
        message: 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى',
      );
    }
  }
}
