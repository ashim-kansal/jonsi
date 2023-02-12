// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) => AddOrderResponse.fromJson(json.decode(str));

String addOrderResponseToJson(AddOrderResponse data) => json.encode(data.toJson());

class AddOrderResponse {
    AddOrderResponse({
        required this.status,
        required this.message,
    });

    bool status;
    String message;

    factory AddOrderResponse.fromJson(Map<String, dynamic> json) => AddOrderResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
