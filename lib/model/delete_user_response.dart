
import 'dart:convert';

// class for storing, accessing, and converting data received from a request to delete a user


DeleteUserResponse deleteUserResponseFromJson(String str) => DeleteUserResponse.fromJson(json.decode(str));

String deleteUserResponseToJson(DeleteUserResponse data) => json.encode(data.toJson());

class DeleteUserResponse {
    DeleteUserResponse({
        this.code,
        this.message,
    });

    String? code;
    String? message;

    factory DeleteUserResponse.fromJson(Map<String, dynamic> json) => DeleteUserResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
    };
}