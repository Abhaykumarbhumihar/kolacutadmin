// To parse this JSON data, do
//
//     final applyLeavePojo = applyLeavePojoFromJson(jsonString);

import 'dart:convert';

ApplyLeavePojo applyLeavePojoFromJson(String str) => ApplyLeavePojo.fromJson(json.decode(str));

String applyLeavePojoToJson(ApplyLeavePojo data) => json.encode(data.toJson());

class ApplyLeavePojo {
  ApplyLeavePojo({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory ApplyLeavePojo.fromJson(Map<String, dynamic> json) => ApplyLeavePojo(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
