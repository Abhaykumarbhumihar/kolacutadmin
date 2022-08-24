// To parse this JSON data, do
//
//     final addBookingPojo = addBookingPojoFromJson(jsonString);

import 'dart:convert';

AddBookingPojo addBookingPojoFromJson(String str) => AddBookingPojo.fromJson(json.decode(str));

String addBookingPojoToJson(AddBookingPojo data) => json.encode(data.toJson());

class AddBookingPojo {
  AddBookingPojo({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory AddBookingPojo.fromJson(Map<String, dynamic> json) => AddBookingPojo(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
