// To parse this JSON data, do
//
//     final employeeAdded = employeeAddedFromJson(jsonString);

import 'dart:convert';

EmployeeAdded employeeAddedFromJson(String str) => EmployeeAdded.fromJson(json.decode(str));

String employeeAddedToJson(EmployeeAdded data) => json.encode(data.toJson());

class EmployeeAdded {
  EmployeeAdded({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory EmployeeAdded.fromJson(Map<String, dynamic> json) => EmployeeAdded(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
