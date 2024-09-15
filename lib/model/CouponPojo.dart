// To parse this JSON data, do
//
//     final couponPojo = couponPojoFromJson(jsonString);

import 'dart:convert';

CouponPojo couponPojoFromJson(String str) => CouponPojo.fromJson(json.decode(str));

String couponPojoToJson(CouponPojo data) => json.encode(data.toJson());

class CouponPojo {
  CouponPojo({
    this.status,
    this.message,
    this.staffDetail,
  });

  int status;
  String message;
  List<StaffDetail> staffDetail;

  factory CouponPojo.fromJson(Map<String, dynamic> json) => CouponPojo(
    status: json["status"],
    message: json["message"],
    staffDetail: List<StaffDetail>.from(json["Staff Detail"].map((x) => StaffDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Staff Detail": List<dynamic>.from(staffDetail.map((x) => x.toJson())),
  };
}

class StaffDetail {
  StaffDetail({
    this.id,
    this.couponName,
    this.price,
    this.couponCode,
    this.percentage
  });

  int id;
  String couponName;
  String percentage;
  String price;
  String couponCode;

  factory StaffDetail.fromJson(Map<String, dynamic> json) => StaffDetail(
    id: json["id"],
    couponName: json["coupon_name"],
    price: json["price"],
    couponCode: json["coupon_code"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coupon_name": couponName,
    "price": price,
    "coupon_code": couponCode,
    "percentage": percentage,
  };
}
