// lib/core/utils/api_constants.dart
class ApiConstants {
  // 🌐 Base URL
  static const String baseUrl = 'https://gray-owl-375582.hostingersite.com/api';
  
  // ==========================================
  // Auth Endpoints
  // ==========================================
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String logout = '/auth/logout';
  
  // ==========================================
  // Products Endpoints
  // ==========================================
  static const String products = '/products';
  static const String productsSearch = '/products/search';
  static const String productsFeatured = '/products/featured';
  static const String productsCheckAvailability = '/products'; // /{id}/check-availability
  
  // Interior Products
  static const String interiorProducts = '/interior-products';
  static const String interiorProductsSearch = '/interior-products/search';
  static const String interiorProductsFeatured = '/interior-products/featured';
  static const String interiorProductsByStore = '/interior-products/by-store'; // /{storeId}
  static const String interiorProductsByCategory = '/interior-products/by-category'; // /{categoryId}
  
  // ==========================================
  // Favorites Endpoints
  // ==========================================
  static const String favorites = '/favorites';
  static const String favoritesToggle = '/favorites/toggle';
  static const String favoritesCheck = '/favorites/check';
  
  // ==========================================
  // Addresses Endpoints
  // ==========================================
  static const String addresses = '/addresses';
  static const String addressesDefault = '/addresses/default';
  static const String addressesSetDefault = '/addresses'; // /{id}/set-default
  
  // ==========================================
  // User Profile Endpoints
  // ==========================================
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String balance = '/user/balance';
  static const String referralCode = '/user/referral-code';
  static const String referralStats = '/user/referral-stats';
  
  // ==========================================
  // Invoices (Orders) Endpoints
  // ==========================================
  static const String invoices = '/invoices';
  static const String invoicesCreate = '/invoices';
  static const String invoicesShow = '/invoices'; // /{id}
  static const String invoicesCancel = '/invoices'; // /{id}/cancel
  static const String invoicesPaymentProof = '/invoices'; // /{id}/payment-proof
  
  // ==========================================
  // Notifications Endpoints
  // ==========================================
  static const String notifications = '/notifications';
  static const String notificationsUnreadCount = '/notifications/unread-count';
  static const String notificationsMarkAllRead = '/notifications/mark-all-read';
  static const String notificationsMarkRead = '/notifications'; // /{id}/mark-read
  static const String notificationsRecent = '/notifications/recent';
  static const String notificationsByType = '/notifications/type'; // /{type}
  static const String notificationsDelete = '/notifications'; // /{id}
  static const String notificationsDeleteAll = '/notifications/delete-all';
  
  // ==========================================
  // Announcements Endpoints
  // ==========================================
  static const String announcements = '/announcements';
  static const String announcementsUnreadCount = '/announcements/unread-count';
  static const String announcementsMarkAllRead = '/announcements/mark-all-read';
  static const String announcementsMarkRead = '/announcements'; // /{id}/mark-read
  static const String announcementsRecent = '/announcements/recent';
  static const String announcementsByType = '/announcements/type'; // /{type}
  static const String announcementsUnread = '/announcements/unread';
  static const String announcementsSearch = '/announcements/search';
  
  // ==========================================
  // Stores Endpoints
  // ==========================================
  static const String stores = '/stores';
  static const String storesSearch = '/stores/search';
  static const String storesFeatured = '/stores/featured';
  static const String storesByCity = '/stores/by-city'; // /{city}
  static const String storesProducts = '/stores'; // /{id}/products
  static const String storesCategories = '/stores'; // /{id}/categories
  static const String storesStatus = '/stores'; // /{id}/status
  
  // ==========================================
  // Coupons Endpoints
  // ==========================================
  static const String couponsValidate = '/coupons/validate';
  static const String couponsApply = '/coupons/apply';
  static const String couponsMy = '/coupons/my-coupons';
  
  // ==========================================
  // Referrals Endpoints
  // ==========================================
  static const String referralsMyCode = '/referrals/my-code';
  static const String referralsValidate = '/referrals/validate-code';
  static const String referralsCreate = '/referrals/create';
  static const String referralsStats = '/referrals/my-stats';
  static const String referralsMyReferrals = '/referrals/my-referrals';
  static const String referralsCoupons = '/referrals/my-coupons';
  static const String referralsTiers = '/referrals/tiers';
  
  // ==========================================
  // Chat Endpoints
  // ==========================================
  static const String chatConversations = '/chat/conversations';
  static const String chatMessages = '/chat/conversations'; // /{id}/messages
  static const String chatSendMessage = '/chat/conversations'; // /{id}/messages
  static const String chatMarkRead = '/chat/conversations'; // /{id}/mark-read
  
  // ==========================================
  // Returns Endpoints
  // ==========================================
  static const String returns = '/returns';
  static const String returnsCreate = '/returns';
  static const String returnsShow = '/returns'; // /{id}
  static const String returnsCancel = '/returns'; // /{id}/cancel
  static const String returnsEligible = '/returns/eligible-items';
  
  // ==========================================
  // Representative Application Endpoints
  // ==========================================
  static const String representativeApply = '/representative/apply';
  static const String representativeStatus = '/representative/status';
  
  // ==========================================
  // Headers
  // ==========================================
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static Map<String, String> headersWithToken(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  
  static Map<String, String> multipartHeadersWithToken(String token) => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
