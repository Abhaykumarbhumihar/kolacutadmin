// To parse this JSON data, do
//
//     final feedbackBojo = feedbackBojoFromJson(jsonString);

import 'dart:convert';

FeedbackBojo feedbackBojoFromJson(String str) => FeedbackBojo.fromJson(json.decode(str));

String feedbackBojoToJson(FeedbackBojo data) => json.encode(data.toJson());

class FeedbackBojo {
  FeedbackBojo({
    this.status,
    this.message,
    this.totalRating,
    this.ratingDetail,
  });

  int? status;
  String? message;
  int? totalRating;
  List<RatingDetail>? ratingDetail;

  factory FeedbackBojo.fromJson(Map<String, dynamic> json) => FeedbackBojo(
    status: json["status"],
    message: json["message"],
    totalRating: json["total_rating"],
    ratingDetail: List<RatingDetail>.from(json["Rating Detail"].map((x) => RatingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "total_rating": totalRating,
    "Rating Detail": List<dynamic>.from(ratingDetail!.map((x) => x.toJson())),
  };
}

class RatingDetail {
  RatingDetail({
    this.id,
    this.rating,
    this.comment,
  });

  int? id;
  int? rating;
  String? comment;

  factory RatingDetail.fromJson(Map<String, dynamic> json) => RatingDetail(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
  };
}
