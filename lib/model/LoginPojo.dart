// To parse this JSON data, do
//
//     final loginPojo = loginPojoFromJson(jsonString);

import 'dart:convert';

LoginPojo loginPojoFromJson(String str) => LoginPojo.fromJson(json.decode(str));

String loginPojoToJson(LoginPojo data) => json.encode(data.toJson());

class LoginPojo {
  LoginPojo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory LoginPojo.fromJson(Map<String, dynamic> json) => LoginPojo(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.skills,
    this.address,
    this.leaveManagement,
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  List<String>? skills;
  String? address;
  List<LeaveManagement>? leaveManagement;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        address: json["address"],
        leaveManagement: List<LeaveManagement>.from(
            json["leave_management"].map((x) => LeaveManagement.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "skills": List<dynamic>.from(skills!.map((x) => x)),
        "address": address,
        "leave_management":
            List<dynamic>.from(leaveManagement!.map((x) => x.toJson())),
        "token": token,
      };
}

class LeaveManagement {
  LeaveManagement({
    this.leaveDate,
    this.holidayType,
    this.holidayReason,
  });

  String? leaveDate;
  String? holidayType;
  String? holidayReason;

  factory LeaveManagement.fromJson(Map<String, dynamic> json) =>
      LeaveManagement(
        leaveDate: json["leave_date"],
        holidayType: json["holiday_type"],
        holidayReason: json["holiday_reason"],
      );

  Map<String, dynamic> toJson() => {
        "leave_date": leaveDate,
        "holiday_type": holidayType,
        "holiday_reason": holidayReason,
      };
}
