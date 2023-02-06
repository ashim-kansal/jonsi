// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    CategoryResponse({
        required this.status,
        required this.data,
        required this.baseUrl,
    });

    bool status;
    String baseUrl;
    List<Category> data;

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        status: json["status"],
        baseUrl: json["base_url"],
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "base_url": baseUrl,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.image,
    });

    int id;
    String name;
    String createdAt;
    String image;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "image": image,
    };
}
