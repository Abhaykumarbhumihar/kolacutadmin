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
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.dob,
    this.gender,
    this.profileImage,
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  DateTime? dob;
  String? gender;
  String? profileImage;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    profileImage: json["profile image"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "dob": "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "profile image": profileImage,
    "token": token,
  };
}
