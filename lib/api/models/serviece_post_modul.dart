// To parse this JSON data, do
//
//     final servicePost = servicePostFromJson(jsonString);

import 'dart:convert';

ServicePost servicePostFromJson(String str) => ServicePost.fromJson(json.decode(str));

String servicePostToJson(ServicePost data) => json.encode(data.toJson());

class ServicePost {
  String? asset;
  String? tag;
  String? commentOut;
  String? dateOut;

  ServicePost({
    this.asset,
    this.tag,
    this.commentOut,
    this.dateOut,
  });

  factory ServicePost.fromJson(Map<String, dynamic> json) => ServicePost(
    asset: json["asset"],
    tag: json["tag"],
    commentOut: json["comment_out"],
    dateOut: json["date_out"],
  );

  Map<String, dynamic> toJson() => {
    "asset": asset,
    "tag": tag,
    "comment_out": commentOut,
    "date_out": dateOut,
  };
}
