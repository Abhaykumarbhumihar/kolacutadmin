// To parse this JSON data, do
//
//     final deleteCoupon = deleteCouponFromJson(jsonString);

import 'dart:convert';

DeleteCoupon deleteCouponFromJson(String str) => DeleteCoupon.fromJson(json.decode(str));

String deleteCouponToJson(DeleteCoupon data) => json.encode(data.toJson());

class DeleteCoupon {
  DeleteCoupon({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory DeleteCoupon.fromJson(Map<String, dynamic> json) => DeleteCoupon(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
