// To parse this JSON data, do
//
//     final employeeProfilePojo = employeeProfilePojoFromJson(jsonString);

import 'dart:convert';

EmployeeProfilePojo employeeProfilePojoFromJson(String str) => EmployeeProfilePojo.fromJson(json.decode(str));

String employeeProfilePojoToJson(EmployeeProfilePojo data) => json.encode(data.toJson());

class EmployeeProfilePojo {
  EmployeeProfilePojo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory EmployeeProfilePojo.fromJson(Map<String, dynamic> json) => EmployeeProfilePojo(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
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
    this.isDuty,
    this.address,
    this.status,
    this.experience,
    this.leaveManagement,
  });

  int? id;
  String? name;
  String? email;
  int? status;
  String? phone;
  String? image;
  List<String>? skills;
  String? isDuty;
  String? address;
  String? experience;
  List<LeaveManagement>? leaveManagement;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    isDuty: json["is_duty"],
    address: json["address"],
    status: json["status"],
    experience: json["experience"],
    leaveManagement: List<LeaveManagement>.from(json["leave_management"].map((x) => LeaveManagement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "skills": List<dynamic>.from(skills!.map((x) => x)),
    "is_duty": isDuty,
    "address": address,
    "status": status,
    "experience": experience,
    "leave_management": List<dynamic>.from(leaveManagement!.map((x) => x.toJson())),
  };
}

class LeaveManagement {
  LeaveManagement({
    this.leaveDate,
    this.holidayType,
    this.holidayReason,
    this.startFrom,
    this.endFrom,
  });

  String? leaveDate;
  String? holidayType;
  String? holidayReason;
  String? startFrom;
  String? endFrom;

  factory LeaveManagement.fromJson(Map<String, dynamic> json) => LeaveManagement(
    leaveDate: json["leave_date"],
    holidayType:json["holiday_type"],
    holidayReason:json["holiday_reason"],
    startFrom: json["start_from"],
    endFrom: json["end_from"],
  );

  Map<String, dynamic> toJson() => {
    "leave_date": leaveDate,
    "holiday_type": holidayType,
    "holiday_reason":holidayReason,
    "start_from": startFrom,
    "end_from": endFrom,
  };
}





