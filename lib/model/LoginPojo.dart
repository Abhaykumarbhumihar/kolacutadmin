// To parse this JSON data, do
//
//     final loginPojo = loginPojoFromJson(jsonString);

import 'dart:convert';

LoginPojo loginPojoFromJson(String str) => LoginPojo.fromJson(json.decode(str));

String loginPojoToJson(LoginPojo data) => json.encode(data.toJson());

class LoginPojo {
  LoginPojo({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory LoginPojo.fromJson(Map<String, dynamic> json) => LoginPojo(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhoneNo,
    this.ownerProfileImage,
    this.owerAge,
    this.logo,
    this.adhaarCardFile,
    this.address,
    this.latitude,
    this.longitude,
    this.shopType,
    this.description,
    this.amenties,
    this.timeSlot,
    this.services,
    this.emploeyee,
    this.coupon,
    this.token,
  });

  int id;
  String name;
  String email;
  String ownerName;
  String ownerEmail;
  String ownerPhoneNo;
  String ownerProfileImage;
  int owerAge;
  String logo;
  String adhaarCardFile;
  String address;
  String latitude;
  String longitude;
  String shopType;
  String description;
  String amenties;
  List<TimeSlot> timeSlot;
  List<Service> services;
  List<Emploeyee> emploeyee;
  List<Coupon> coupon;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    ownerName: json["owner_name"],
    ownerEmail: json["owner_email"],
    ownerPhoneNo: json["owner_phone_no"],
    ownerProfileImage: json["owner_profile_image"],
    owerAge: json["ower_age"],
    logo: json["logo"],
    adhaarCardFile: json["adhaar_card_file"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    shopType: json["shop_type"],
    description: json["description"],
    amenties: json["amenties"],
    timeSlot: List<TimeSlot>.from(json["time_slot"].map((x) => TimeSlot.fromJson(x))),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    emploeyee: List<Emploeyee>.from(json["emploeyee"].map((x) => Emploeyee.fromJson(x))),
    coupon: List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "owner_name": ownerName,
    "owner_email": ownerEmail,
    "owner_phone_no": ownerPhoneNo,
    "owner_profile_image": ownerProfileImage,
    "ower_age": owerAge,
    "logo": logo,
    "adhaar_card_file": adhaarCardFile,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "shop_type": shopType,
    "description": description,
    "amenties": amenties,
    "time_slot": List<dynamic>.from(timeSlot.map((x) => x.toJson())),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "emploeyee": List<dynamic>.from(emploeyee.map((x) => x.toJson())),
    "coupon": List<dynamic>.from(coupon.map((x) => x.toJson())),
    "token": token,
  };
}

class Coupon {
  Coupon({
    this.id,
    this.couponName,
    this.price,
    this.couponCode,
  });

  int id;
  String couponName;
  String price;
  String couponCode;

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

class Emploeyee {
  Emploeyee({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.skills,
    this.isDuty,
    this.profileImage,
    this.experience,
  });

  int id;
  String name;
  String email;
  String phone;
  List<String> skills;
  String isDuty;
  String profileImage;
  String experience;

  factory Emploeyee.fromJson(Map<String, dynamic> json) => Emploeyee(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    isDuty: json["is_duty"],
    profileImage: json["profile_image"],
    experience: json["experience"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "is_duty": isDuty,
    "profile_image": profileImage,
    "experience": experience,
  };
}

class Service {
  Service({
    this.serviceId,
    this.serviceTitle,
    this.serviceImage,
  });

  int serviceId;
  String serviceTitle;
  String serviceImage;

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

class TimeSlot {
  TimeSlot({
    this.slotType,
    this.openingTime,
    this.closingTime,
    this.slotDuration,
    this.slotDays,
  });

  String slotType;
  String openingTime;
  String closingTime;
  String slotDuration;
  List<String> slotDays;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    slotType: json["slot_type"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    slotDuration: json["slot_duration"],
    slotDays: List<String>.from(json["slot_days"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "slot_type": slotType,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "slot_duration": slotDuration,
    "slot_days": List<dynamic>.from(slotDays.map((x) => x)),
  };
}
