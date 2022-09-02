// To parse this JSON data, do
//
//     final dashboardPojo = dashboardPojoFromJson(jsonString);

import 'dart:convert';

DashboardPojo dashboardPojoFromJson(String str) => DashboardPojo.fromJson(json.decode(str));

String dashboardPojoToJson(DashboardPojo data) => json.encode(data.toJson());

class DashboardPojo {
  DashboardPojo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory DashboardPojo.fromJson(Map<String, dynamic> json) => DashboardPojo(
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
    this.staffAccount,
    this.totalBooking,
    this.openBooking,
    this.totalRevenue,
    this.completed_booking
  });

  int? staffAccount;
  int? totalBooking;
  int? openBooking;
  int? totalRevenue;
  int ? completed_booking;
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    staffAccount: json["staff_account"],
    totalBooking: json["total_booking"],
    openBooking: json["open_booking"],
    totalRevenue: json["total_revenue"],
    completed_booking: json["completed_booking"],
  );

  Map<String, dynamic> toJson() => {
    "staff_account": staffAccount,
    "total_booking": totalBooking,
    "open_booking": openBooking,
    "total_revenue": totalRevenue,
    "completed_booking": completed_booking,
  };
}
