// To parse this JSON data, do
//
//     final coinPojo = coinPojoFromJson(jsonString);

import 'dart:convert';

CoinPojo coinPojoFromJson(String str) => CoinPojo.fromJson(json.decode(str));

String coinPojoToJson(CoinPojo data) => json.encode(data.toJson());

class CoinPojo {
  CoinPojo({
    this.status,
    this.message,
    this.coin,
  });

  int? status;
  String? message;
  int? coin;

  factory CoinPojo.fromJson(Map<String, dynamic> json) => CoinPojo(
    status: json["status"],
    message: json["message"],
    coin: json["coin"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "coin": coin,
  };
}
