class BackendEndpoint {
  static const addUserData = 'users';
  static const getUserData = 'users';
  static const isUserExists = 'users';
  static const getProducts = 'products';
  static const addorders = 'orders';
  static const signup = 'http://10.18.120.117:8000/api/auth/register';
}

// lib/core/utils/api_constants.dart
class ApiConstants {
  
  static const String baseUrl = 'http://10.18.120.117:8000/api';

  // Auth Endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp'; // ✅ تأكيد الـ endpoint
  static const String resendOtp = '/auth/resend-otp';

  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> headersWithToken(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
