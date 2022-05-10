import 'dart:convert';

// generic class for holding a CV object


CV cvFromJson(String str) => CV.fromJson(json.decode(str));

String cvToJson(CV data) => json.encode(data.toJson());

class CV {
    CV({
        this.address,
        this.contactNo,
        this.creationDate,
        this.noOfGCSEpasses,
        this.experiences,
        this.jobSector,
        this.qualifications,
        this.skills,
    });

    Address? address;
    String? contactNo;
    DateTime? creationDate;
    int? noOfGCSEpasses;
    List<Experience>? experiences;
    String? jobSector;
    List<Qualification>? qualifications;
    List<Skill>? skills;

    factory CV.fromJson(Map<String, dynamic> json) => CV(
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        contactNo: json["contactNo"] == null ? null : json["contactNo"],
        creationDate: json["creationDate"] == null ? null : DateTime.parse(json["creationDate"]),
        noOfGCSEpasses: json["noOfGCSEpasses"] == null ? null : json["noOfGCSEpasses"],
        experiences: json["experiences"] == null ? null : List<Experience>.from(json["experiences"].map((x) => Experience.fromJson(x))),
        jobSector: json["jobSector"] == null ? null : json["jobSector"],
        qualifications: json["qualifications"] == null ? null : List<Qualification>.from(json["qualifications"].map((x) => Qualification.fromJson(x))),
        skills: json["skills"] == null ? null : List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address!.toJson(),
        "contactNo": contactNo == null ? null : contactNo,
        "creationDate": creationDate == null ? null : creationDate!.toIso8601String(),
        "noOfGCSEpasses": noOfGCSEpasses == null ? null : noOfGCSEpasses,
        "experiences": experiences == null ? null : List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "jobSector": jobSector == null ? null : jobSector,
        "qualifications": qualifications == null ? null : List<dynamic>.from(qualifications!.map((x) => x.toJson())),
        "skills": skills == null ? null : List<dynamic>.from(skills!.map((x) => x.toJson())),
    };
}

class Address {
    Address({
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
    });

    String? addressLine1;
    String? addressLine2;
    String? city;
    String? state;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"] == null ? null : json["addressLine1"],
        addressLine2: json["addressLine2"] == null ? null : json["addressLine2"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
    );

    Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1 == null ? null : addressLine1,
        "addressLine2": addressLine2 == null ? null : addressLine2,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
    };
}

class Experience {
    Experience({
        this.id,
        this.companyName,
        this.endDate,
        this.experienceType,
        this.role,
        this.startDate,
    });

    int? id;
    String? companyName;
    DateTime? endDate;
    String? experienceType;
    String? role;
    DateTime? startDate;

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"] == null ? null : json["id"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        experienceType: json["experienceType"] == null ? null : json["experienceType"],
        role: json["role"] == null ? null : json["role"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "companyName": companyName == null ? null : companyName,
        "endDate": endDate == null ? null : endDate!.toIso8601String(),
        "experienceType": experienceType == null ? null : experienceType,
        "role": role == null ? null : role,
        "startDate": startDate == null ? null : startDate!.toIso8601String(),
    };
}

class Qualification {
    Qualification({
        this.id,
        this.expiryDate,
        this.qualificationDate,
        this.qualificationName,
        this.qualificationType,
        this.qualificationLevel,
    });

    int? id;
    DateTime? expiryDate;
    DateTime? qualificationDate;
    String? qualificationName;
    int? qualificationLevel;
    String? qualificationType;

    factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        id: json["id"] == null ? null : json["id"],
        expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
        qualificationDate: json["qualificationDate"] == null ? null : DateTime.parse(json["qualificationDate"]),
        qualificationName: json["qualificationName"] == null ? null : json["qualificationName"],
    qualificationLevel: json["qualificationLevel"] == null ? null : json["qualificationLevel"],
        qualificationType: json["qualificationType"] == null ? null : json["qualificationType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "expiryDate": expiryDate == null ? null : expiryDate!.toIso8601String(),
        "qualificationDate": qualificationDate == null ? null : qualificationDate!.toIso8601String(),
        "qualificationName": qualificationName == null ? null : qualificationName,
        "qualificationType": qualificationType == null ? null : qualificationType,
        "qualificationLevel": qualificationLevel == null ? null : qualificationLevel,
    };
}

class Skill {
    Skill({
        this.id,
        this.skillName,
        this.skillType,
    });

    int? id;
    String? skillName;
    String? skillType;

    factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"] == null ? null : json["id"],
        skillName: json["skillName"] == null ? null : json["skillName"],
        skillType: json["skillType"] == null ? null : json["skillType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "skillName": skillName == null ? null : skillName,
        "skillType": skillType == null ? null : skillType,
    };
}
