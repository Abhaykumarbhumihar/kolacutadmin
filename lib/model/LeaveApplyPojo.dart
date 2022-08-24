// To parse this JSON data, do
//
//     final leaveApplyPojo = leaveApplyPojoFromJson(jsonString);

import 'dart:convert';

LeaveApplyPojo leaveApplyPojoFromJson(String str) => LeaveApplyPojo.fromJson(json.decode(str));

String leaveApplyPojoToJson(LeaveApplyPojo data) => json.encode(data.toJson());

class LeaveApplyPojo {
  LeaveApplyPojo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory LeaveApplyPojo.fromJson(Map<String, dynamic> json) => LeaveApplyPojo(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.leaveDate,
    this.holidayType,
    this.holidayReason,
    this.startFrom,
    this.endFrom,
    this.calenderDate,
  });

  String? leaveDate;
  String? holidayType;
  String? holidayReason;
  String? startFrom;
  String? endFrom;
  DateTime? calenderDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    leaveDate: json["leave_date"],
    holidayType: json["holiday_type"],
    holidayReason: json["holiday_reason"],
    startFrom: json["start_from"],
    endFrom: json["end_from"],
    calenderDate: DateTime.parse(json["calender_date"]),
  );

  Map<String, dynamic> toJson() => {
    "leave_date": leaveDate,
    "holiday_type": holidayType,
    "holiday_reason": holidayReason,
    "start_from": startFrom,
    "end_from": endFrom,
    "calender_date": "${calenderDate!.year.toString().padLeft(4, '0')}-${calenderDate!.month.toString().padLeft(2, '0')}-${calenderDate!.day.toString().padLeft(2, '0')}",
  };
}
