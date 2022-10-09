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
    this.feedback,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  List<String>? skills;
  String? isDuty;
  String? address;
  int? status;
  String? experience;
  List<LeaveManagement>? leaveManagement;
  List<Feedback>? feedback;

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
    feedback: List<Feedback>.from(json["feedback"].map((x) => Feedback.fromJson(x))),
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
    "feedback": List<dynamic>.from(feedback!.map((x) => x.toJson())),
  };
}

class Feedback {
  Feedback({
    this.id,
    this.rating,
    this.comment,
    this.user_name,
    this.date
  });

  int? id;
  int? rating;
  String? comment;
  String? user_name;
  String?date;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
    user_name: json["user_name"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
    "user_name":user_name,
    "date":date

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
    holidayReason: json["holiday_reason"],
    startFrom: json["start_from"],
    endFrom: json["end_from"],
  );

  Map<String, dynamic> toJson() => {
    "leave_date": leaveDate,
    "holiday_type": holidayType,
    "holiday_reason":holidayReason,
    "start_from": startFrom,
    "end_from":endFrom,
  };
}

// enum EndFrom { THE_0100, EMPTY }
//
// final endFromValues = EnumValues({
//   "": EndFrom.EMPTY,
//   "01:00": EndFrom.THE_0100
// });
//
// enum HolidayReason { URGENT_WORK_AT_HOME, WEEKEND, FESTIVAL, LOCKDOWN, NATIONAL_HOLIDAY }
//
// final holidayReasonValues = EnumValues({
//   "Festival": HolidayReason.FESTIVAL,
//   "Lockdown": HolidayReason.LOCKDOWN,
//   "National Holiday": HolidayReason.NATIONAL_HOLIDAY,
//   "urgent work at home": HolidayReason.URGENT_WORK_AT_HOME,
//   "Weekend": HolidayReason.WEEKEND
// });
//
// enum HolidayType { PARTIALY_OFF, NATIONAL_HOLIDAY, FESTIVAL, FULLY_OFF, PARTIAL_OFF }
//
// final holidayTypeValues = EnumValues({
//   "Festival": HolidayType.FESTIVAL,
//   "Fully off": HolidayType.FULLY_OFF,
//   "National Holiday": HolidayType.NATIONAL_HOLIDAY,
//   "partialy_off": HolidayType.PARTIALY_OFF,
//   "Partial off": HolidayType.PARTIAL_OFF
// });
//
// enum StartFrom { THE_1000, EMPTY }
//
// final startFromValues = EnumValues({
//   "": StartFrom.EMPTY,
//   "10:00": StartFrom.THE_1000
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
