// To parse this JSON data, do
//
//     final graphpojjo = graphpojjoFromJson(jsonString);

import 'dart:convert';

Graphpojjo graphpojjoFromJson(String str) => Graphpojjo.fromJson(json.decode(str));

String graphpojjoToJson(Graphpojjo data) => json.encode(data.toJson());

class Graphpojjo {
  Graphpojjo({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory Graphpojjo.fromJson(Map<String, dynamic> json) => Graphpojjo(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.completedOrder,
    this.totalOrder,
  });

  int? completedOrder;
  int? totalOrder;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    completedOrder: json["completed_order"],
    totalOrder: json["total_order"],
  );

  Map<String, dynamic> toJson() => {
    "completed_order": completedOrder,
    "total_order": totalOrder,
  };
}
