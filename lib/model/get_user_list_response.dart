// class for storing, accessing, and converting data received from a request for a list of users

import 'dart:convert';
import 'package:recruitmentclient/model/cv.dart';

GetUserListResponse getUserListResponseFromJson(String str) => GetUserListResponse.fromJson(json.decode(str));

String getUserListResponseToJson(GetUserListResponse data) => json.encode(data.toJson());

class GetUserListResponse {
    GetUserListResponse({
        this.content,
        this.pageable,
        this.totalElements,
        this.totalPages,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.numberOfElements,
        this.first,
        this.empty,
    });

    List<Content>? content;
    String? pageable;
    int? totalElements;
    int? totalPages;
    bool? last;
    int? size;
    int? number;
    Sort? sort;
    int? numberOfElements;
    bool? first;
    bool? empty;

    factory GetUserListResponse.fromJson(Map<String, dynamic> json) => GetUserListResponse(
        content: json["content"] == null ? null : List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: json["pageable"] == null ? null : json["pageable"],
        totalElements: json["totalElements"] == null ? null : json["totalElements"],
        totalPages: json["totalPages"] == null ? null : json["totalPages"],
        last: json["last"] == null ? null : json["last"],
        size: json["size"] == null ? null : json["size"],
        number: json["number"] == null ? null : json["number"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"] == null ? null : json["numberOfElements"],
        first: json["first"] == null ? null : json["first"],
        empty: json["empty"] == null ? null : json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": content == null ? null : List<dynamic>.from(content!.map((x) => x.toJson())),
        "pageable": pageable == null ? null : pageable,
        "totalElements": totalElements == null ? null : totalElements,
        "totalPages": totalPages == null ? null : totalPages,
        "last": last == null ? null : last,
        "size": size == null ? null : size,
        "number": number == null ? null : number,
        "sort": sort == null ? null : sort!.toJson(),
        "numberOfElements": numberOfElements == null ? null : numberOfElements,
        "first": first == null ? null : first,
        "empty": empty == null ? null : empty,
    };
}

class Content {
    Content({
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

    factory Content.fromJson(Map<String, dynamic> json) => Content(
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
        "cv": cv == null ? null : cv!.toJson(),
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

class Sort {
    Sort({
        this.sorted,
        this.unsorted,
        this.empty,
    });

    bool? sorted;
    bool? unsorted;
    bool? empty;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"] == null ? null : json["sorted"],
        unsorted: json["unsorted"] == null ? null : json["unsorted"],
        empty: json["empty"] == null ? null : json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "sorted": sorted == null ? null : sorted,
        "unsorted": unsorted == null ? null : unsorted,
        "empty": empty == null ? null : empty,
    };
}
