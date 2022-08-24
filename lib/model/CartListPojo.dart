// To parse this JSON data, do
//
//     final cartListPojo = cartListPojoFromJson(jsonString);

import 'dart:convert';

CartListPojo cartListPojoFromJson(String str) => CartListPojo.fromJson(json.decode(str));

String cartListPojoToJson(CartListPojo data) => json.encode(data.toJson());

class CartListPojo {
  CartListPojo({
    this.status,
    this.message,
    this.slotDetail,
  });

  int? status;
  String? message;
  List<SlotDetail>? slotDetail;

  factory CartListPojo.fromJson(Map<String, dynamic> json) => CartListPojo(
    status: json["status"],
    message: json["message"],
    slotDetail: List<SlotDetail>.from(json["Slot Detail"].map((x) => SlotDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Slot Detail": List<dynamic>.from(slotDetail!.map((x) => x.toJson())),
  };
}

class SlotDetail {
  SlotDetail({
    this.id,
    this.shopId,
    this.userName,
    this.shopName,
    this.userImage,
    this.employeeId,
    this.service,
    this.coupon,
  });

  int? id;
  int? shopId;
  String? userName;
  String? shopName;
  String? userImage;
  int? employeeId;
  List<Service>? service;
  List<Coupon>? coupon;

  factory SlotDetail.fromJson(Map<String, dynamic> json) => SlotDetail(
    id: json["id"],
    shopId: json["shop_id"],
    userName: json["user_name"],
    shopName: json["shop_name"],
    userImage: json["user_image"],
    employeeId: json["employee_id"],
    service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
    coupon: List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "user_name": userName,
    "shop_name": shopName,
    "user_image": userImage,
    "employee_id": employeeId,
    "service": List<dynamic>.from(service!.map((x) => x.toJson())),
    "coupon": List<dynamic>.from(coupon!.map((x) => x.toJson())),
  };
}

class Coupon {
  Coupon({
    this.id,
    this.couponName,
    this.price,
    this.couponCode,
  });

  int? id;
  String? couponName;
  String? price;
  String? couponCode;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
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

class Service {
  Service({
    this.id,
    this.name,
    this.price,
    this.time,
  });

  int? id;
  String? name;
  String? price;
  String? time;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "time": time,
  };
}
