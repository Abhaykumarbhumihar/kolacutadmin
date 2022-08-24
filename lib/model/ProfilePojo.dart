// To parse this JSON data, do
//
//     final profilePojo = profilePojoFromJson(jsonString);

import 'dart:convert';

ProfilePojo profilePojoFromJson(String str) => ProfilePojo.fromJson(json.decode(str));

String profilePojoToJson(ProfilePojo data) => json.encode(data.toJson());

class ProfilePojo {
  ProfilePojo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory ProfilePojo.fromJson(Map<String, dynamic> json) => ProfilePojo(
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
    this.phone,
    this.dob,
    this.gender,
    this.profileImage,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  DateTime? dob;
  String? gender;
  String? profileImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    profileImage: json["profile image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "dob": "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "profile image": profileImage,
  };
}
