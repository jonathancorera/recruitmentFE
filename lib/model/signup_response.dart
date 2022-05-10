// class for storing, accessing, and converting data received from a request to create a user account

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
    SignUpResponse({
        this.code,
        this.message,
    });

    String? code;
    String? message;

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
    };
}
