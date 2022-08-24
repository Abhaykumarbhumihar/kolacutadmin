// To parse this JSON data, do
//
//     final shopLIstPojo = shopLIstPojoFromJson(jsonString);

import 'dart:convert';

ShopLIstPojo shopLIstPojoFromJson(String str) =>
    ShopLIstPojo.fromJson(json.decode(str));

String shopLIstPojoToJson(ShopLIstPojo data) => json.encode(data.toJson());

class ShopLIstPojo {
  ShopLIstPojo({
    this.status,
    this.message,
    this.staffDetail,
  });

  int? status;
  String? message;
  List<StaffDetail>? staffDetail;

  factory ShopLIstPojo.fromJson(Map<String, dynamic> json) => ShopLIstPojo(
        status: json["status"],
        message: json["message"],
        staffDetail: List<StaffDetail>.from(
            json["Staff Detail"].map((x) => StaffDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Staff Detail": List<dynamic>.from(staffDetail!.map((x) => x.toJson())),
      };
}

class StaffDetail {
  StaffDetail({
    this.shopId,
    this.shopName,
    this.location,
    this.latitude,
    this.longitude,
    this.shopLogo,
    this.service,
  });

  int? shopId;
  String? shopName;
  String? location;
  String? latitude;
  String? longitude;
  String? shopLogo;
  List<Service>? service;

  factory StaffDetail.fromJson(Map<String, dynamic> json) => StaffDetail(
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        shopLogo: json["shop_logo"],
        service:
            List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shop_id": shopId,
        "shop_name": shopName,
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
