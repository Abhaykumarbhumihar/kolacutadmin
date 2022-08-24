// To parse this JSON data, do
//
//     final myBookingPojo = myBookingPojoFromJson(jsonString);

import 'dart:convert';

MyBookingPojo myBookingPojoFromJson(String str) =>
    MyBookingPojo.fromJson(json.decode(str));

String myBookingPojoToJson(MyBookingPojo data) => json.encode(data.toJson());

class MyBookingPojo {
  MyBookingPojo({
    this.status,
    this.message,
    this.slotDetail,
  });

  int? status;
  String? message;
  List<SlotDetail>? slotDetail;

  factory MyBookingPojo.fromJson(Map<String, dynamic> json) => MyBookingPojo(
        status: json["status"],
        message: json["message"],
        slotDetail: List<SlotDetail>.from(
            json["Slot Detail"].map((x) => SlotDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Slot Detail": List<dynamic>.from(slotDetail!.map((x) => x.toJson())),
      };
}

class SlotDetail {
  SlotDetail({
    this.id,
    this.bookingId,
    this.userName,
    this.shopName,
    this.userImage,
    this.bookingDay,
    this.fromTime,
    this.toTime,
    this.date,
    this.couponCode,
    this.coin,
    this.paymentType,
    this.transactionId,
    this.service,
  });

  int? id;
  String? bookingId;
  String? userName;
  String? shopName;
  String? userImage;
  String? bookingDay;
  String? fromTime;
  String? toTime;
  DateTime? date;
  String? couponCode;
  String? coin;
  String? paymentType;
  String? transactionId;
  List<Service>? service;

  factory SlotDetail.fromJson(Map<String, dynamic> json) => SlotDetail(
        id: json["id"],
        bookingId: json["booking_id"],
        userName: json["user_name"],
        shopName: json["shop_name"],
        userImage: json["user_image"],
        bookingDay: json["booking_day"],
        fromTime: json["from_time"],
        couponCode: json["coupon_code"],
        coin: json["coin"],
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        transactionId: json["transaction_id"],
        toTime: json["to_time"],
        date: DateTime.parse(json["date"]),
        service:
            List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "user_name": userName,
        "shop_name": shopName,
        "user_image": userImage,
        "booking_day": bookingDay,
        "from_time": fromTime,
        "coupon_code": couponCode,
        "coin": coin,
        "payment_type": paymentType == null ? null : paymentType,
        "transaction_id": transactionId,
        "to_time": toTime,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "service": List<dynamic>.from(service!.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.id,
    this.name,
    this.price,
  });

  int? id;
  String? name;
  String? price;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
