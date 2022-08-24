// To parse this JSON data, do
//
//     final registerPojo = registerPojoFromJson(jsonString);

import 'dart:convert';

RegisterPojo registerPojoFromJson(String str) => RegisterPojo.fromJson(json.decode(str));

String registerPojoToJson(RegisterPojo data) => json.encode(data.toJson());

class RegisterPojo {
  RegisterPojo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory RegisterPojo.fromJson(Map<String, dynamic> json) => RegisterPojo(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
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
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? ownerName;
  String? ownerEmail;
  String? ownerPhoneNo;
  String? ownerProfileImage;
  int? owerAge;
  String? logo;
  String? adhaarCardFile;
  String? address;
  String? latitude;
  String? longitude;
  String? shopType;
  String? token;

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
    "token": token,
  };
}
