// generic class for holding a User object

import 'dart:convert';

import 'cv.dart';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.password,
        this.hiredBy,
        this.hiredDate,
        this.role,
        this.cv,
        this.active,
        this.hired,
    });

    int? id;
    String? firstName;
    String? lastName;
    String? userName;
    String? password;
    int? hiredBy;
    DateTime? hiredDate;
    Role? role;
    CV? cv;
    bool? active;
    bool? hired;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        userName: json["userName"] == null ? null : json["userName"],
        password: json["password"] == null ? null : json["password"],
        hiredBy: json["hiredBy"] == null ? null : json["hiredBy"],
        hiredDate: json["hiredDate"] == null ? null : DateTime.parse(json["hiredDate"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        cv: json["cv"] == null ? null : CV.fromJson(json["cv"]),
        active: json["active"] == null ? null : json["active"],
        hired: json["hired"] == null ? null : json["hired"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "userName": userName == null ? null : userName,
        "password": password == null ? null : password,
        "hiredBy": hiredBy == null ? null : hiredBy,
        "hiredDate": hiredDate == null ? null : hiredDate!.toIso8601String(),
        "role": role == null ? null : role!.toJson(),
        "cv": cv== null ? null : cv!.toJson(),
        "active": active == null ? null : active,
        "hired": hired == null ? null : hired,
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
