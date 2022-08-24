// To parse this JSON data, do
//
//     final adminCouponPojo = adminCouponPojoFromJson(jsonString);

import 'dart:convert';

AdminCouponPojo adminCouponPojoFromJson(String str) => AdminCouponPojo.fromJson(json.decode(str));

String adminCouponPojoToJson(AdminCouponPojo data) => json.encode(data.toJson());

class AdminCouponPojo {
  AdminCouponPojo({
    this.status,
    this.message,
    this.couponDetail,
  });

  int? status;
  String? message;
  List<CouponDetail>? couponDetail;

  factory AdminCouponPojo.fromJson(Map<String, dynamic> json) => AdminCouponPojo(
    status: json["status"],
    message: json["message"],
    couponDetail: List<CouponDetail>.from(json["Coupon Detail"].map((x) => CouponDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Coupon Detail": List<dynamic>.from(couponDetail!.map((x) => x.toJson())),
  };
}

class CouponDetail {
  CouponDetail({
    this.id,
    this.couponName,
    this.price,
    this.couponCode,
  });

  int? id;
  String? couponName;
  String? price;
  String? couponCode;

  factory CouponDetail.fromJson(Map<String, dynamic> json) => CouponDetail(
    id: json["id"],
    couponName: json["coupon_name"],
    price: json["price"],
    couponCode: json["coupon_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coupon_name": couponName,
    "price": price,
    "coupon_code": couponCode,
  };
}
