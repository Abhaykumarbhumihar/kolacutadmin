// To parse this JSON data, do
//
//     final acceptBookigPojo = acceptBookigPojoFromJson(jsonString);

import 'dart:convert';

AcceptBookigPojo acceptBookigPojoFromJson(String str) => AcceptBookigPojo.fromJson(json.decode(str));

String acceptBookigPojoToJson(AcceptBookigPojo data) => json.encode(data.toJson());

class AcceptBookigPojo {
  AcceptBookigPojo({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory AcceptBookigPojo.fromJson(Map<String, dynamic> json) => AcceptBookigPojo(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
