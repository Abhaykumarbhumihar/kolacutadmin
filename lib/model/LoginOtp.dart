// To parse this JSON data, do
//
//     final loginOtp = loginOtpFromJson(jsonString);

import 'dart:convert';

LoginOtp loginOtpFromJson(String str) => LoginOtp.fromJson(json.decode(str));

String loginOtpToJson(LoginOtp data) => json.encode(data.toJson());

class LoginOtp {
  LoginOtp({
    this.message,
    this.otp,
  });

  String? message;
  int? otp;

  factory LoginOtp.fromJson(Map<String, dynamic> json) => LoginOtp(
    message: json["message"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "otp": otp,
  };
}
