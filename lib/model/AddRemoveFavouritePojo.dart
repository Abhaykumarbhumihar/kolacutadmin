// To parse this JSON data, do
//
//     final addRemoveFavouritePojo = addRemoveFavouritePojoFromJson(jsonString);

import 'dart:convert';

AddRemoveFavouritePojo addRemoveFavouritePojoFromJson(String str) => AddRemoveFavouritePojo.fromJson(json.decode(str));

String addRemoveFavouritePojoToJson(AddRemoveFavouritePojo data) => json.encode(data.toJson());

class AddRemoveFavouritePojo {
  AddRemoveFavouritePojo({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory AddRemoveFavouritePojo.fromJson(Map<String, dynamic> json) => AddRemoveFavouritePojo(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
