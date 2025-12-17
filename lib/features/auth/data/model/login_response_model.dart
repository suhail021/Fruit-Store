// lib/features/auth/data/models/login_response_model.dart
import 'package:myapp/features/auth/data/model/user_model.dart';

class LoginResponseModel {
  final bool success;
  final String message;
  final String? token;
  final UserModel? user;
  final List<AddressData>? addresses;
  final List<FavoriteData>? favorites;
  final InvoicesData? invoices;
  final CouponsData? coupons;
  final List<dynamic>? notifications;
  final List<AnnouncementData>? announcements;
  final List<ChatRoomData>? chatRooms;
  final ReferralData? referralData;
  final StatsData? stats;

  LoginResponseModel({
    required this.success,
    required this.message,
    this.token,
    this.user,
    this.addresses,
    this.favorites,
    this.invoices,
    this.coupons,
    this.notifications,
    this.announcements,
    this.chatRooms,
    this.referralData,
    this.stats,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      token: json['token'] as String?,
      user:
          json['user'] != null
              ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
              : null,
      addresses:
          json['addresses'] != null
              ? (json['addresses'] as List)
                  .map((e) => AddressData.fromJson(e))
                  .toList()
              : null,
      favorites:
          json['favorites'] != null
              ? (json['favorites'] as List)
                  .map((e) => FavoriteData.fromJson(e))
                  .toList()
              : null,
      invoices:
          json['invoices'] != null
              ? InvoicesData.fromJson(json['invoices'])
              : null,
      coupons:
          json['coupons'] != null
              ? CouponsData.fromJson(json['coupons'])
              : null,
      notifications: json['notifications'] as List?,
      announcements:
          json['announcements'] != null
              ? (json['announcements'] as List)
                  .map((e) => AnnouncementData.fromJson(e))
                  .toList()
              : null,
      chatRooms:
          json['chat_rooms'] != null
              ? (json['chat_rooms'] as List)
                  .map((e) => ChatRoomData.fromJson(e))
                  .toList()
              : null,
      referralData:
          json['referral_data'] != null
              ? ReferralData.fromJson(json['referral_data'])
              : null,
      stats: json['stats'] != null ? StatsData.fromJson(json['stats']) : null,
    );
  }
}

// Address Data
class AddressData {
  final int idAddresses;
  final String country;
  final String city;
  final String? street;
  final String? postalCode;
  final bool isDefault;
  final String? descriptionAddresses;

  AddressData({
    required this.idAddresses,
    required this.country,
    required this.city,
    this.street,
    this.postalCode,
    required this.isDefault,
    this.descriptionAddresses,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      idAddresses: json['id_addresses'] as int,
      country: json['country'] as String,
      city: json['city'] as String,
      street: json['street'] as String?,
      postalCode: json['postal_code'] as String?,
      isDefault: json['is_default'] as bool,
      descriptionAddresses: json['description_addresses'] as String?,
    );
  }
}

// Favorite Data
class FavoriteData {
  final int idFavorites;
  final String productName;
  final String? productDescription;
  final String? img;
  final String productLink;
  final DateTime createdAt;

  FavoriteData({
    required this.idFavorites,
    required this.productName,
    this.productDescription,
    this.img,
    required this.productLink,
    required this.createdAt,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    return FavoriteData(
      idFavorites: json['id_favorites'] as int,
      productName: json['product_name'] as String,
      productDescription: json['product_description'] as String?,
      img: json['img'] as String?,
      productLink: json['product_link'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

// Invoices Data
class InvoicesData {
  final List<dynamic> incomplete;
  final List<dynamic> pendingVerification;
  final List<dynamic> completed;

  InvoicesData({
    required this.incomplete,
    required this.pendingVerification,
    required this.completed,
  });

  factory InvoicesData.fromJson(Map<String, dynamic> json) {
    return InvoicesData(
      incomplete: json['incomplete'] as List? ?? [],
      pendingVerification: json['pending_verification'] as List? ?? [],
      completed: json['completed'] as List? ?? [],
    );
  }
}

// Coupons Data
class CouponsData {
  final List<CouponItem> referral;
  final List<CouponItem> general;

  CouponsData({required this.referral, required this.general});

  factory CouponsData.fromJson(Map<String, dynamic> json) {
    return CouponsData(
      referral:
          json['referral'] != null
              ? (json['referral'] as List)
                  .map((e) => CouponItem.fromJson(e))
                  .toList()
              : [],
      general:
          json['general'] != null
              ? (json['general'] as List)
                  .map((e) => CouponItem.fromJson(e))
                  .toList()
              : [],
    );
  }
}

class CouponItem {
  final int idCoupon;
  final String code;
  final String name;
  final String discountText;
  final String type;
  final DateTime? grantedAt;
  final DateTime? expiresAt;

  CouponItem({
    required this.idCoupon,
    required this.code,
    required this.name,
    required this.discountText,
    required this.type,
    this.grantedAt,
    this.expiresAt,
  });

  factory CouponItem.fromJson(Map<String, dynamic> json) {
    return CouponItem(
      idCoupon: json['id_coupon'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      discountText: json['discount_text'] as String,
      type: json['type'] as String,
      grantedAt:
          json['granted_at'] != null
              ? DateTime.parse(json['granted_at'])
              : null,
      expiresAt:
          json['expires_at'] != null
              ? DateTime.parse(json['expires_at'])
              : null,
    );
  }
}

// Announcement Data
class AnnouncementData {
  final int id;
  final String title;
  final String body;
  final String type;
  final String typeLabel;
  final String typeColor;
  final bool isRead;

  AnnouncementData({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.typeLabel,
    required this.typeColor,
    required this.isRead,
  });

  factory AnnouncementData.fromJson(Map<String, dynamic> json) {
    return AnnouncementData(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      typeLabel: json['type_label'] as String,
      typeColor: json['type_color'] as String,
      isRead: json['is_read'] as bool,
    );
  }
}

// Chat Room Data
class ChatRoomData {
  final int idRoom;
  final String title;
  final int unreadCount;

  ChatRoomData({
    required this.idRoom,
    required this.title,
    required this.unreadCount,
  });

  factory ChatRoomData.fromJson(Map<String, dynamic> json) {
    return ChatRoomData(
      idRoom: json['id_room'] as int,
      title: json['title'] as String,
      unreadCount: json['unread_count'] as int,
    );
  }
}

// Referral Data
class ReferralData {
  final String myCode;
  final int totalReferrals;
  final int completedReferrals;
  final double totalRewards;

  ReferralData({
    required this.myCode,
    required this.totalReferrals,
    required this.completedReferrals,
    required this.totalRewards,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      myCode: json['my_code'] as String,
      totalReferrals: json['total_referrals'] as int,
      completedReferrals: json['completed_referrals'] as int,
      totalRewards: (json['total_rewards'] as num).toDouble(),
    );
  }
}

// Stats Data
class StatsData {
  final int totalOrders;
  final int completedOrders;
  final String totalSpent;

  StatsData({
    required this.totalOrders,
    required this.completedOrders,
    required this.totalSpent,
  });

  factory StatsData.fromJson(Map<String, dynamic> json) {
    return StatsData(
      totalOrders: json['total_orders'] as int,
      completedOrders: json['completed_orders'] as int,
      totalSpent: json['total_spent'].toString(),
    );
  }
}
