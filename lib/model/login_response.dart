// class for storing, accessing, and converting data received from a request to log into the system

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.jwttoken,
        this.userName,
        this.roles,
        this.message,
    });

    String? jwttoken;
    String? userName;
    List<Role>? roles;
    String? message;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        jwttoken: json["jwttoken"] == null ? null : json["jwttoken"],
        userName: json["userName"] == null ? null : json["userName"],
        roles: json["roles"] == null ? null : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "jwttoken": jwttoken == null ? null : jwttoken,
        "userName": userName == null ? null : userName,
        "roles": roles == null ? null : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "message": message == null ? null : message,
    };
}

class Role {
    Role({
        this.id,
        this.name,
        this.description,
    });

    int? id;
    String? name;
    String? description;

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
    };
}
