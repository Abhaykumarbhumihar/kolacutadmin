// To parse this JSON data, do
//
//     final notificationPojo = notificationPojoFromJson(jsonString);

import 'dart:convert';

NotificationPojo notificationPojoFromJson(String str) => NotificationPojo.fromJson(json.decode(str));

String notificationPojoToJson(NotificationPojo data) => json.encode(data.toJson());

class NotificationPojo {
  NotificationPojo({
    this.status,
    this.message,
    this.notificationDetail,
  });

  int status;
  String message;
  List<NotificationDetail> notificationDetail;

  factory NotificationPojo.fromJson(Map<String, dynamic> json) => NotificationPojo(
    status: json["status"],
    message: json["message"],
    notificationDetail: List<NotificationDetail>.from(json["Notification Detail"].map((x) => NotificationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Notification Detail": List<dynamic>.from(notificationDetail.map((x) => x.toJson())),
  };
}

class NotificationDetail {
  NotificationDetail({
    this.id,
    this.title,
    this.description,
    this.status,
    this.type,
  });

  int id;
  String title;
  String description;
  int status;
  int type;

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "type": type,
  };
}
