// To parse this JSON data, do
//
//     final popularServiceListResponse = popularServiceListResponseFromJson(jsonString);

import 'dart:convert';

List<PopularServiceListResponse> popularServiceListResponseFromJson(String str) => List<PopularServiceListResponse>.from(json.decode(str).map((x) => PopularServiceListResponse.fromJson(x)));

String popularServiceListResponseToJson(List<PopularServiceListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularServiceListResponse {
    PopularServiceListResponse({
        this.id,
        this.name,
        this.image,
        this.count,
    });

    int? id;
    String? name;
    String? image;
    int? count;

    factory PopularServiceListResponse.fromJson(Map<String, dynamic> json) => PopularServiceListResponse(
        id: json["id"],
        name: json["name"],
        image: json["image"]!,
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "count": count,
    };
}
