// To parse this JSON data, do
//
//     final addCouponPojo = addCouponPojoFromJson(jsonString);

import 'dart:convert';

AddCouponPojo addCouponPojoFromJson(String str) => AddCouponPojo.fromJson(json.decode(str));

String addCouponPojoToJson(AddCouponPojo data) => json.encode(data.toJson());

class AddCouponPojo {
  AddCouponPojo({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory AddCouponPojo.fromJson(Map<String, dynamic> json) => AddCouponPojo(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
