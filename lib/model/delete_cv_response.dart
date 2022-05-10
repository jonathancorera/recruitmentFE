
import 'dart:convert';

// class for storing, accessing, and converting data received from a request to delete a cv


DeleteCvResponse deleteCvResponseFromJson(String str) => DeleteCvResponse.fromJson(json.decode(str));

String deleteCvResponseToJson(DeleteCvResponse data) => json.encode(data.toJson());

class DeleteCvResponse {
    DeleteCvResponse({
        this.code,
        this.message,
    });

    String? code;
    String? message;

    factory DeleteCvResponse.fromJson(Map<String, dynamic> json) => DeleteCvResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
    };
}
