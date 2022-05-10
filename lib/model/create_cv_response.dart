// class for storing, accessing, and converting data received from a request to create a cv

import 'dart:convert';

CreateCvResponse createCvResponseFromJson(String str) => CreateCvResponse.fromJson(json.decode(str));

String createCvResponseToJson(CreateCvResponse data) => json.encode(data.toJson());

class CreateCvResponse {
    CreateCvResponse({
        this.code,
        this.message,
    });

    String? code;
    String? message;

    factory CreateCvResponse.fromJson(Map<String, dynamic> json) => CreateCvResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
    };
}
