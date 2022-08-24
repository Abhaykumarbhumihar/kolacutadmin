// To parse this JSON data, do
//
//     final wishlistPojo = wishlistPojoFromJson(jsonString);

import 'dart:convert';

WishlistPojo wishlistPojoFromJson(String str) => WishlistPojo.fromJson(json.decode(str));

String wishlistPojoToJson(WishlistPojo data) => json.encode(data.toJson());

class WishlistPojo {
  WishlistPojo({
    this.status,
    this.message,
    this.staffDetail,
  });

  int? status;
  String? message;
  List<StaffDetail>? staffDetail;

  factory WishlistPojo.fromJson(Map<String, dynamic> json) => WishlistPojo(
    status: json["status"],
    message: json["message"],
    staffDetail: List<StaffDetail>.from(json["Staff Detail"].map((x) => StaffDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Staff Detail": List<dynamic>.from(staffDetail!.map((x) => x.toJson())),
  };
}

class StaffDetail {
  StaffDetail({
    this.id,
    this.shopId,
    this.shopName,
    this.userName,
    this.location,
    this.latitude,
    this.longitude,
    this.shopLogo,
    this.service,
  });

  int? id;
  int? shopId;
  String? shopName;
  String? userName;
  String? location;
  String? latitude;
  String? longitude;
  String? shopLogo;
  List<Service>? service;

  factory StaffDetail.fromJson(Map<String, dynamic> json) => StaffDetail(
    id: json["id"],
    shopId: json["shop_id"],
    shopName: json["shop_name"],
    userName: json["user_name"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    shopLogo: json["shop_logo"],
    service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "shop_name": shopName,
    "user_name": userName,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "shop_logo": shopLogo,
    "service": List<dynamic>.from(service!.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    this.serviceId,
    this.serviceTitle,
    this.serviceImage,
  });

  int? serviceId;
  String? serviceTitle;
  String? serviceImage;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceId: json["service_id"],
    serviceTitle: json["service_title"],
    serviceImage: json["service_image"],
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "service_title": serviceTitle,
    "service_image": serviceImage,
  };
}
