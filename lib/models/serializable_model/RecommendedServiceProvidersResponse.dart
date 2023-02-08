// To parse this JSON data, do
//
//     final recommendedServiceProvidersResponse = recommendedServiceProvidersResponseFromJson(jsonString);

import 'dart:convert';

List<RecommendedServiceProvidersResponse> recommendedServiceProvidersResponseFromJson(String str) => List<RecommendedServiceProvidersResponse>.from(json.decode(str).map((x) => RecommendedServiceProvidersResponse.fromJson(x)));

String recommendedServiceProvidersResponseToJson(List<RecommendedServiceProvidersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecommendedServiceProvidersResponse {
    RecommendedServiceProvidersResponse({
        required this.id,
        required this.title,
        this.description,
        required this.isPaused,
        required this.createdAt,
        required this.updatedAt,
        required this.categoryId,
        this.userId,
        required this.isDeleted,
        this.ratingCount,
        this.reviewCount,
        this.slug,
        required this.rating,
        this.userData,
        this.servicepackages,
        this.reviews,
        this.gigdocument,
    });

    int id;
    String title;
    String? description;
    bool isPaused;
    DateTime createdAt;
    DateTime updatedAt;
    int categoryId;
    int? userId;
    bool isDeleted;
    String? ratingCount;
    int? reviewCount;
    String? slug;
    dynamic rating;
    UserData? userData;
    Servicepackages? servicepackages;
    List<Review>? reviews;
    List<Gigdocument>? gigdocument;

    factory RecommendedServiceProvidersResponse.fromJson(Map<String, dynamic> json) => RecommendedServiceProvidersResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isPaused: json["is_paused"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        userId: json["user_id"],
        isDeleted: json["is_deleted"],
        ratingCount: json["rating_count"],
        reviewCount: json["review_count"],
        slug: json["slug"],
        rating: json["rating"],
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
        servicepackages: json["servicepackages"] == null ? null : Servicepackages.fromJson(json["servicepackages"]),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        gigdocument: json["gigdocument"] == null ? [] : List<Gigdocument>.from(json["gigdocument"]!.map((x) => Gigdocument.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_paused": isPaused,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_id": categoryId,
        "user_id": userId,
        "is_deleted": isDeleted,
        "rating_count": ratingCount,
        "review_count": reviewCount,
        "slug": slug,
        "rating": rating,
        "user_data": userData?.toJson(),
        "servicepackages": servicepackages?.toJson(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "gigdocument": gigdocument == null ? [] : List<dynamic>.from(gigdocument!.map((x) => x.toJson())),
    };
}

class Gigdocument {
    Gigdocument({
        required this.id,
        required this.fileName,
        required this.userid,
        required this.serviceid,
        required this.fileType,
    });

    int id;
    String fileName;
    int userid;
    int serviceid;
    String fileType;

    factory Gigdocument.fromJson(Map<String, dynamic> json) => Gigdocument(
        id: json["id"],
        fileName: json["file_name"],
        userid: json["userid"],
        serviceid: json["serviceid"],
        fileType: json["file_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "userid": userid,
        "serviceid": serviceid,
        "file_type": fileType,
    };
}

class Review {
    Review({
        required this.id,
        required this.review,
        required this.rating,
        required this.updatedAt,
        required this.createdAt,
        required this.reviewerId,
        required this.serviceId,
        required this.bookingId,
        required this.slug,
    });

    int id;
    String review;
    String rating;
    DateTime updatedAt;
    DateTime createdAt;
    int reviewerId;
    int serviceId;
    int bookingId;
    String slug;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        review: json["review"],
        rating: json["rating"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        reviewerId: json["reviewer_id"],
        serviceId: json["service_id"],
        bookingId: json["booking_id"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "rating": rating,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "reviewer_id": reviewerId,
        "service_id": serviceId,
        "booking_id": bookingId,
        "slug": slug,
    };
}

class Servicepackages {
    Servicepackages({
        required this.id,
        required this.title,
        this.description,
        this.location,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
        required this.serviceId,
        this.time,
        this.extraForUrgentNeed,
    });

    int id;
    String title;
    String? description;
    Location? location;
    String price;
    DateTime createdAt;
    DateTime updatedAt;
    int serviceId;
    String? time;
    int? extraForUrgentNeed;

    factory Servicepackages.fromJson(Map<String, dynamic> json) => Servicepackages(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: locationValues.map[json["location"]]!,
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        serviceId: json["service_id"],
        time: json["time"],
        extraForUrgentNeed: json["extra_for_urgent_need"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": locationValues.reverse[location],
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service_id": serviceId,
        "time": time,
        "extra_for_urgent_need": extraForUrgentNeed,
    };
}

enum Location { NATIONALITY, LOCATION_NATIONALITY, TAXILA }

final locationValues = EnumValues({
    "nationality": Location.LOCATION_NATIONALITY,
    "Nationality": Location.NATIONALITY,
    "Taxila": Location.TAXILA
});

class UserData {
    UserData({
        required this.isSuperuser,
        required this.isStaff,
        required this.isActive,
        required this.dateJoined,
        required this.id,
        this.firstName,
        this.lastName,
        required this.username,
        required this.email,
        this.phoneNumber,
        this.otpSms,
        this.otpEmail,
        this.otpSmsCreatedAt,
        this.otpEmailCreatedAt,
        required this.isAdmin,
        required this.isProvider,
        required this.updatedAt,
        required this.createdAt,
        this.categoryId,
        this.fcmToken,
        this.address,
        this.about,
        this.nationality,
        this.languages,
        this.profilePic,
        this.gigDoc,
        this.gig2Doc,
        this.activationToken,
        this.socialLoginId,
        this.loginSrc,
    });

    bool isSuperuser;
    bool isStaff;
    bool isActive;
    String dateJoined;
    int id;
    FirstName? firstName;
    LastName? lastName;
    String username;
    String email;
    String? phoneNumber;
    dynamic otpSms;
    dynamic otpEmail;
    dynamic otpSmsCreatedAt;
    dynamic otpEmailCreatedAt;
    bool isAdmin;
    bool isProvider;
    DateTime updatedAt;
    DateTime createdAt;
    int? categoryId;
    dynamic fcmToken;
    dynamic address;
    String? about;
    Location? nationality;
    Languages? languages;
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
        firstName: firstNameValues.map[json["first_name"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        otpSms: json["otp_sms"],
        otpEmail: json["otp_email"],
        otpSmsCreatedAt: json["otp_sms_created_at"],
        otpEmailCreatedAt: json["otp_email_created_at"],
        isAdmin: json["is_admin"],
        isProvider: json["is_provider"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        categoryId: json["category_id"],
        fcmToken: json["fcm_token"],
        address: json["address"],
        about: json["about"],
        nationality: locationValues.map[json["nationality"]]!,
        languages: languagesValues.map[json["languages"]]!,
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
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "otp_sms": otpSms,
        "otp_email": otpEmail,
        "otp_sms_created_at": otpSmsCreatedAt,
        "otp_email_created_at": otpEmailCreatedAt,
        "is_admin": isAdmin,
        "is_provider": isProvider,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "category_id": categoryId,
        "fcm_token": fcmToken,
        "address": address,
        "about": about,
        "nationality": locationValues.reverse[nationality],
        "languages": languagesValues.reverse[languages],
        "profile_pic": profilePic,
        "gig_doc": gigDoc,
        "gig2_doc": gig2Doc,
        "activation_token": activationToken,
        "social_login_id": socialLoginId,
        "login_src": loginSrc,
    };
}

enum FirstName { EMPTY, PARSHANT, RAJA, ROHAN, QASIM }

final firstNameValues = EnumValues({
    "": FirstName.EMPTY,
    "Parshant": FirstName.PARSHANT,
    "Qasim": FirstName.QASIM,
    "Raja": FirstName.RAJA,
    "rohan": FirstName.ROHAN
});

enum Languages { ENGLISH, HINDI, LANGUAGES_ENGLISH }

final languagesValues = EnumValues({
    "English": Languages.ENGLISH,
    "Hindi": Languages.HINDI,
    "english": Languages.LANGUAGES_ENGLISH
});

enum LastName { EMPTY, KUMAR, LAST_NAME_KUMAR, SIDDIQUI }

final lastNameValues = EnumValues({
    "": LastName.EMPTY,
    "Kumar": LastName.KUMAR,
    "kumar": LastName.LAST_NAME_KUMAR,
    "Siddiqui": LastName.SIDDIQUI
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
