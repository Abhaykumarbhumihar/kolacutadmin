// To parse this JSON data, do
//
//     final adminServicePojo = adminServicePojoFromJson(jsonString);

import 'dart:convert';

AdminServicePojo adminServicePojoFromJson(String str) => AdminServicePojo.fromJson(json.decode(str));

String adminServicePojoToJson(AdminServicePojo data) => json.encode(data.toJson());

class AdminServicePojo {
  AdminServicePojo({
    this.status,
    this.message,
    this.serviceDetail,
  });

  int status;
  String message;
  List<ServiceDetail> serviceDetail;

  factory AdminServicePojo.fromJson(Map<String, dynamic> json) => AdminServicePojo(
    status: json["status"],
    message: json["message"],
    serviceDetail: List<ServiceDetail>.from(json["Service Detail"].map((x) => ServiceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Service Detail": List<dynamic>.from(serviceDetail.map((x) => x.toJson())),
  };
}

class ServiceDetail {
  ServiceDetail({
    this.serviceId,
    this.serviceTitle,
    this.serviceImage,
    this.services,
  });

  int serviceId;
  String serviceTitle;
  String serviceImage;
  List<Service> services;

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
    serviceId: json["service_id"],
    serviceTitle: json["service_title"],
    serviceImage: json["service_image"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "service_title": serviceTitle,
    "service_image": serviceImage,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    this.id,
    this.name,
    this.price,
  });

  int id;
  String name;
  String price;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };
}
