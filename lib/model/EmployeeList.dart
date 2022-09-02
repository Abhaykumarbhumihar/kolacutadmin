// To parse this JSON data, do
//
//     final employeeList = employeeListFromJson(jsonString);

import 'dart:convert';

EmployeeList employeeListFromJson(String str) =>
    EmployeeList.fromJson(json.decode(str));

String employeeListToJson(EmployeeList data) => json.encode(data.toJson());

class EmployeeList {
  EmployeeList({
    this.status,
    this.message,
    this.staffDetail,
  });

  int? status;
  String? message;
  List<StaffDetail>? staffDetail;

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
        status: json["status"],
        message: json["message"],
        staffDetail: List<StaffDetail>.from(
            json["Staff Detail"].map((x) => StaffDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Staff Detail": List<dynamic>.from(staffDetail!.map((x) => x.toJson())),
      };
}

class StaffDetail {
  StaffDetail({
    this.id,
    this.name,
    this.profile_image,
    this.email,
    this.phone,
    this.skills,
    this.isDuty,
    this.experience,
    this.rating
  });

  int? id;
  String? name;
  String? profile_image;
  String? email;
  String? phone;
  List<String>? skills;
  String? isDuty;
  String? experience;
  int? rating;

  factory StaffDetail.fromJson(Map<String, dynamic> json) => StaffDetail(
        id: json["id"],
        name: json["name"],
    profile_image: json["profile_image"],
    email: json["email"],
    rating: json["rating"],
        phone: json["phone"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        isDuty: json["is_duty"],
        experience: json["experience"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rating": rating,
        "email": email,
        "phone": phone,
        "skills": List<dynamic>.from(skills!.map((x) => x)),
        "is_duty": isDuty,
        "experience": experience,
      };
}
