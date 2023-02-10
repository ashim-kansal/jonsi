// To parse this JSON data, do
//
//     final recommendedServiceProvidersResponse = recommendedServiceProvidersResponseFromJson(jsonString);

import 'dart:convert';

List<RecommendedServiceProvidersResponse> recommendedServiceProvidersResponseFromJson(String str) => List<RecommendedServiceProvidersResponse>.from(json.decode(str).map((x) => RecommendedServiceProvidersResponse.fromJson(x)));

String recommendedServiceProvidersResponseToJson(List<RecommendedServiceProvidersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecommendedServiceProvidersResponse {
    RecommendedServiceProvidersResponse({
        this.id,
        this.title,
        this.description,
        this.isPaused,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.userId,
        this.isDeleted,
        this.ratingCount,
        this.reviewCount,
        this.slug,
        this.rating,
        // this.userData,
        this.servicepackages,
    });

    int? id;
    String? title;
    String? description;
    bool? isPaused;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? categoryId;
    int? userId;
    bool? isDeleted;
    dynamic ratingCount;
    dynamic reviewCount;
    String? slug;
    int? rating;
    // UserData? userData;
    Servicepackages? servicepackages;

    factory RecommendedServiceProvidersResponse.fromJson(Map<String, dynamic> json) => RecommendedServiceProvidersResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isPaused: json["is_paused"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        userId: json["user_id"],
        isDeleted: json["is_deleted"],
        ratingCount: json["rating_count"] == null ? 0 : json["rating_count"],
        reviewCount: json["review_count"]== null ? 0 : json["review_count"],
        slug: json["slug"],
        rating: json["rating"],
        // userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
        servicepackages: json["servicepackages"] == null ? null : Servicepackages.fromJson(json["servicepackages"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_paused": isPaused,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category_id": categoryId,
        "user_id": userId,
        "is_deleted": isDeleted,
        "rating_count": ratingCount,
        "review_count": reviewCount,
        "slug": slug,
        "rating": rating,
        // "user_data": userData?.toJson(),
        "servicepackages": servicepackages?.toJson(),
    };
}

class Servicepackages {
    Servicepackages({
        this.id,
        this.title,
        this.description,
        this.location,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.serviceId,
        // this.time,
        this.extraForUrgentNeed,
    });

    int? id;
    String? title;
    String? description;
    String? location;
    String? price;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? serviceId;
    // dynamic? time;
    int? extraForUrgentNeed;

    factory Servicepackages.fromJson(Map<String, dynamic> json) => Servicepackages(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        price: json["price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        serviceId: json["service_id"],
        // time: json["time"],
        extraForUrgentNeed: json["extra_for_urgent_need"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service_id": serviceId,
        // "time": time,
        "extra_for_urgent_need": extraForUrgentNeed,
    };
}

class UserData {
    UserData({
        this.isSuperuser,
        this.isStaff,
        this.isActive,
        this.dateJoined,
        this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.phoneNumber,
        this.otpSms,
        this.otpEmail,
        this.otpSmsCreatedAt,
        this.otpEmailCreatedAt,
        this.isAdmin,
        this.isProvider,
        this.updatedAt,
        this.createdAt,
        this.categoryId,
        this.fcmToken,
        this.address,
        this.about,
        // this.nationality,
        // this.languages,
        this.profilePic,
        this.gigDoc,
        this.gig2Doc,
        this.activationToken,
        this.socialLoginId,
        this.loginSrc,
    });

    bool? isSuperuser;
    bool? isStaff;
    bool? isActive;
    String? dateJoined;
    int? id;
    String? firstName;
    String? lastName;
    String? username;
    String? email;
    String? phoneNumber;
    dynamic otpSms;
    dynamic otpEmail;
    dynamic otpSmsCreatedAt;
    dynamic otpEmailCreatedAt;
    bool? isAdmin;
    bool? isProvider;
    DateTime? updatedAt;
    DateTime? createdAt;
    dynamic categoryId;
    dynamic fcmToken;
    dynamic address;
    String? about;
    // Location? nationality;
    // Languages? languages;
    String? profilePic;
    String? gigDoc;
    String? gig2Doc;
    String? activationToken;
    dynamic socialLoginId;
    dynamic loginSrc;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        isSuperuser: json["is_superuser"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: json["date_joined"],
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        otpSms: json["otp_sms"],
        otpEmail: json["otp_email"],
        otpSmsCreatedAt: json["otp_sms_created_at"],
        otpEmailCreatedAt: json["otp_email_created_at"],
        isAdmin: json["is_admin"],
        isProvider: json["is_provider"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        categoryId: json["category_id"],
        fcmToken: json["fcm_token"],
        address: json["address"],
        about: json["about"],
        // nationality: locationValues.map[json["nationality"]]!,
        // languages: languagesValues.map[json["languages"]]!,
        profilePic: json["profile_pic"],
        gigDoc: json["gig_doc"],
        gig2Doc: json["gig2_doc"],
        activationToken: json["activation_token"],
        socialLoginId: json["social_login_id"],
        loginSrc: json["login_src"],
    );

    Map<String, dynamic> toJson() => {
        "is_superuser": isSuperuser,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined,
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "otp_sms": otpSms,
        "otp_email": otpEmail,
        "otp_sms_created_at": otpSmsCreatedAt,
        "otp_email_created_at": otpEmailCreatedAt,
        "is_admin": isAdmin,
        "is_provider": isProvider,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "category_id": categoryId,
        "fcm_token": fcmToken,
        "address": address,
        "about": about,
        // "nationality": locationValues.reverse[nationality],
        // "languages": languagesValues.reverse[languages],
        "profile_pic": profilePic,
        "gig_doc": gigDoc,
        "gig2_doc": gig2Doc,
        "activation_token": activationToken,
        "social_login_id": socialLoginId,
        "login_src": loginSrc,
    };
}

enum Languages { ENGLISH, HINDI, LANGUAGES_ENGLISH }

final languagesValues = EnumValues({
    "English": Languages.ENGLISH,
    "Hindi": Languages.HINDI,
    "english": Languages.LANGUAGES_ENGLISH
});


class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
